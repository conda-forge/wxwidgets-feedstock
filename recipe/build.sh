echo $target_platform

if [[ "$target_platform" == "osx"* ]]; then
  ./configure \
      --prefix=${PREFIX} \
      --with-opengl \
      --with-osx_cocoa
else
  ./configure \
     --prefix=${PREFIX} \ 
    --with-opengl \
    --with-gtk="3"
fi 


[[ "$target_platform" == "win-64" ]] && patch_libtool

make -j ${CPU_COUNT}
make install
