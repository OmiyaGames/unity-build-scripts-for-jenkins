# This script uploads webplayer builds to an FTP site in a Unity Project's "Builds" folder
#
# It's based off of the Template Unity Project at BitBucket:
# https://bitbucket.org/OmiyaGames/template-unity-project

# Import modules
require 'net/ftp'
require 'string-urlize'

# Define constants
PLATFORM_STRING = ' (Web)'
VERSION = ARGV[1]
FTP_DIRECTORY = ARGV[2]
USERNAME = ARGV[3]
PASSWORD = ARGV[4]

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
		upload_folder = directory.sub(PLATFORM_STRING, '').urlize
		
		# Change it to a url-friendly name
		upload_folder = FTP_DIRECTORY + '/' + upload_folder
		
		# Determine the file name to upload this as
		upload_file = 'webplayer-v' + VERSION + '.unity3d'
		
		# Stop going through other directories
		break
	end
end

# For now, just print out a lot of stuff
puts VERSION
puts FTP_DIRECTORY
puts USERNAME
puts PASSWORD

# Make sure we have a webplayer to upload
if webplayer_file and upload_folder and upload_file

	# For now, just print out a lot of stuff
	puts webplayer_file
	puts upload_folder
	puts upload_file
end
