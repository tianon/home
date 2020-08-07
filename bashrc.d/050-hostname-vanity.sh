shortHostname="$(exec 2>/dev/null; hostname --short || hostname -s || hostname || :)"
case "$shortHostname" in
	*-gentoo) shortHostname='gentoo' ;;
	rpi[0-9]*) shortHostname='rpi' ;;
esac
thisDir="$(dirname "$BASH_SOURCE")"
if [ -r "$thisDir/.hostname-vanity/$shortHostname" ]; then
	cat "$thisDir/.hostname-vanity/$shortHostname"
fi
unset shortHostname thisDir
