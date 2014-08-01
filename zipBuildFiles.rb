# Import modules
require 'zip'

# Change directory
Dir.chdir(ARGV[0])

# Find all directories in this folder
for file in Dir['*']
	if File.directory?(file)
		puts file
	end
end
