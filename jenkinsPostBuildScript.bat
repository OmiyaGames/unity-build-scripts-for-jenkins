REM Zip all the build folders
FOR /D %%G IN (Builds\*) DO "C:\Program Files\7-Zip\7z.exe" a "%%G.zip" ".\%%G\*"

REM Switch to and update the autobuild branch
ruby "C:\repo\BuildScripts.hg\branchToAutoBuild.rb"

REM Use mercurial to tag the built revision.
hg tag -f --rev %MERCURIAL_REVISION_NUMBER% "[Auto-build] %JOB_NAME% %BUILD_DISPLAY_NAME%"
hg push
