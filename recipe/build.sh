#!/usr/env/bin bash

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
