-- an evil shortcut
local function make_global(name)
	local m = assert( require(name) )
	_G[name] = m
	for entry_name,value in pairs(m) do
		_G[entry_name] = value
	end
end

for _,name in ipairs {
	'config',
	'actions',
	'release'
} do
	make_global(name)
end
