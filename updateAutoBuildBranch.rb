# Import modules
#require 'IO'

# Setup constant values
BRANCH_NAME = 'autobuild'
REVISION = ARGV[0]
TAG = ARGV[1]

# Run "hg branches"
all_branches = IO.popen(['hg', 'branches'])

# Read the output
does_branch_autobuild_exist = false
for branch in all_branches.readlines
  
  # Check if branch autobuild exists
  if branch.start_with? BRANCH_NAME
  
    # If it does, indicate so
    does_branch_autobuild_exist = true
    break
  end
end

# Close the command
all_branches.close

system("hg up testing")

# Check if branch autobuild exists
if does_branch_autobuild_exist
  
  # If it does, switch to this branch
  #system("hg up #{BRANCH_NAME}")
  
  # Merge the changes from default, up to revision
  #system("hg up #{BRANCH_NAME}")
else
end

p does_branch_autobuild_exist

