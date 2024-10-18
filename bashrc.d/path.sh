# https://github.com/tianon/debian-bin
for debianBinDir in \
	"$HOME/docker/debian-bin" \
	"$HOME/git/debian-bin" \
; do
	if [ -d "$debianBinDir" ]; then
		export PATH="$PATH:$debianBinDir/generic:$debianBinDir/docker-sbuild"
		break
	fi
done
unset debianBinDir

# https://github.com/tianon/docker-bin
dockerBinDir="$HOME/docker/bin"
if [ -d "$dockerBinDir" ]; then
	export PATH="$PATH:$dockerBinDir:$dockerBinDir/sbuild"
	# https://github.com/tianon/docker-museum
	if [ -r "$dockerBinDir/smart/.bashrc" ]; then
		source "$dockerBinDir/smart/.bashrc"
	fi
fi
unset dockerBinDir
