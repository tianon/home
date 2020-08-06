# https://github.com/tianon/docker-bin
dockerBinDir="$HOME/docker/bin"
export PATH="$PATH:$dockerBinDir:$dockerBinDir/sbuild"

# https://github.com/tianon/docker-museum
if [ -r "$dockerBinDir/smart/.bashrc" ]; then
	source "$dockerBinDir/smart/.bashrc"
fi

unset dockerBinDir
