# normalize TERM to xterm-256color for known-supported terminals
case "${COLORTERM:-}" in
	gnome-terminal | mate-terminal | xfce4-terminal)
		export TERM='xterm-256color'
		;;
esac

# keep GOPATH out of ~/go
: "${GOPATH:=$HOME/.cache/go}"
export GOPATH

# make "docker-compose build" actually use "docker build" under the covers
export COMPOSE_DOCKER_CLI_BUILD=1
# https://github.com/docker/compose/releases/tag/1.25.0
# https://github.com/docker/compose/commit/cacbcccc0c68bfcd33f4707bd388b1441523c521 + https://github.com/docker/compose/commit/5add9192ac52a5c72ecc1495aa68cbfeb5a8e863
# https://www.docker.com/blog/faster-builds-in-compose-thanks-to-buildkit-support/
