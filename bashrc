# extra bashrc goodies
# to be sourced at the end of ~/.bashrc

# do some fancy footwork to set $HOME if it isn't
homeDir=~
: "${HOME:=$homeDir}"
export HOME
unset homeDir

dotfilesDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"
dockerBinDir="$HOME/docker/bin"

alias updog='docker run -it --rm -e TERM'
if [ -f /etc/systemd/nspawn/gentoo.nspawn ]; then
	#alias gentoo='sudo machinectl shell --quiet --setenv DISPLAY="$DISPLAY" tianon@gentoo'
	gentoo() {
		if [ -t 1 ]; then
			local tty='--tty --send-sighup'
		else
			if systemd-run --help 2>&1 | grep -q -- '--pipe'; then
				local tty='--pipe'
			else
				echo >&2 'warning: systemd-run does not appear to support "--pipe"; results might be odd'
				local tty='--tty'
			fi
		fi
		if [ "$#" -eq 0 ]; then
			set -- /usr/bin/env bash --login -i
		fi
		sudo systemd-run \
			--machine gentoo \
			--uid tianon \
			--property WorkingDirectory=/home/tianon \
			--quiet --wait $tty \
			"$@"
	}
fi
if command -v wminput > /dev/null; then
	# "unable to open uinput"
	# sudo modprobe uinput
	alias wiimote-pink='wminput --wait --config '"$dotfilesDir"'/cwiid-wminput-sideways E8:4E:CE:A6:6F:D7'
fi

export PATH="$PATH:$HOME/bin:$dotfilesDir/bin:$dockerBinDir:$dockerBinDir/sbuild"
if [ -r "$dockerBinDir/smart/.bashrc" ]; then
	source "$dockerBinDir/smart/.bashrc"
fi

if false; then
	# this adds completion for "git compare", which throws off my "git com<tab>" for "git commit", and "git compare" won't even work in the way I use "hub"
	hubDir="$(dirname "$(readlink -f "$dockerBinDir/hub")")"
	if [ -f "$hubDir/../etc/hub.bash_completion.sh" ]; then
		source "$hubDir/../etc/hub.bash_completion.sh"
	fi
	unset hubDir
fi

unset dotfilesDir dockerBinDir

export DEBFULLNAME='Tianon Gravi'
export DEBEMAIL='tianon@debian.org'
export DEBOOTSTRAP_MIRROR='http://deb.debian.org/debian'
export UBUNTUTOOLS_DEBIAN_MIRROR="$DEBOOTSTRAP_MIRROR"

# quilt is much amaze: https://wiki.debian.org/UsingQuilt#Using_quilt_with_Debian_source_packages
export QUILT_PATCHES=debian/patches
export QUILT_REFRESH_ARGS='-p ab --no-timestamps --no-index'

case "$(hostname --short)" in
	*-gentoo)
		cat <<-'EOF'

		  Gentoo is for Ricers.

		EOF
		;;

	biers)
		cat <<-'EOF'


		  Aaron Doral: The Hybrid objects.
		  D'Anna Biers: She doesn't get a vote.  Jump the ship.


		EOF
		;;

	viper)
		cat <<-'EOF'


		  Adama: What do you hear?
		  Starbuck: Nothing but the rain.
		  Adama: Grab your gun and bring in the cat.
		  Starbuck: Boom, boom, boom!

		EOF
		;;

	zoe)
		cat <<-'EOF'


		    Lacy [to Zoe]: Do you realize you're six feet tall and weigh a ton?


		EOF
		;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# http://askubuntu.com/a/67306
PROMPT_COMMAND="history -a; ${PROMPT_COMMAND:-}"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=400000000
HISTFILESIZE=$(( HISTSIZE * 2 ))

case "${COLORTERM:-}" in
	gnome-terminal|mate-terminal|xfce4-terminal)
		export TERM='xterm-256color'
		;;
esac

_tianon_history_1() {
	history 1 | sed -r 's/^[ ]*[0-9]+[ ]+//'
}
_tianon_titlebar_cmd() {
	_tianon_history_1 | awk -v len=50 '
		{
			if (length($0) > len)
				print substr($0, 1, len-3) "...";
			else
				print;
		}
	'
}
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=1
_tianon_prompt_extra() {
	local extraBits=

	if [ -n "${DOCKER_HOST:-}" ]; then
		[ -z "$extraBits" ] || extraBits+='; '
		extraBits+="$DOCKER_HOST"
	fi

	local gitBits="$(__git_ps1 '%s' 2>/dev/null)"
	if [ -n "$gitBits" ]; then
		[ -z "$extraBits" ] || extraBits+='; '
		extraBits+="$gitBits"
	fi

	if [ -n "$extraBits" ]; then
		printf ' (%s) ' "$extraBits"
	fi
}

# set a fancy prompt (non-color, unless we know we "want" color)
color=
case "${TERM:-}" in
	xterm-color|*-256color) color=1 ;;
	*)
		if command -v tput > /dev/null && tput setaf 1 &> /dev/null; then
			color=1
		fi
		;;
esac
declare -A colors=(
	[reset]=''
	[date]='' # HH:MM:SS
	[recap]='' # ... $ command ...
	[user]='' # tianon@...
	[host]='' # ...@xyz
	[colon]='' # :
	[path]='' # ~/docker/...
	[extra]='' # (master=)
	[dollar]='' # $
)
if [ -n "$color" ]; then
	numColors="$(tput colors 2>/dev/null || :)"
	colors=(
		[reset]='\e[m'

		[date]='\e[1;30m' #'\e[37m' # HH:MM:SS
		[recap]='\e[0;30m' # ... $ command ...
		[user]='\e[0;32m' # tianon@...
		[host]='\e[1;32m' # ...@xyz
		[colon]='\e[1;30m' # :
		[path]='\e[1;34m' # ~/docker/...
		[extra]='\e[0;32m' # (master=)
		[dollar]='\e[0;31m' # $
	)
	case "${numColors:-'8'}" in
		256)
			colors[date]='\e[0;38;5;56m'
			colors[recap]='\e[0;38;5;237m'
			colors[user]='\e[0;38;5;23m'
			colors[host]='\e[1;38;5;46m'
			colors[colon]='\e[0;38;5;166m'
			colors[path]='\e[0;38;5;26m'
			colors[extra]='\e[0;38;5;100m'
			colors[dollar]='\e[0;38;5;201m'
			;;
	esac
	unset numColors
fi

dateFormat='%H:%M:%S'

PS1='\['${colors[date]}'\]$(date +"'$dateFormat'")\['${colors[recap]}'\] ... \$ $(_tianon_history_1)\['${colors[reset]}'\]\n'
PS1+='\['${colors[user]}'\]\u@\['${colors[host]}'\]\h\['${colors[colon]}'\]:\['${colors[path]}'\]\w\['${colors[extra]}'\]$(_tianon_prompt_extra)\['${colors[dollar]}'\]\$\['${colors[reset]}'\] '

# PS0: http://stromberg.dnsalias.org/~strombrg/PS0-prompt/
PS0=${colors[date]}'$(date +"'$dateFormat'")'${colors[recap]}' ... \$ $(_tianon_history_1)'${colors[reset]}'\n'

if [ -z "${colors[date]:-}" ]; then
	# if we have no date colors, add more whitespace to visually compensate
	PS1='\n'"$PS1"
	PS0+='\n'
fi

unset color colors dateFormat

# if this is an xterm set the title to user@host:dir
case "${TERM:-}" in
	xterm*|rxvt*)
		titlebarBits='\e]0;[\h] $(_tianon_titlebar_cmd) {\u, \w}\a'
		PS0+="$titlebarBits"
		PS1="\[$titlebarBits\]$PS1"
		unset titlebarBits
		;;
esac
