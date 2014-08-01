REM Zip all the build folders
REM FOR /D %%G IN (Builds\*) DO "C:\Program Files\7-Zip\7z.exe" a "%%G.zip" ".\%%G\*"
ruby C:\repo\BuildScripts.hg\zipBuildFiles.rb "%WORKSPACE%\Builds"

REM Switch to and update the autobuild branch
ruby C:\repo\BuildScripts.hg\updateAutoBuildBranch.rb %MERCURIAL_REVISION% "[Auto-build] %JOB_NAME% %BUILD_DISPLAY_NAME%"
