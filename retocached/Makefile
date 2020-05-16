include ../Makefile.inc

UPSTREAM=http://www.memcached.org/files/memcached-1.4.33.tar.gz
TARBALL=$(notdir $(UPSTREAM))

all: $(RUMPRUN_PKGS_DIR)/lib/libevent.a $(RUMPRUN_PKGS_DIR)/lib/libgomp.a build/Makefile

.NOTPARALLEL: $(RUMPRUN_PKGS_DIR)/lib/libevent.a $(RUMPRUN_PKGS_DIR)/lib/libgomp.a
$(RUMPRUN_PKGS_DIR)/lib/libevent.a:
	$(MAKE) -C ../libevent

$(RUMPRUN_PKGS_DIR)/lib/libgomp.a:
	$(MAKE) -C ../openmp


MEMCACHED_CONF_ENV += \
	LIBS='-lc -lgomp' \
	CC='$(RUMPRUN_CC) -fopenmp'

MEMCACHED_CONF_OPTS += \
	--prefix=$(shell pwd)/build/dist \
	--host=$(RUMPRUN_TOOLCHAIN_TUPLE) \
	--with-libevent=$(shell pwd)/../../pkgs

build/stamp_patch:
	(cd build && ../../scripts/apply-patches.sh ./ ../patches/*)
	touch $@

.PHONY: build/Makefile
build/Makefile: build/stamp_patch
	(cd build; $(MEMCACHED_CONF_ENV) ./configure $(MEMCACHED_CONF_OPTS); make)

.PHONY: clean
clean:
	(cd build; make clean)

.PHONY: distclean
distclean: clean
