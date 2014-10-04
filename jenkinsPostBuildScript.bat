REM Set this variable to the location the scripts are cloned/copied over
set SCRIPT_LOCATION=C:\repo\BuildScripts.hg

REM Zip all the build folders
ruby "%SCRIPT_LOCATION%\zipBuildFiles.rb" "%WORKSPACE%\Builds"

REM Switch to and update the autobuild branch
ruby "%SCRIPT_LOCATION%\updateAutoBuildBranch.rb" %MERCURIAL_REVISION% "[Auto-build] %JOB_NAME% %BUILD_DISPLAY_NAME%"

REM Check if any FTP information is provided
if [%3] == [] goto :DONE

REM If so, upload the webplayer to FTP, if there are any
ruby "%SCRIPT_LOCATION%\ftpUploadWebplayer.rb" "%WORKSPACE%\Builds" %1 %2 %3 %BUILD_DISPLAY_NAME%

:DONE
REM Finished post-build script
