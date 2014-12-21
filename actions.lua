_G.package.path=[[./?.lua;./?/?.lua;]].._G.package.path

local config = require 'config'
local actions = {
	make_project = function (project_type,name,files_,language_)
		project(name)
		kind(project_type)
		files(files_)
		language(language_ or 'C++')
	end

	,

	make_solution = function (name)
		solution(name)

		if config.get_location then 
			location ( config:get_location() )
		else
			location ( 'Build' )
		end

		configurations ( config.configurations or { 'Debug', 'Release' } )
		platforms ( config.platforms or { "x32", "x64" } )
	end
}

----------------------------------------------------------------------------------------------------------------
actions.make_static_lib = function(name,files_)
	actions.make_project("StaticLib",name,files_)
end
----------------------------------------------------------------------------------------------------------------
actions.make_shared_lib = function(name,files_)
	actions.make_project("SharedLib",name,files_)
end
----------------------------------------------------------------------------------------------------------------
actions.make_console_app = function (name,files_)
	actions.make_project("ConsoleApp",name,files_)
end
----------------------------------------------------------------------------------------------------------------
actions.run_target_after_build = function ()
	configuration {"xcode*" }
		postbuildcommands {"$TARGET_BUILD_DIR/$TARGET_NAME"}

	configuration {"gmake"}
		postbuildcommands  { "$(TARGET)" }

	configuration {"macosx"}
		postbuildcommands  { "$(TARGET)" }

	configuration {"codeblocks" }
		postbuildcommands { "$(TARGET_OUTPUT_FILE)"}

	configuration { "vs*"}
		postbuildcommands { "\"$(TargetPath)\"" }

	configuration { "*" }
end
----------------------------------------------------------------------------------------------------------------
actions.use_standard = function (standard)
	configuration {"gmake"}
		buildoptions { "-std="..standard }

	configuration { "*" }
end
actions.make_cpp11 = function() actions.use_standard("c++11") end
----------------------------------------------------------------------------------------------------------------

return actions
