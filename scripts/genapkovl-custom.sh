#!/bin/sh -e
# Create tmpdir
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
# Copy apkovl
cp -r ~/apkovldir/* "$tmp"/
# Update hostname
echo "$1" > "$tmp"/etc/hostname
# Sync root home to /etc/skel
cp -r "$tmp"/etc/skel "$tmp"/root
# Build
(cd "$tmp" && tar -c *) | gzip -9n > $HOSTNAME.apkovl.tar.gz
