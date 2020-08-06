shortHostname="$(exec 2>/dev/null; hostname --short || hostname -s || hostname || :)"
if [[ "$shortHostname" == *-gentoo ]]; then
	shortHostname='gentoo'
fi
thisDir="$(dirname "$BASH_SOURCE")"
if [ -r "$thisDir/.hostname-vanity/$shortHostname" ]; then
	< "$thisDir/.hostname-vanity/$shortHostname"
fi
unset shortHostname thisDir
