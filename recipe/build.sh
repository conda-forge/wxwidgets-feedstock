#!/usr/env/bin bash

set -ex

mkdir forgebuild
cd forgebuild

cmake_config_args=(
    -DBUILD_SHARED_LIBS=ON
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=$PREFIX
    -DwxBUILD_CXX_STANDARD=11
    -DwxBUILD_TESTS=OFF
    -DwxUSE_EXPAT=sys
    -DwxUSE_LIBICONV=sys
    -DwxUSE_LIBJPEG=sys
    -DwxUSE_LIBLZMA=sys
    -DwxUSE_LIBPNG=sys
    -DwxUSE_LIBTIFF=sys
    -DwxUSE_OPENGL=sys
    -DwxUSE_REGEX=sys
    -DwxUSE_WEBREQUEST_CURL=ON
    -DwxUSE_ZLIB=sys
)

if [[ "$target_platform" == "osx"* ]]; then
  cmake_config_args+=(
    -DwxBUILD_TOOLKIT=osx_cocoa
  )
else
  cmake_config_args+=(
    -DwxBUILD_TOOLKIT=gtk3
  )
fi

cmake ${CMAKE_ARGS} -G "Ninja" .. "${cmake_config_args[@]}"
cmake --build . --config Release -- -j${CPU_COUNT}
cmake --build . --config Release --target install
