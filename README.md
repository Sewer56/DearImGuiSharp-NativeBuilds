## To Create a Release

Push a tag.

```
git tag -a 1.88 -m "Release 1.88"
git push origin 1.88
```

## To Update cimgui

Init the repo.  
```
git submodule update --init
```

Update the branch (you might want to change branch, my forks does different branches for releases).  
```
git submodule update --remote
```

And then commit + push.

## Implementations Included

Includes the following backends and imgui internal API, where available:  

- Win32  
- Direct3D 9  
- Direct3D 11  
- Direct3D 12  
- OpenGL 2  
- OpenGL 3  
- GLFW  
- SDL2  
- Vulkan  


Stuff Missing:  
- OSX X64: Missing SDL, OpenGL 2, GLFW.  
- Windows ARM/ARM64: Missing Vulkan, GLFW & SDL.  
- OSX ARM64: Currently not building in CI.  [Can build OpenGL 3 only atm.]  

If you'd like those, please file a PR, it was a good bit of effort to get this stuff building at all in the first place.  

## Credits

Forked from [https://github.com/mellinoe/ImGui.NET-nativebuild](https://github.com/mellinoe/ImGui.NET-nativebuild).  