_G.package.path=[[./?.lua;./?/?.lua;]].._G.package.path
local config = require 'config'
local actions = {
	make_project = function (project_type,name,files_)
		project(name)
		kind(project_type)
		files(files_)
	end

	,

	make_solution = function (name)
		solution (name)
		configurations ( config.configurations or { 'Debug', 'Release' } )
		platforms ( config.platforms or { 'Win32', 'Win64' } )
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
actions.use_standard = function (standard)
	configuration {"gmake"}
		buildoptions { "-std="..standard }

	configuration { "*" }
end

return actions