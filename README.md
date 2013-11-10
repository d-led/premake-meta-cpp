**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [premake meta c++](#premake-meta-c++)
	- [super quick start](#super-quick-start)
	- [normal usage](#normal-usage)
	- [a quick start](#a-quick-start)
	- [an example project](#an-example-project)
	- [premake4](#premake4)

premake meta c++
================

For most of my c++ projects I use premake4 as the meta-build system to generate platform-specific makefiles. This project is a collection of repeated patterns extracted from various projects to speedup the initial build environment setup.

I could have used [automake](http://www.gnu.org/software/automake/), [cmake](http://www.cmake.org/) or [QMake](http://qt-project.org/doc/qt-5.0/qtdoc/qmake-project-files.html), but the eunoia of [Lua](http://www.lua.org/), having only one small executable as your pocket knife is just too appealing.

super quick start
-----------------

Download [new_cpp.sh](https://raw.github.com/d-led/premake-meta-cpp/master/new_cpp.sh) or [new_cpp.bat](https://raw.github.com/d-led/premake-meta-cpp/master/new_cpp.bat) and make it globally executable.

- `new_cpp.sh project_name` to make the directory, init a git repo, add the premake submodule, the quickstart config and the first source file
- Change into the created directory
- `premake4 _build_system_` to generate your make or project files
- Build

normal usage
------------

Add this project as a submodule or copy as a subdirectory of your project. Considering, the folder is named `premake`, a typical `premake4.lua` configuration would look like


```lua
_G.package.path=_G.package.path..[[;./?.lua;./?/?.lua]]
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

The makefiles or solutions will be put into the `BuildClang` folder on MacOS X and `Build` otherwise.

a quick start
-------------

A yet more compact slice of premake patterns is `quickstart.lua`, allowing yet simpler project definitions by declaring the actions globally. Other premake4 commands are still usable normally. Example, showing all globally available pattern functions and the standard premake4 function `links` in action:

```lua
_G.package.path=_G.package.path..[[;./?.lua;./?/?.lua]]
assert( require 'premake.quickstart' )

make_solution 'my_lib'
make_static_lib( 'my_lib', './src/my_lib.cpp')
make_console_app( 'test', './src/test.cpp' )
links { 'my_lib' }
make_cpp11()
run_target_after_build()
```

an example project
------------------

Here's a project using this component: [selfdestructing](https://github.com/d-led/selfdestructing).

premake4
--------

Check out [premake4 @ Industrious One](http://industriousone.com/premake) for its license and copyrights.

3 binaries - for Windows, Linux and MacOS X are included in this project. See the official premake4 website if you want to build it or install a different version of it yourself.
