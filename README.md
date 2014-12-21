premake patterns
================

For most of my c++ projects I use [premake](https://bitbucket.org/premake/premake-dev/wiki/Home) as the meta-build system to generate platform-specific build files. This project is a collection of repeated patterns extracted from various projects to speed up the initial build environment setup.

I could have used [automake](http://www.gnu.org/software/automake/), [cmake](http://www.cmake.org/) or [QMake](http://qt-project.org/doc/qt-5.0/qtdoc/qmake-project-files.html), but the eunoia of [Lua](http://www.lua.org/), having only one small executable as your pocket knife is just too appealing.

This project includes premake binaries and is build around premake, but is otherwise not affiliated with premake development. Its primary goal is providing a number of patterns for build file locations and similar simplifications.

a quick start
-------------

Assuming, you include this project as a submodule or just copy it into the folder `premake`, with one file `test.cpp` that you want to build, prepare a `premake4.lua` file with the following contents in the root folder:

```lua
include 'premake'

make_solution 'test'
make_console_app('test', { 'test.cpp' }) 
use_standard('c++11') 
```

calling `premake/premake4 gmake` in Linux will create makefiles in the folder `Build/linux/gmake`. 

#### customizing ####

a global table `config` is available for customization. I.e.

`config.location_pattern = [[CustomBuild/%o/%v/%t]]`

before `make_solution` will customize the build file location to `CustomBuild/[os name]/[os version]/[toolchain]`. Check out [`config.lua`](config.lua) for other customization options. 

an example project
------------------

Here's a project using this component: [selfdestructing](https://github.com/d-led/selfdestructing).

premake
-------

Check out [premake](https://bitbucket.org/premake/premake-dev/wiki/Home) for more info, license and copyrights.

Binaries for Windows, Linux and Mac OS X are included in this project. See the official [premake](https://bitbucket.org/premake/premake-dev/wiki/Home) website if you want to build it or install a different version of it yourself.
