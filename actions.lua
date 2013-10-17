----------------------------------------------------------------------------------------------------------------

-- Apply to current "filter" (solution/project)
local actions = {
	DefaultConfig = function ()
		location( cfg.location )
		configuration "Debug"
			defines { "DEBUG", "_DEBUG" }
			objdir( path.join(cfg.location, path.join("Debug", "obj") ) )
			targetdir ( cfg.debug_target_dir )
			flags { "Symbols" }
		configuration "Release"
			defines { "RELEASE" }
			objdir( path.join(cfg.location, path.join("Release", "obj") ) )
			targetdir( cfg.release_target_dir )
			flags { "Optimize" }
		configuration "*" -- to reset configuration filter
	end

	,

	CompilerSpecificConfiguration = function ()
		configuration {"xcode*" }

		configuration {"gmake"}
			buildoptions( cfg.buildoptions )

		configuration {"codeblocks" }

		configuration { "vs*"}
	        defines {
	            "_VARIADIC_MAX=10"
	        }

	        buildoptions {
	        	"/bigobj"
	    	}

	        flags {
	        	"NoEditAndContinue"
	    	}

		configuration { "macosx" }
			defines { 
				"GTEST_USE_OWN_TR1_TUPLE=1"
			}

		configuration { "*" }
	end

	,

	----------------------------------------------------------------------------------------------------------------

	make_project = function (project_type,name,files_,extras)
		project(name)
		location( cfg.location )
			kind(project_type)
			actions.DefaultConfig()
			language "C++"
			files (files_)
			actions.CompilerSpecificConfiguration()

			if type(extras)=="function" then
				extras()
			end
	end

	,

	make_solution = function(name)
		-- A solution contains projects, and defines the available configurations
		solution (name)
			location( cfg.location )
				configurations { "Debug", "Release" }
				platforms { "native" }
				libdirs ( cfg.libdirs )
				includedirs ( cfg.includedirs )
				includedirs { 
					[[./cppspec/include]],
					[[./googlemock/fused-src]],
					[[./cucumber-cpp/include]]
				}
				vpaths {
					["Headers"] = {"**.h","**.hpp"},
					["Sources"] = {"**.c", "**.cpp"},
				}
	end
}
----------------------------------------------------------------------------------------------------------------
actions.make_static_lib = function(name,files_,extras)
	actions.make_project("StaticLib",name,files_,extras)
end
----------------------------------------------------------------------------------------------------------------
actions.make_console_app = function (name,files_,extras)
	actions.make_project("ConsoleApp",name,files_,extras)
end
----------------------------------------------------------------------------------------------------------------

return actions