@echo ON

mkdir build_
if errorlevel 1 exit 1
cd build_
if errorlevel 1 exit 1

cmake %CMAKE_ARGS% ^
    -GNinja ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DwxUSE_REGEX=sys   ^
    -DwxUSE_ZLIB=sys    ^
    -DwxUSE_EXPAT=sys   ^
    -DwxUSE_LIBJPEG=sys ^
    -DwxUSE_LIBPNG=sys  ^
    -DwxUSE_LIBTIFF=sys ^
    -DwxUSE_LIBLZMA=sys ^
    -DwxBUILD_VENDOR= ^
    ..
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1

MOVE /Y %LIBRARY_LIB%\vc_x64_dll\*.dll %LIBRARY_BIN%
