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
FTP_DIRECTORY = ARGV[5]

# Change directory
Dir.chdir(ARGV[0])

# Find all directories in this folder
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
		upload_file = 'webplayer-v' + VERSION + '.unity3d'
		
		# Stop going through other directories
		break
	end
end

# For now, just print out a lot of stuff
puts FTP_URL
puts FTP_DIRECTORY
puts USERNAME
puts PASSWORD
puts VERSION

# Make sure we have a webplayer to upload
if webplayer_file and upload_folder and upload_file

	# For now, just print out a lot of stuff
	puts webplayer_file
	puts upload_folder
	puts upload_file
	
	# Go to the FTP site
	Net::FTP.open(FTP_URL, USERNAME, PASSWORD) do |ftp|
		
		# Change directory (if necessary
		if !(FTP_DIRECTORY.nil? or FTP_DIRECTORY.empty?)
			ftp.chdir(FTP_DIRECTORY)
		end
		
		# Check if the folder to upload already exists
		folder_already_exists = false
		for directory in ftp.nlst
			if directory == upload_folder
				folder_already_exists = true
				break
			end
		end
		
		# Create the folder remotely, if it hasn't already
		ftp.mkdir(upload_folder) unless folder_already_exists
		
		# Change to this directory
		ftp.chdir(upload_folder)
		
		# Upload the new webplayer
		ftp.putbinaryfile(webplayer_file, upload_file)
	end
end
