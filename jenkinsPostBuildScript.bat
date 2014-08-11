REM Zip all the build folders
ruby C:\repo\BuildScripts.hg\zipBuildFiles.rb "%WORKSPACE%\Builds"

REM Switch to and update the autobuild branch
ruby C:\repo\BuildScripts.hg\updateAutoBuildBranch.rb %MERCURIAL_REVISION% "[Auto-build] %JOB_NAME% %BUILD_DISPLAY_NAME%"
REM hg merge default
REM hg commit -m %1
