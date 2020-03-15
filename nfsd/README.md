NFS for rumprun
===============

Adopted by Ruslan Nikolaev

* Prepare rumprun (as described in the rumprun instructions)

* Patch rumprun-bake.conf to support NFS

```
cd rumprun-smp
patch -p1 < rumprun-bake-nfsd.patch
```

* Copy the nfsd subdirectory to rumprun

* Compile rumprun (as described in the rumprun instructions)

* Go to the nfsd subdirectory

* Change rootfs/etc/exports as necessary

* Run ./compile.sh to create nfsd.bin
