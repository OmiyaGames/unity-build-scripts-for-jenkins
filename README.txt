This series of scripts assist Jenkins continuous integration server's -- running on Windows 7 -- post-build process.
It handles bundling builds from Unity projects into zip files, and creates a tag in the Mercurial repository.
The jenkins_settings.png photo contains an example of how one would use these scripts on a Jenkins project.

Note that these set of scripts require the following pre-requisites:

* The "Template Unity Project": https://bitbucket.org/OmiyaGames/template-unity-project

* Unity ver. 4.5.2f1 or greater
** Requires the pro-license (for command line feature)

* Jenkins ver. 1.571 or greater
** The Unity 3D Builder plugin: https://wiki.jenkins-ci.org/display/JENKINS/Unity3dBuilder+Plugin
** The Mercurial plugin: https://wiki.jenkins-ci.org/display/JENKINS/Mercurial+Plugin

* Mercurial ver. 3.0+3 or greater
** As an example, Omiya Games uses TortoiseHg ver. 3.0 or greater

* Ruby ver. 2.0 or greater
** The RubyZip gem: https://rubygems.org/gems/rubyzip
