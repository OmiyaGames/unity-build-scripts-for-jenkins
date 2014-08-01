# Import modules
#require 'IO'

# Setup constant values
MERCURIAL = 'C:\Program Files\TortoiseHg\hg.exe'
BRANCH = 'autobuild'
REVISION = ARGV[0]
TAG = ARGV[1]

# For debugging, print all values
puts BRANCH
puts REVISION
puts TAG

# Check all the branches
allbranches = IO.popen([MERCURIAL, 'branch'])
puts allbranches.readlines
