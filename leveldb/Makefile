include ../Makefile.inc
UPSTREAM=https://github.com/hunhoffe/leveldb.git
INSTALL_PREFIX ?= $(shell pwd)
CC=$(RUMPRUN_CC) -L${RUMPRUN_SYSROOT}/../../obj-amd64-nrk/lib/libunwind/
CXX=$(RUMPRUN_CXX) -L${RUMPRUN_SYSROOT}/../../obj-amd64-nrk/lib/libunwind/
export CC CXX


$(info $$RUMPRUN_SYSROOT is [${RUMPRUN_SYSROOT}])

all: bin/db_bench

bin/db_bench: build/db_bench
	$(MAKE) -C build install PREFIX=${INSTALL_PREFIX}

build/db_bench: build/stamp_patch
	$(MAKE) -C build TARGET_OS=NetBSD

build/stamp_patch: build/Makefile patches/*
	../scripts/apply-patches.sh build/ patches/*
	touch $@

build/Makefile:
	mkdir -p build
	git clone ${UPSTREAM} -b bespin build

.PHONY: clean
clean:
	rm -rf build
	rm -f bin/*
