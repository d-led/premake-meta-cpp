local boost = {
    links = {
        linux = { 'boost_system', 'pthread' },
        windows = { },
        macosx = { 'boost_system' }
    },
    
    libdirs = {
        linux = {},
        windows = {},
        macosx = { '/usr/local/lib' }
    },

    includedirs = {
        linux = {},
        windows = { os.getenv 'BOOST' },
        macosx = { '/usr/local/include' }
    },

    libdirs_pattern = {
        linux = '',
        windows = [[%b/lib%p-%t-%v]],
        macosx = ''
    },

    defines = {
        linux = {},
        windows = {
        	'_WIN32_WINNT=0x0501',
			'WIN32',
        },
        macosx = {}
    },
}

boost.set_links = function(self)
    links( self.links[os.get()] )
end

boost.set_defines = function(self)
    defines( self.defines[os.get()] )
end

boost.set_includedirs = function(self)
    includedirs( self.includedirs[os.get()] )
end

boost.set_libdirs = function(self)
    local action = _ACTION
    local OS = os.get()
    local vs = tonumber(string.match(action,'vs20(%d+)'))

    if not vs then
        libdirs(self.libdirs[OS])
        return
    end

    local vc = tostring(vs-1)..'.0'

    local render = function(pl)
        local substitutions = {
            ['%b'] = os.getenv 'BOOST',
            ['%p'] = pl,
            ['%t'] = 'msvc',
            ['%v'] = vc
        }

        local res = string.gsub(
            self.libdirs_pattern[OS],
            "(%%%w)", function(w)
                return substitutions[w] or w
            end
        )
        print(res)
        return res
    end

    local pl = { '32', '64' }
    for _,p in ipairs(pl) do
        configuration { 'x'..p } --no mingw yet
            local r = render(p)
            if #r > 0 then
                libdirs(r)
            end
        configuration '*'
    end
end

return boost
