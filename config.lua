local cfg = {}
-- print(os.get())
cfg.os_ = os.get()
local version_ = os.getversion()
cfg.os_version_ = string.format("%d.%d.%d",version_.majorversion,version_.minorversion,version_.revision)

cfg.location_pattern = [[Build/%o/%t]]
cfg.binaries_pattern = [[bin/%o/%t]]

cfg.substitutions_ = {}
cfg.substitutions_['%o'] = cfg.os_
cfg.substitutions_['%v'] = cfg.os_version_
cfg.substitutions_['%t'] = _ACTION

cfg.get_location = function (self)
	return string.gsub(
		self.location_pattern or 'Build',
		"(%%%w)", function(w)
			return self.substitutions_[w] or w
		end
	)
end

cfg.get_binaries_location = function (self)
	return string.gsub(
		self.binaries_pattern or 'bin',
		"(%%%w)", function(w)
			return self.substitutions_[w] or w
		end
	)
end

return cfg
