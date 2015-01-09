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

return lua
