_G.package.path=[[./?.lua;./?/?.lua;]].._G.package.path

local config = require 'config'
local actions = {}

actions.default_config = function ()
	configuration "Debug"
		defines { "DEBUG", "_DEBUG" }
		flags { "Symbols" }
	configuration "Release"
		defines { "RELEASE" }
		flags { "Optimize" }
	configuration "*" -- reset configuration filter

	if config.get_objects_location then
		local project_name = project().name
		objdir ( config:get_objects_location('','',project_name) )
		for _, plat_ in ipairs(platforms() or {''}) do
			for __, config_ in ipairs(configurations()) do
			    configuration { plat_, config_ }
			    	local loc_ = config:get_objects_location(plat_,config_,project_name)
			    	print (loc_)
			        objdir ( loc_ )
			end
		end
	end
	configuration "*" --reset
end

actions.make_project = function (project_type,name,files_,language_)
	project(name)
	kind(project_type)
	files(files_)
	language(language_ or 'C++')
	actions.default_config()
end

actions.make_solution = function (name)
	solution(name)

	------------------------------------
	configurations ( config.configurations or { 'Debug', 'Release' } )
	platforms ( config.platforms or { "x32", "x64" } )

	------------------------------------
	if config.get_location then 
		location ( config:get_location() )
	else
		location ( 'Build' )
	end

	------------------------------------
	if config.get_binaries_location then
		targetdir ( config:get_binaries_location() )
		for _, plat_ in ipairs(platforms() or {''}) do
			for __, config_ in ipairs(configurations()) do
			    configuration { plat_, config_ }
			        targetdir ( config:get_binaries_location(plat_,config_) )
			end
		end
	end
	configuration "*" --reset
end

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
