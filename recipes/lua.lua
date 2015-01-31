local lua = {
    includedirs = {
        linux = {'/usr/include/lua5.1'},
        windows = { [[C:\\luarocks\\2.1\\include]] },
        macosx = { '/usr/local/include'}
    },
    libdirs = {
        linux = {},
        windows = { [[C:\\luarocks\\2.1]] },
        macosx = { '/usr/local/lib'}
    },
    links = {
        linux = { 'lua5.1' },
        windows = { 'lua5.1' },
        macosx = { 'lua' }
    }
}

lua.set_includedirs = function(self)
    includedirs( self.includedirs[os.get()] )
end

lua.set_libdirs = function(self)
    libdirs( self.libdirs[os.get()] )
end

lua.set_links = function(self)
    links( self.links[os.get()] )
end

return lua
