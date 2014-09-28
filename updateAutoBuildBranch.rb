# This script merges any changes in the branch Jenkins cloned into the "autobuild" branch,
# and tags it with a simple message.
#
# If the repository doesn't have an "autobuild" branch yet,
# this script will automatically create one before tagging it.

# Setup constant values
BRANCH_NAME = 'autobuild'
revision = nil
tagMessage = nil
if ARGV.length == 1
	tagMessage = ARGV[0]
elsif ARGV.length > 1
	revision = ARGV[0]
	tagMessage = ARGV[1]
end
if tagMessage.isNil?

# Define helper methods
def print_message(message)
	system("echo \"#{message}\"")
end
def run_command(command)
	print_message(command)
	system(command)
end

# Run "hg branches"
print_message('> hg branches')
all_branches = IO.popen(['hg', 'branches'])

# Read the output
does_branch_autobuild_exist = false
for branch in all_branches.readlines

	# Check if branch autobuild exists
	print_message(branch)
	if branch.start_with?(BRANCH_NAME)

		# If it does, indicate so
		print_message('* Branch autobuild found!')
		does_branch_autobuild_exist = true
		break
	end
end

# Close the command
print_message('* Stop branches process')
all_branches.close

# Check if branch autobuild exists
if does_branch_autobuild_exist

	# If it does, switch to this branch
	run_command("hg up #{BRANCH_NAME}")

	if revision
		# Merge the changes from default, up to revision
		run_command("hg merge -r #{revision}")

		# Commit the changes from default, up to revision
		run_command("hg commit -m \"Merging the default branch up to revision #{revision}.\"")
	else
		# Merge the changes from default
		run_command("hg merge default")

		# Commit the changes from default
		run_command("hg commit -m \"Merging the default branch.\"")
	end
else

	# If it does not, create a new branch
	run_command("hg branch #{BRANCH_NAME}")

	if revision
		# Commit the changes from default, up to revision
		run_command("hg commit -m \"Branching from the default branch at revision #{revision}.\"")
	else
		# Commit the changes from default
		run_command("hg commit -m \"Branching from the default branch.\"")
	end
end

if tagMessage
	# Tag this revision
	run_command("hg tag -f \"#{tagMessage}\"")
end

if does_branch_autobuild_exist
	# Push changes to the branch
	run_command("hg push -b #{BRANCH_NAME}")
else
	# Push changes to the new branch
	run_command("hg push --new-branch -b #{BRANCH_NAME}")
end
