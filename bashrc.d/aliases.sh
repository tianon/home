alias updog='docker run -it --rm -e TERM'
alias docker-follow='docker attach --no-stdin --sig-proxy=false'

# 💕 for Clint (https://salsa.debian.org/debian/debianutils/-/commit/3a8dd10b4502f7bae8fc6973c13ce23fc9da7efb)
alias which='command -v'

# from http://git.661346.n2.nabble.com/git-grep-to-operate-across-who-repository-and-not-just-CWD-tp6071541p6074384.html
cdup-git() {
	local eh
	eh="$(git rev-parse --is-inside-work-tree)" || return
	case "$eh" in
		true)
			eh="$(git rev-parse --show-toplevel)"
			test -z "$eh" || cd "$eh"
			;;
		false)
			eh="$(git rev-parse --git-dir)" || return
			cd "$eh" || return
			eh="$(git rev-parse --is-bare-repository)" || return
			test "$eh" = 'true' || cd ..
			;;
	esac
}

unset-docker() {
	local var
	for var in "${!DOCKER_@}"; do
		unset "$var"
	done
}
