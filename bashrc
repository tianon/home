# extra bashrc goodies
# to be sourced at the end of ~/.bashrc

# do some fancy footwork to set $HOME if it isn't
homeDir=~
: "${HOME:=$homeDir}"
export HOME
unset homeDir

dotfilesDir="$(readlink -f "$BASH_SOURCE")"
dotfilesDir="$(dirname "$dotfilesDir")"

export PATH="$PATH:$HOME/bin:$dotfilesDir/bin"

for dotfileSource in "$dotfilesDir"/bashrc.d/*.sh; do
	if [ -r "$dotfileSource" ]; then
		source "$dotfileSource"
	fi
done
unset dotfileSource

unset dotfilesDir
