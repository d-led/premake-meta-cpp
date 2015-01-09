local patterns = {}

patterns.make_package = function(files_to_package,filename_without_extension)
	print 'package with: premake4 package'
	newaction {
	        trigger     = 'package',
	        description = 'prepare a binary release',
	        execute     = function ()
	        	local command = 'tar -cvpzf '..
	        					filename_without_extension ..
	        					'.tar.gz ' ..
	        					table.concat( files_to_package, ' ')
	            os.execute(command)
	        end
	}
end

return patterns
