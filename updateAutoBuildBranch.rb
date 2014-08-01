# Setup constant values
BRANCH_NAME = 'autobuild'
REVISION = ARGV[0]
TAG_MESSAGE = ARGV[1]

# Define helper methods
def run_command(command)
	puts "> #{command}"
	system(command)
end

# Run "hg branches"
puts '> hg branches'
all_branches = IO.popen(['hg', 'branches'])

# Read the output
does_branch_autobuild_exist = false
for branch in all_branches.readlines

	# Check if branch autobuild exists
	puts branch
	if branch.start_with? BRANCH_NAME

		# If it does, indicate so
		puts '* Branch autobuild found!'
		does_branch_autobuild_exist = true
		break
	end
end

# Close the command
puts '* Stop branches process'
all_branches.close

# Check if branch autobuild exists
if does_branch_autobuild_exist

	# If it does, switch to this branch
	run_command("hg up #{BRANCH_NAME}")

	# Merge the changes from default, up to revision
	run_command("hg merge -r #{REVISION} default")

	# Commit the changes from default, up to revision
	run_command("hg commit -m \"Merging the default branch up to revision #{REVISION}.\"")
else

	# If it does not, create a new branch
	run_command("hg branch #{BRANCH_NAME}")

	# Commit the changes from default, up to revision
	run_command("hg commit -m \"Branching from the default branch at revision #{REVISION}.\"")
end

# Tag this revision
run_command("hg tag -f \"#{TAG_MESSAGE}\"")

# Check if branch autobuild exists
if does_branch_autobuild_exist

	# Push changes
	run_command("hg push")
else

	# Push changes to the new branch
	run_command("hg push --new-branch -b #{BRANCH_NAME}")
end
