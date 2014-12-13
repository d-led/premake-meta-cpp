-- an evil shortcut
local function make_global(m)
	for k,v in pairs(m) do
		_G[k] = v
	end
end
local config = assert( require 'config' )
local actions = assert( require 'actions' )
make_global ( config )
make_global ( actions )
