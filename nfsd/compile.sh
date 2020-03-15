#!/bin/sh

export PATH="${PATH}:/usr/local/bin:/usr/local/sbin:$(pwd)/../rumprun/bin"

(cd src && x86_64-rumprun-netbsd-gcc -Wall -O2 -pthread -o ../nfsd rpcbind/rpcbind.c rpcbind/check_bound.c rpcbind/pmap_svc.c rpcbind/rpcb_stat.c rpcbind/rpcb_svc_4.c rpcbind/rpcb_svc.c rpcbind/rpcb_svc_com.c rpcbind/security.c rpcbind/util.c rpcbind/warmstart.c mountd/get_net.c mountd/mountd.c nfsd/nfsd.c -DPORTMAP -DRUMPRUN)

mkdir -p rootfs/var/run
mkdir -p rootfs/disk
x86_64-rumprun-netbsd-cookfs -s 1 rootfs.fs rootfs

rumprun-bake -m "add rootfs.fs" hw_generic nfsd.bin nfsd
