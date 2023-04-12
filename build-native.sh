#!/usr/bin/env bash

scriptPath="`dirname \"$0\"`"
cimguiPath=$scriptPath/cimgui

_CMakeBuildType=Debug
_CMakeOsxArchitectures=

while :; do
    if [ $# -le 0 ]; then
        break
    fi

    lowerI="$(echo $1 | awk '{print tolower($0)}')"
    case $lowerI in
        debug|-debug)
            _CMakeBuildType=Debug
            ;;
        release|-release)
            _CMakeBuildType=Release
            ;;
        -osx-architectures)
            _CMakeOsxArchitectures=$2
            shift
            ;;
        *)
            __UnprocessedBuildArgs="$__UnprocessedBuildArgs $1"
    esac

    shift
done

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	sudo apt install libsdl2-dev # Assuming Ubuntu
	sudo apt install libglfw3-dev
elif [[ "$OSTYPE" == "darwin"* ]]; then
	brew install sdl2 sdl2_image sdl2_mixer sdl2_net sdl2_ttf # Mac OSX
	brew install glfw
fi

mkdir -p $cimguiPath/build/$_CMakeBuildArch/$_CMakeBuildType
pushd $cimguiPath/build/$_CMakeBuildArch/$_CMakeBuildType
implementations="-DIMPL_OGL3=ON -DIMPL_VULKAN=ON"

# If we aren't on OSX, we can build a few more things.
if [ -z "$_CMakeOsxArchitectures" ]; then
	implementations="$implementations -DIMPL_OGL2=ON -DIMPL_GLFW=ON -DIMPL_SDL2=ON"
fi

cmake $implementations -DCMAKE_OSX_ARCHITECTURES="$_CMakeOsxArchitectures" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.13 -DCMAKE_BUILD_TYPE=$_CMakeBuildType ../..
cmake --build .
popd
