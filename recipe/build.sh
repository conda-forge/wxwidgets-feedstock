#!/usr/env/bin bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./src/tiff/config
cp $BUILD_PREFIX/share/gnuconfig/config.* ./src/expat/expat/conftools
cp $BUILD_PREFIX/share/gnuconfig/config.* ./src/png
cp $BUILD_PREFIX/share/gnuconfig/config.* .

set -ex

if [[ "$target_platform" == "osx"* ]]; then
  extra_flags="--with-osx_cocoa"
  extra_flags="${extra_flags} --with-macosx-version-min=${MACOSX_DEPLOYMENT_TARGET}"
else
  extra_flags="--with-gtk=\"3\""
fi

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
  extra_flags="--build=${BUILD} --host=${HOST}"
fi

./configure --help

./configure \
  --prefix=${PREFIX} \
  --enable-cxx11 \
  --with-libjpeg \
  --with-libpng \
  --with-regex \
  --with-libtiff \
  --with-liblzma \
  --with-zlib \
  --with-expat \
  --with-libiconv \
  --with-libcurl \
  --with-opengl \
  --disable-tests \
  ${extra_flags} || (cat config.log && exit 1)

[[ "$target_platform" == "win-64" ]] && patch_libtool

make -j ${CPU_COUNT}
make install
