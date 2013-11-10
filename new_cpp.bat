@echo off
mkdir %1
cd %1

git init
git submodule add https://github.com/d-led/premake-meta-cpp.git premake
git submodule init
git submodule update

echo _G.package.path=_G.package.path..[[;./?.lua;./?/?.lua]] >> premake4.lua
echo assert( require 'premake.quickstart' ) >> premake4.lua
echo make_solution '%1' >> premake4.lua
echo make_console_app('%1', { '%1.cpp' }) >> premake4.lua
echo make_cpp11() >> premake4.lua

echo int main() {} >> %1.cpp
