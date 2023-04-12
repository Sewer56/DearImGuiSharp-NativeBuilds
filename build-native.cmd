@setlocal
@echo off

set CIMGUI_ROOT=%~dp0cimgui
set BUILD_CONFIG=Debug
set BUILD_ARCH=x64
set BUILD_CMAKE_GENERATOR_PLATFORM=x64

:ArgLoop
if [%1] == [] goto Build
if /i [%1] == [Release] (set BUILD_CONFIG=Release&& shift & goto ArgLoop)
if /i [%1] == [Debug] (set BUILD_CONFIG=Debug&& shift & goto ArgLoop)
if /i [%1] == [x64] (set BUILD_ARCH=x64&& shift & goto ArgLoop)
if /i [%1] == [ARM64] (set BUILD_ARCH=ARM64&& set BUILD_CMAKE_GENERATOR_PLATFORM=ARM64 && shift & goto ArgLoop)
if /i [%1] == [ARM] (set BUILD_ARCH=ARM&& set BUILD_CMAKE_GENERATOR_PLATFORM=ARM && shift & goto ArgLoop)
if /i [%1] == [x86] (set BUILD_ARCH=x86&& set BUILD_CMAKE_GENERATOR_PLATFORM=Win32 && shift & goto ArgLoop)
shift
goto ArgLoop

:Build
pushd %CIMGUI_ROOT%

If NOT exist ".\build\%BUILD_ARCH%" (
  mkdir build\%BUILD_ARCH%
)
pushd build\%BUILD_ARCH%
set "IMPLEMENTATIONS=-DIMPL_DX11=ON -DIMPL_DX12=ON -DIMPL_DX9=ON -DIMPL_OGL2=ON -DIMPL_OGL3=ON -DIMPL_WIN32=ON"

if not "%BUILD_ARCH%" == "ARM64" (
 if not "%BUILD_ARCH%" == "ARM" (
  set "IMPLEMENTATIONS=%IMPLEMENTATIONS% -DIMPL_GLFW=ON -DIMPL_SDL2=ON -DIMPL_VULKAN=ON"
 )
)

echo Calling cmake %IMPLEMENTATIONS% -DCMAKE_GENERATOR_PLATFORM=%BUILD_CMAKE_GENERATOR_PLATFORM% ..\..
cmake %IMPLEMENTATIONS% -DCMAKE_GENERATOR_PLATFORM=%BUILD_CMAKE_GENERATOR_PLATFORM% ..\..

echo Calling cmake --build . --config %BUILD_CONFIG%
cmake --build . --config %BUILD_CONFIG%
popd
popd

:Success
exit /b 0

