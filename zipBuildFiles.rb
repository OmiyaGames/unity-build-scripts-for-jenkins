# Import modules
require 'zip'

# Define constants
PLATFORM_STRINGS = [' (Windows 32-bit)', \
					' (Windows 64-bit)', \
					' (Mac 32-bit)', \
					' (Mac 64-bit)', \
					' (Linux 32-bit)', \
					' (Linux 64-bit)', \
					' (Web)']

# Change directory
Dir.chdir(ARGV[0])

def get_application_name(directory)
	for platform in PLATFORM_STRINGS
		if directory.end_with?(platform)
			return directory.sub(platform, '')
		end
	end
end

# Find all directories in this folder
for directory in Dir['*']
	
	# Check if file is a directory
	if File.directory?(directory)
		
		# Retrieve the application name for this directory
		application_name = get_application_name(directory)
		zip_file_name = "#{directory}.zip"
		# Create a zip file
		Zip::File.open(zip_file_name, Zip::File::CREATE) do |zipfile|
			
			# Traverse recursively through all files
			Dir[File.join(directory, '**', '**')].each do |file|
			
				# Replace the top-level directory name with the application's name
				zipfile.add(file.sub(directory, application_name), file)
			end
		end
		
		# Indicate the zip file that was created
		puts "> Created: " + zip_file_name
	end
end
