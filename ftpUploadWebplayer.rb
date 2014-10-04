# This script uploads webplayer builds to an FTP site in a Unity Project's "Builds" folder
#
# It's based off of the Template Unity Project at BitBucket:
# https://bitbucket.org/OmiyaGames/template-unity-project

# Import modules
require 'net/ftp'
require 'to_slug'

# Define constants
PLATFORM_STRING = ' (Web)'
FTP_URL = ARGV[1]
USERNAME = ARGV[2]
PASSWORD = ARGV[3]
VERSION = ARGV[4]

# Change directory
Dir.chdir(ARGV[0])

# Find all directories in this folder
puts 'Searching for a webplayer build...'
webplayer_file = nil
upload_folder = nil
upload_file = nil
for directory in Dir['*']
	
	# Check if file is a webplayer directory
	if File.directory?(directory) and directory.end_with?(PLATFORM_STRING)
		
		# Grab the name of the file in the directory
		webplayer_file = directory + '/' + directory + '.unity3d'
		
		# Grab the folder name to upload to
		upload_folder = directory.sub(PLATFORM_STRING, '').to_slug
		
		# Determine the file name to upload this as
		upload_file = 'webplayer-v' + VERSION.to_slug + '.unity3d'
		
		# Stop going through other directories
		break
	end
end

# Make sure we have a webplayer to upload
if webplayer_file and upload_folder and upload_file

	# Go to the FTP site
	puts "Webplayer \"#{webplayer_file}\" found!"
	puts "Connecting to #{FTP_URL}..."
	Net::FTP.open(FTP_URL, USERNAME, PASSWORD) do |ftp|
		
		#Indicate we connected to the FTP site
		puts "Connected to #{FTP_URL}!"
		
		# Check if the folder to upload already exists
		puts "Checking if remote directory \"#{upload_folder}\" already exists..."
		folder_already_exists = false
		for directory in ftp.nlst
			if directory == upload_folder
				folder_already_exists = true
				break
			end
		end
		
		# Create the folder remotely, if it hasn't already
		if folder_already_exists
			puts "Remote directory \"#{upload_folder}\" exists!"
		else
			puts "Remote directory \"#{upload_folder}\" doesn't exist. Creating \"#{upload_folder}\"..."
			ftp.mkdir(upload_folder)
			puts "Created \"#{upload_folder}\"!"
		end
		
		# Change to this directory
		puts "Changing remote directory to \"#{upload_folder}\"..."
		ftp.chdir(upload_folder)
		puts "Changed to \"#{upload_folder}\"!"
		
		# Upload the new webplayer
		puts "Uploading webplayer \"#{webplayer_file}\" as \"#{upload_file}\"..."
		#uploaded_byte = 0
		ftp.putbinaryfile(webplayer_file, upload_file)
		puts "Upload \"#{upload_file}\" complete!"
	end
else
	# Indicate there were no webplayers found
	puts 'No webplayer found! Ending FTP upload process...'
end

# Indicate completion
puts 'FTP upload process complete!'
