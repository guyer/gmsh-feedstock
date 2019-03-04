#!/bin/bash
# see http://conda.pydata.org/docs/build.html for hacking instructions.

set -e

if [[ "$c_compiler" == "gcc" ]]; then
  export PATH="${PATH}:${BUILD_PREFIX}/${HOST}/sysroot/usr/lib:${BUILD_PREFIX}/${HOST}/sysroot/usr/include"
fi

# unpack.
mkdir build
cd build

# build.
cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DENABLE_OS_SPECIFIC_INSTALL=OFF \
    -DENABLE_PETSC=OFF \
    -DENABLE_SLEPC=OFF \
    .. | tee cmake.log 2>&1

make -j${CPU_COUNT} | tee make.log 2>&1
make install | tee install.log 2>&1

# vim: set ai et nu:
