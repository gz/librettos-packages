include ../Makefile.inc

#
# Cross-build script for MySQL on rumprun-xen
#

UPSTREAM=https://www.monetdb.org/hg/MonetDB/archive/Jun2023_release.tar.gz
TARBALL=$(notdir $(UPSTREAM))
PACKAGE_DIR=$(abspath .)

SOURCE_DIR=$(abspath source/)
BUILD_DIR=$(abspath build/)

monetdbCONF_ENV += \
	CC=$(RUMPRUN_CC)

all: monetdb

monetdb: $(BUILD_DIR)/bin/monetdb

dl/$(TARBALL):
	mkdir -p dl
	../scripts/fetch.sh $(UPSTREAM) dl/$(TARBALL)

#
# 1. Extract monetdb distribution tarball
#
build/monetdbextract_stamp: dl/$(TARBALL)
	mkdir -p $(BUILD_DIR)
	mkdir -p $(SOURCE_DIR)
	tar -C $(SOURCE_DIR) --strip=1 -xzf $<
	touch $@

#
# 2. Patches:
#
# 1. hmac conflicts with BSD's stdlib, doesn't seem to be used anywyere
# 2. obtaining the rss seems broken
# 3. disable the examples and the mserver as they cannot be linked with ldl
# 4. popcount64 conflicts the stdlib, rename it
build/monetdbpatch_stamp: build/monetdbextract_stamp
	sed -i 's/extern int hmac/extern int myhmac/g' $(SOURCE_DIR)/common/utils/sha.h
	sed -i 's/ki->kp_eproc.e_vm.vm_rssize/rss = -1; \/\/ki->kp_eproc.e_vm.vm_rssize;/g' $(SOURCE_DIR)/gdk/gdk_posix.c
	sed -i 's/add_subdirectory(examples)/# add_subdirectory(examples)/g' $(SOURCE_DIR)/clients/CMakeLists.txt
	sed -i 's/add_subdirectory(mserver)/# add_subdirectory(mserver)/g' $(SOURCE_DIR)/tools/CMakeLists.txt
	sed -i 's/add_subdirectory(monetdlsbe)/# add_subdirectory(monetdbe)/g' $(SOURCE_DIR)/tools/CMakeLists.txt
	sed -i 's/add_subdirectory(ctest)/# add_subdirectory(ctest)/g' $(SOURCE_DIR)/CMakeLists.txt
	sed -i 's/popcount64/mypopcount64/g' $(SOURCE_DIR)/monetdb5/modules/mal/txtsim.c
	touch $@

#
# 4. Build
#
$(BUILD_DIR)/bin/monetdb: build/monetdbpatch_stamp
	(cd $(BUILD_DIR); \
	 cmake -DCMAKE_INSTALL_PREFIX=$(BUILD_DIR) \
	       -DCMAKE_TOOLCHAIN_FILE=$(RUMPRUN_CMAKE_TOOLCHAIN_FILE) \
		   -DWITH_READLINE=OFF \
		   -DPY3INTEGRATION=OFF \
		   -DRINTEGRATION=OFF \
		   $(SOURCE_DIR); \
	 cmake --build . ;\
	 cmake --build . --target install ;\
	)



.PHONY: clean
clean:
	(cd build; make clean)
	rm build/stamp_patch

.PHONY: distclean
distclean: clean
	rm -rf build
