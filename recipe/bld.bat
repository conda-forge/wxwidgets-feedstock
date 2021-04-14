mkdir build_
if errorlevel 1 exit 1
cd build_
if errorlevel 1 exit 1

:REM The very first version of the library we built had the dlls ending in
:REM x64_custom. We maintain it here for backward compatibility

cmake  ^
    -GNinja ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DwxUSE_ZLIB=sys    ^
    -DwxUSE_EXPAT=sys   ^
    -DwxUSE_LIBJPEG=sys ^
    -DwxUSE_LIBPNG=sys  ^
    -DwxUSE_LIBTIFF=sys ^
    -DwxVENDOR=x64_custom ^
    -DVENDOR=x64_custom ^
    ..
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1

MOVE /Y %LIBRARY_LIB%\vc_x64_dll\*.dll %LIBRARY_BIN%
