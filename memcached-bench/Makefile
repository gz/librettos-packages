include ../Makefile.inc

all: $(RUMPRUN_PKGS_DIR)/lib/libevent.a $(RUMPRUN_PKGS_DIR)/lib/libgomp.a build/configure build/Makefile

.NOTPARALLEL: $(RUMPRUN_PKGS_DIR)/lib/libevent.a $(RUMPRUN_PKGS_DIR)/lib/libgomp.a
$(RUMPRUN_PKGS_DIR)/lib/libevent.a:
	$(MAKE) -C ../libevent

$(RUMPRUN_PKGS_DIR)/lib/libgomp.a:
	$(MAKE) -C ../openmp

MEMCACHED_CONF_ENV += \
	LIBS=-lc \
	CC=$(RUMPRUN_CC)

MEMCACHED_CONF_OPTS += \
	--prefix=$(shell pwd)/build/dist \
	--host=$(RUMPRUN_TOOLCHAIN_TUPLE) \
	--with-libevent=$(RUMPRUN_PKGS_DIR) \
	--disable-extstore

build/stamp_patch:
	# (cd build && ../../scripts/apply-patches.sh ./ ../patches/*)
	touch $@

.PHONY: build/Makefile
build/Makefile: build/stamp_patch
	(cd build; $(MEMCACHED_CONF_ENV) ./configure $(MEMCACHED_CONF_OPTS); make)

build/configure:
	git clone https://github.com/achreto/memcached.git build
	(cd build && git checkout 25f3ae981bb62a2172e8cbb69da945b8498f3d49)
	(cd build && ./autogen.sh)

.PHONY: clean
clean:
	(cd build; make clean)
	rm build/stamp_patch

.PHONY: distclean
distclean: clean
	rm -rf build
