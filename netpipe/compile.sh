#!/bin/sh

export PATH="${PATH}:/usr/local/bin:/usr/local/sbin:$(pwd)/../rumprun/bin"

(cd src && x86_64-rumprun-netbsd-gcc -Wall -O2 -o ../netpipe netpipe.c tcp.c -DTCP -DPORTMAP -DRUMPRUN)

mkdir -p rootfs/var/run
x86_64-rumprun-netbsd-cookfs -s 1 rootfs.fs rootfs

rumprun-bake -m "add rootfs.fs" hw_generic netpipe.bin netpipe
