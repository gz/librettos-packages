include ../Makefile.inc

UPSTREAM=http://www.memcached.org/files/memcached-1.4.33.tar.gz
TARBALL=$(notdir $(UPSTREAM))

all: $(RUMPRUN_PKGS_DIR)/lib/libevent.a build/configure build/Makefile

.NOTPARALLEL: $(RUMPRUN_PKGS_DIR)/lib/libevent.a
$(RUMPRUN_PKGS_DIR)/lib/libevent.a:
	$(MAKE) -C ../libevent

MEMCACHED_CONF_ENV += \
	LIBS="-lc -lgomp"\
	CC=$(RUMPRUN_CC)

MEMCACHED_CONF_OPTS += \
	--prefix=$(shell pwd)/build/dist \
	--host=$(RUMPRUN_TOOLCHAIN_TUPLE) \
	--with-libevent=$(shell pwd)/../../pkgs

.PHONY: build/Makefile
build/Makefile:
	(cd build; $(MEMCACHED_CONF_ENV) ./configure $(MEMCACHED_CONF_OPTS); make)

build/configure:
	cp -rf src build
	(cd build && tar -xz --strip-components 1 -f ../dl/$(TARBALL))

.PHONY: clean
clean:
	(cd build; make clean)

.PHONY: distclean
distclean: clean
	rm -rf build
