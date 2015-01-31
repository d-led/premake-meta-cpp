include '..'

config.location_pattern = [[CustomBuild/%o/%v/%t]]

lua = assert(dofile '../recipes/lua.lua')
boost = assert(dofile '../recipes/boost.lua')

-------------
make_solution 'test'

platforms { "native","x32", "x64" }

boost:set_defines()
boost:set_includedirs()
boost:set_libdirs()
lua:set_includedirs()
lua:set_libdirs()

----------------
make_console_app('test', { 'test.cpp' })

boost:set_links()
lua:set_links()

use_standard('c++11')

run_target_after_build()
