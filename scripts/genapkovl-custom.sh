#!/bin/sh -e
# Create tmpdir
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
# Copy apkovl
cp /home/apkovldir/* "$tmp"/
# Update hostname
echo "$1" > "$tmp"/etc/hostname
# Build
tar -c -C "$tmp" etc usr | gzip -9n > $HOSTNAME.apkovl.tar.gz
