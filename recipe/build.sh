#!/usr/env/bin bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./src/tiff/config
cp $BUILD_PREFIX/share/gnuconfig/config.* ./src/expat/expat/conftools
cp $BUILD_PREFIX/share/gnuconfig/config.* ./src/png
cp $BUILD_PREFIX/share/gnuconfig/config.* .

set -ex
echo $target_platform

if [[ "$target_platform" == "osx"* ]]; then
  TARGET_PLATFORM_CONFIGURE_FLAGS="--with-osx_cocoa"
else
  TARGET_PLATFORM_CONFIGURE_FLAGS="--with-gtk=\"3\""
fi

./configure \
  --prefix=${PREFIX} \
  --with-opengl \
  ${TARGET_PLATFORM_CONFIGURE_FLAGS} || cat config.log

[[ "$target_platform" == "win-64" ]] && patch_libtool

make -j ${CPU_COUNT}
make install
