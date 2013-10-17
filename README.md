premake meta c++
================

For most of my c++ projects I use premake4 as the meta-build system to generate platform-specific makefiles. This project is a collection of repeated patterns extracted from various projects to speedup the initial build environment setup.

usage
-----

Add this project as a submodule or copy as a subdirectory of your project. Considering, the folder is named `premake`, a typical `premake4.lua` configuration would look like


```lua
-- some global run-time platform-specific configuration objects
cfg = assert( require 'premake.config' )
actions = assert( require 'premake.actions' )
util = assert( require 'premake.util' )

-- prepare a solution
actions.make_solution "my_solution"

--- generate an executable project ---
actions.make_console_app(
		"my_app", -- name
		{
			"./src/*.cpp",
			"./include/*.h"
		}
)
-- extra config
includedirs {
	[[./some_lib/include]],
	[[./some_other_lib/inc]]			
}
links ( cfg.links ) -- some default links
links { "some_lib" }
```

Premake performs a linear run of the `premake4.lua` file, and many of the settings, such as build options, include directories, source files, etc., can be appended by the respective premake4 command.

To generate the makefiles or solutions run the `premake4` executable in the directory where `premake4.lua` is located.

premake4
--------

Check out [premake4 @ Industrious One](http://industriousone.com/premake) for its license and copyrights.

3 binaries - for Windows, Linux and MacOS X are included in this project. See the official premake4 website if you want to build it or install a different version of it yourself.
