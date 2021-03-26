include ../Makefile.inc
UPSTREAM=https://github.com/amytai/leveldb.git
LOCKS=https://github.com/ankit-iitb/litl.git
INSTALL_PREFIX ?= $(shell pwd)
CC=$(RUMPRUN_CC) -L${RUMPRUN_SYSROOT}/../../obj-amd64-bespin/lib/libunwind/
CXX=$(RUMPRUN_CXX) -L${RUMPRUN_SYSROOT}/../../obj-amd64-bespin/lib/libunwind/
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
	mkdir -p litl
	git clone ${LOCKS} -b leveldb
	(cd litl && $(MAKE) TARGET_OS=NetBSD)
	mkdir -p build
	git clone ${UPSTREAM} -b bespin build

.PHONY: clean
clean:
	rm -rf build
	rm -rf litl
	rm -f bin/*
