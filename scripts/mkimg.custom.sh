#!/bin/sh
profile_custom(){
    title="Custom"
    desc="Customise it!"
    profile_standard
    profile_abbrev="cstm"
    apkovl="genapkovl-custom.sh"
    apks="$apks `cat ~/packages`"
    local _k _a
    for _k in $kernel_flavors; do
            apks="$apks linux-$_k"
            for _a in $kernel_addons; do
                    apks="$apks $_a-$_k"
            done
    done
}
