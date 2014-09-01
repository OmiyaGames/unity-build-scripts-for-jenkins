REM Set this variable to the location the scripts are cloned/copied over
set SCRIPT_LOCATION=C:\repo\BuildScripts.hg

REM Zip all the build folders
ruby "%SCRIPT_LOCATION%\zipBuildFiles.rb" "%WORKSPACE%\Builds"

REM Switch to and update the autobuild branch
ruby "%SCRIPT_LOCATION%\updateAutoBuildBranch.rb" %MERCURIAL_REVISION% "[Auto-build] %JOB_NAME% %BUILD_DISPLAY_NAME%"
