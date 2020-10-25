cd build
cd msw
nmake /f makefile.vc  ^
   BUILD=release      ^
   SHARED=1           ^
   TARGET_CPU=X64     ^
   USE_ZLIB=sys       ^
   USE_EXPAT=sys      ^
   USE_LIBJPEG=sys    ^
   USE_LIBPNG=sys     ^
   USE_LIBTIFF=sys
if errorlevel 1 exit 1
MOVE /Y %LIBRARY_LIB%\vc_x64_dll\*.dll %LIBRARY_BIN%
