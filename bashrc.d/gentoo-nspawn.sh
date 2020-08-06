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
			--setenv DISPLAY="$DISPLAY" \
			"$@"
	}
fi
