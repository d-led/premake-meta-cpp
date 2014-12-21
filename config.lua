local cfg = {}
-- print(os.get())
cfg.os_ = os.get()
local version_ = os.getversion()
cfg.os_version_ = string.format("%d.%d.%d",version_.majorversion,version_.minorversion,version_.revision)

cfg.location_pattern = [[Build/%o/%t]]

cfg.get_location = function (self)
	return string.gsub(
		self.location_pattern or 'Build',
		"(%%%w)", function(w)
			local substitutions = {}
			substitutions['%o'] = self.os_
			substitutions['%v'] = self.os_version_
			substitutions['%t'] = _ACTION
			return substitutions[w] or w
		end
	)
end

return cfg
