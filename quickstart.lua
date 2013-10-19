cfg = assert( require 'premake.config' )
actions = assert( require 'premake.actions' )
util = assert( require 'premake.util' )

_G.make_solution = actions.make_solution
_G.make_console_app = actions.make_console_app
_G.make_static_lib = actions.make_static_lib
_G.make_shared_lib = actions.make_shared_lib
_G.run_target_after_build = actions.run_target_after_build
_G.make_cpp11 = actions.make_cpp11
