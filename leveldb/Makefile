include ../Makefile.inc
UPSTREAM=https://github.com/google/leveldb/archive/v1.18.tar.gz
CUSTOM=https://github.com/amytai/leveldb.git
LOCKS=https://github.com/ankit-iitb/litl.git
INSTALL_PREFIX ?= $(shell pwd)
CC=$(RUMPRUN_CC) -L${RUMPRUN_SYSROOT}/../../obj-amd64-bespin/lib/libunwind/
CXX=$(RUMPRUN_CXX) -L${RUMPRUN_SYSROOT}/../../obj-amd64-bespin/lib/libunwind/
export CC CXX


$(info $$RUMPRUN_SYSROOT is [${RUMPRUN_SYSROOT}])

all: bin/db_bench
	mkdir -p bin
	cp build/db_bench bin

bin/db_bench: build/db_bench

build/db_bench: build/Makefile patches/*
	mkdir -p amy-leveldb
	mkdir -p litl
	git clone ${CUSTOM} -b bespin amy-leveldb
	git clone ${LOCKS} -b leveldb litl
	(cd litl && make)
	(cd amy-leveldb && ./copy_source.sh ../build/)
	../scripts/apply-patches.sh build/ patches/*
	touch $@
	$(MAKE) -C build TARGET_OS=NetBSD

build/Makefile:
	mkdir -p build
	../scripts/fetch.sh ${UPSTREAM} build/leveldb.tar.gz
	(cd build && tar -xz --strip-components 1 -f leveldb.tar.gz)

.PHONY: clean
clean:
	-$(MAKE) -C build clean
	rm -rf bin
	rm -rf amy-leveldb
	rm -rf litl
	rm -rf build
