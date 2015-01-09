include '..'

config.location_pattern = [[CustomBuild/%o/%v/%t]]

lua = assert(dofile '../recipes/lua.lua')

make_solution 'test'
platforms { "native","x32", "x64" }

make_console_app('test', { 'test.cpp' })
local OS = os.get()
includedirs( lua.includedirs[OS] )
libdirs ( lua.libdirs[OS] )
links ( lua.links[OS] )
use_standard('c++11')
run_target_after_build()
