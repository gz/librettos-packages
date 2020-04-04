#!/bin/sh

export PATH="${PATH}:$(pwd)/../rumprun/bin"

rm rumprun-nfsd.bin.iso
rumprun iso nfsd.bin ixg0 10.0.0.22 netmask 255.255.255.0 mtu 9000
