include ../Makefile.inc

UPSTREAM=https://download.lammps.org/tars/lammps-stable.tar.gz
TARBALL=$(notdir $(UPSTREAM))

CC=$(RUMPRUN_CC) -L${RUMPRUN_SYSROOT}/../../obj-amd64-nrk/lib/libunwind/
CXX=$(RUMPRUN_CXX) -L${RUMPRUN_SYSROOT}/../../obj-amd64-nrk/lib/libunwind/
export CC CXX

all: $(RUMPRUN_PKGS_DIR)/lib/libevent.a build/configure build/Makefile

.NOTPARALLEL: $(RUMPRUN_PKGS_DI)/lib/libevent.a
$(RUMPRUN_PKGS_DIR)/lib/libevent.a:
	$(MAKE) -C ../libevent

build/stamp_patch:
	(cd build && ../../scripts/apply-patches.sh ./ ../patches/*)
	touch $@

.PHONY: build/Makefile
build/Makefile: build/stamp_patch
	(cd build/src; make serial)

dl/$(TARBALL):
	mkdir -p dl
	../scripts/fetch.sh ${UPSTREAM} dl/$(TARBALL)

build/configure: | dl/$(TARBALL)
	mkdir -p build
	(cd build && tar -xz --strip-components 1 -f ../dl/$(TARBALL))

.PHONY: clean
clean:
	(cd build/src; make clean-serial)
	rm build/stamp_patch

.PHONY: distclean
distclean: clean
	rm -rf build
