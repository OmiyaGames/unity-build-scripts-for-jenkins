REM Zip all the build folders
REM FOR /D %%G IN (Builds\*) DO "C:\Program Files\7-Zip\7z.exe" a "%%G.zip" ".\%%G\*"

REM Use mercurial to tag the built revision.
REM hg tag -f --rev %MERCURIAL_REVISION% "[Auto-build] %JOB_NAME% %BUILD_DISPLAY_NAME%"
REM hg push

REM Switch to and update the autobuild branch
ruby C:\repo\BuildScripts.hg\updateAutoBuildBranch.rb "%WORKSPACE%" %MERCURIAL_REVISION% "[Auto-build] %JOB_NAME% %BUILD_DISPLAY_NAME%"
