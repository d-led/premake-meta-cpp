_G.package.path=_G.package.path..[[;./?.lua;../?.lua;../?/?.lua]] 
assert( require 'quickstart' ) 
make_solution 'test'
make_console_app('test', { 'test.cpp' }) 
use_standard('c++11') 
