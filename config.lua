local cfg = {}
-- print(os.get())
cfg.os_ = os.get()

cfg.location_pattern = [[Build/%o/%t]]

cfg.get_location = function (self)
	print(self.location_pattern)
	return string.gsub(
		self.location_pattern or 'Build',
		"(%%%w)", function(w)
			local substitutions = {}
			substitutions['%o'] = self.os_
			substitutions['%t'] = _ACTION
			return substitutions[w] or w
		end
	)
end

return cfg
