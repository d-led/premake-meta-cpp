if path == nil then
	path = {}
end
if path.join == nil then
	path.join = function(p1,p2)
		return p1..'/'..p2 -- cheap
	end
end

if os == nil then
	os = {}
end
if os.get == nil then
	os.get = function ()
		local function normalize_windows_name(n)
			if n:find 'windows' == 1 then
				return 'windows'
			end
			return n
		end
		local res = io.popen('uname'):read("*l")
		res = normalize_windows_name(res)
		if res then return res end -- cheap
		return "windows"
	end
end

if os.getcwd == nil then
	os.getcwd = function()
		if os.get() == "linux" then
			return io.popen'pwd':read'*l'
		else
			local lfs = require 'lfs'
			return lfs.currentdir()
		end
	end
end

if not os.chdir then
	local lfs = require 'lfs'
	os.chdir = lfs.chdir
end

function file_exists(name)
	local f=io.open(name,"r")
	if f~=nil then io.close(f) return true else return false end
end

local function normalize_executable_path(p)
	if os.get() == "windows" then
		return p:gsub('/','\\')..".exe"
	end
	return p
end

local util = {
	file_exists = file_exists,
	normalize_executable_path = normalize_executable_path
}

util.start_test_of = function(executable)
	local debug_path = normalize_executable_path( path.join( "bin/Debug" , executable ) )
	local release_path = normalize_executable_path( path.join( "bin/Release" , executable ) )
	print(debug_path)

	if file_exists( debug_path ) then
		os.execute( debug_path )
	end
	if file_exists( release_path ) then
		os.execute( release_path )
	end
end

util.start_cucumber_for = function(path_,executable)
	local od = os.getcwd()
	local p = path.join(od,path_)
	os.chdir(p)
	if os.get() == "linux" or os.get() == "Darwin" or os.get() == "macosx" then
		local command = executable.." > /dev/null & cucumber"
		os.execute( command )
    elseif os.get() == "windows" then
        os.execute("start /B "..executable)
        os.execute( "cucumber" )
	end
	os.chdir( od )
end

util.start_cucumber = function(configuration)
	assert( type(configuration) == "table" )
	local od = os.getcwd()
	
	if type(configuration.start_in) == "string" then
		local p = path.join(od,configuration.start_in)
		os.chdir(p)
	end
	
	assert( type(configuration.executable) == "string" )

	local feature = ''
	if type(configuration.feature) == "string" then
		feature = ' ' .. configuration.feature
	end

	if os.get() == "linux" or os.get() == "Darwin" or os.get() == "macosx" then
		local command = configuration.executable.." > /dev/null & cucumber" .. feature
		os.execute( command )
    elseif os.get() == "windows" then
        os.execute("start /B "..executable)
        os.execute( "cucumber" .. feature )
	end
	os.chdir( od )
end

return util
