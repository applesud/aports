#!/bin/sh
# For use with the alpine-image-docker project that I made
profile_custom(){
    title="Custom"
    desc="Customise it!"
    profile_standard
    profile_abbrev="cstm"
    apkovl="genapkovl-custom.sh"
    # Include all of the packages that are going to be installed by default
    apks="$apks `cat ~/apkovldir/etc/apk/world`"
    local _k _a
    for _k in $kernel_flavors; do
            apks="$apks linux-$_k"
            for _a in $kernel_addons; do
                    apks="$apks $_a-$_k"
            done
    done
}
