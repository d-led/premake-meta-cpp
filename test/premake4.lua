include '..'

config.location_pattern = [[CustomBuild/%o/%v/%t]]

make_solution 'test'
platforms { "native","x32", "x64" }
make_console_app('test', { 'test.cpp' }) 
use_standard('c++11') 
run_target_after_build()
