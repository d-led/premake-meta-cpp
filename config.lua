local cfg = {}
-- print(os.get())
cfg.os_ = os.get()
local version_ = os.getversion()
cfg.os_version_ = string.format("%d.%d.%d",version_.majorversion,version_.minorversion,version_.revision)

cfg.location_pattern = [[Build/%o/%t]]
cfg.binaries_pattern = [[bin/%o/%t/%p/%c]]
cfg.objects_pattern = [[obj/%o/%t/%p/%c/%P]]

cfg.substitutions_ = {}
cfg.substitutions_['%o'] = cfg.os_
cfg.substitutions_['%v'] = cfg.os_version_
cfg.substitutions_['%t'] = _ACTION
cfg.substitutions_['%p'] = ''
cfg.substitutions_['%c'] = ''
cfg.substitutions_['%P'] = ''

cfg.get_location = function (self)
	return string.gsub(
		self.location_pattern or 'Build',
		"(%%%w)", function(w)
			return self.substitutions_[w] or w
		end
	)
end

cfg.get_binaries_location = function (self,platform_,config_)
	cfg.substitutions_['%p'] = platform_ or ''
	cfg.substitutions_['%c'] = config_ or ''
	return string.gsub(
		self.binaries_pattern or 'bin',
		"(%%%w)", function(w)
			return self.substitutions_[w] or w
		end
	)
end

cfg.get_objects_location = function (self,platform_,config_,project_)
	cfg.substitutions_['%p'] = platform_ or ''
	cfg.substitutions_['%c'] = config_ or ''
	cfg.substitutions_['%P'] = project_ or ''
	return string.gsub(
		self.objects_pattern or 'obj',
		"(%%%w)", function(w)
			return self.substitutions_[w] or w
		end
	)
end

return cfg
