#!/bin/sh -e

##
## Helpers
HOSTNAME="$1"
if [ -z "$HOSTNAME" ]; then
	echo "usage: $0 hostname"
	exit 1
fi

cleanup() {
	rm -rf "$tmp"
}

rc_add() {
	mkdir -p "$tmp"/etc/runlevels/"$2"
	ln -sf /etc/init.d/"$1" "$tmp"/etc/runlevels/"$2"/"$1"
}

tmp="$(mktemp -d)"
trap cleanup EXIT
cp /home/apkovldir/* "$tmp"/

##
## Files
##
makefile root:root 0644 "$tmp"/etc/hostname <<EOF
$HOSTNAME
EOF

# Packages
cat <<EOF /home/build/packages | makefile root:root 0644 "$tmp"/etc/apk/world
alpine-base
openssl
EOF

##
## OpenRC Services
##
rc_add  mount-ro shutdown
rc_add killprocs shutdown
rc_add savecache shutdown

rc_add  hwclock boot
rc_add   syslog boot
rc_add bootmisc boot
rc_add hostname boot
rc_add   sysctl boot
rc_add  modules boot

rc_add   modloop sysinit
rc_add hwdrivers sysinit
rc_add      mdev sysinit
rc_add     dmesg sysinit
rc_add     devfs sysinit

rc_add local default
rc_add dbus default

tar -c -C "$tmp" etc usr | gzip -9n > $HOSTNAME.apkovl.tar.gz
