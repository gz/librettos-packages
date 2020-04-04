#!/bin/sh

export PATH="${PATH}:/usr/local/bin:/usr/local/sbin:$(pwd)/../rumprun/bin"

(cd src && x86_64-rumprun-netbsd-gcc -Wall -O2 -pthread -o ../nfsd rpcbind/rpcbind.c rpcbind/check_bound.c rpcbind/pmap_svc.c rpcbind/rpcb_stat.c rpcbind/rpcb_svc_4.c rpcbind/rpcb_svc.c rpcbind/rpcb_svc_com.c rpcbind/security.c rpcbind/util.c rpcbind/warmstart.c mountd/get_net.c mountd/mountd.c nfsd/nfsd.c -DPORTMAP -DRUMPRUN)

(cd .. && x86_64-rumprun-netbsd-gcc -Wall -O2 -o nfsd/ifconfig ifconfig/af_atalk.c ifconfig/af_inet6.c ifconfig/ieee80211.c ifconfig/ifconfig.c ifconfig/pfsync.c ifconfig/env.c ifconfig/parse.c ifconfig/carp.c ifconfig/agr.c ifconfig/ether.c ifconfig/af_inetany.c ifconfig/media.c ifconfig/tunnel.c ifconfig/ifconfig_hostops.c ifconfig/af_inet.c ifconfig/vlan.c ifconfig/af_link.c ifconfig/util.c -DPORTMAP -DRUMPRUN)

mkdir -p rootfs/var/run
mkdir -p rootfs/disk

cp ../rumprun/rumprun-x86_64/lib/libutil.a ../rumprun/rumprun-x86_64/lib/rumprun-hw/
cp ../rumprun/rumprun-x86_64/lib/libprop.a ../rumprun/rumprun-x86_64/lib/rumprun-hw/

x86_64-rumprun-netbsd-cookfs -s 1 rootfs.fs rootfs
rumprun-bake -m "add rootfs.fs" hw_generic nfsd.bin ifconfig nfsd

sudo ./create_nfsd_iso.sh
