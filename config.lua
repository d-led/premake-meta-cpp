_G.package.path=_G.package.path..[[;./?.lua;./?/?.lua]]
local OS=os.get()

local cmd	=	{
	dir = {
  		linux = "ls",
		windows = "dir",
		macosx = "ls"
	},
 	libdirs = {
 		linux = { "" },
        windows = { path.join(os.getenv("BOOST"),path.join("stage","lib")) },
 		macosx = { "" }
 	},
	includedirs = {
		linux = { "" },
		windows = { os.getenv("BOOST") },
		macosx = { "" }
	},
	location = {
		linux = "Build",
		windows = "Build",
		macosx = "BuildClang"
	},
 	buildoptions = { -- can be concatenated : http://industriousone.com/buildoptions
 		linux = "-v -fPIC",
 		windows = "-v -fPIC", -- -std=c++11
 		macosx = "-v  -fPIC" -- -stdlib=libc++ -std=c++11
 	},
 	links = {
 		linux = { "pthread" },
 		windows = { },
 		macosx = { "c++" }
 	},
 	defines = {
 		linux = { },
 		windows = { "_WIN32_WINDOWS" },
 		macosx = { }
 	}
}

local cfg={}

for i,v in pairs(cmd) do
 cfg[i]=cmd[i][OS]
end

cfg.debug_target_dir = path.join( os.get(), path.join('bin','Debug') )
cfg.release_target_dir = path.join( os.get(), path.join('bin','Release') )

return cfg