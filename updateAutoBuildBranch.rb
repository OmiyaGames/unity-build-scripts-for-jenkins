# Import mercurial
require 'win32-process'
require 'mercurial-ruby'

# Configure Mercurial to the proper location
Mercurial.configure do |conf|
  conf.hg_binary_path = 'C:\Program Files\TortoiseHg\hg.exe'
end

# Setup constant values
BRANCH = 'autobuild'
DIRECTORY = ARGV[0]
REVISION = ARGV[1]
TAG = ARGV[2]

# For debugging, print all values
puts BRANCH
puts DIRECTORY
puts REVISION
puts TAG

# Create a new repository
repository = Mercurial::Repository.create(DIRECTORY)
