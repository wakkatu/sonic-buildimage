#!/bin/sh

if [ -z "$KVERSION" ]; then
    if which onlpm > /dev/null; then
        KERNDIR=$(onlpm --find-dir "$(onlpm --require "$(onlpm --list-all | grep onl-platform-modules | grep ${onl_platform:-as7326} | head -n1)" 2>&1 | grep onl-kernel | sed 's!.* package \|\.\.\.$!!g' | head -n1)" mbuilds)
        if [ -d "$KERNDIR" ]; then
            KVERSION=$(cat $KERNDIR/include/config/kernel.release)
            sudo ln -sfn $KERNDIR /usr/src/linux-headers-$KVERSION
        fi
    fi
fi

cd "$(dirname "$0")"

if [ -n "$KVERSION" ]; then
    sed -i "s#\(lib/modules/\)[^/]*#\1$KVERSION#" debian/opennsl-modules.dirs
    sed -i "s#\(lib/modules/\)[^/]*#\1$KVERSION#" debian/opennsl-modules.install
fi

KVERSION=$KVERSION ADD_TO_CFLAGS=-DCONFIG_PSAMPLE_MODULE fakeroot debian/rules clean binary
