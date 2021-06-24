# https://github.com/tianon/debian-bin
debianBinDir="$HOME/docker/debian-bin"
export PATH="$PATH:$debianBinDir/generic:$debianBinDir/docker-sbuild"
unset debianBinDir

# https://github.com/tianon/docker-bin
dockerBinDir="$HOME/docker/bin"
export PATH="$PATH:$dockerBinDir:$dockerBinDir/sbuild"
# https://github.com/tianon/docker-museum
if [ -r "$dockerBinDir/smart/.bashrc" ]; then
	source "$dockerBinDir/smart/.bashrc"
fi
unset dockerBinDir
