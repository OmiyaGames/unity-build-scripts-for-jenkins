# Import modules
require 'zip'

# Change directory
Dir.chdir(ARGV[0])

# Find all directories in this folder
for directory in Dir['*']
	
	# Check if file is a directory
	if File.directory?(directory)
		
		Zip::File.open("#{directory}.zip", Zip::File::CREATE) do |zipfile|
			Dir[File.join(directory, '**', '**')].each do |file|
				zipfile.add(file, file)
			end
		end
		puts directory
	end
end
