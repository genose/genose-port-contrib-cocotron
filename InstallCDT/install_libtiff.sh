#!/bin/sh
 
# ########## # ########### ########### ########### ##########
# ##
# ##    Cocotron installer community updates
# ##    Based from Christopher J. W. Lloyd
# ##        :: Cocotron project ::
# ##
# ##    Created by Genose.org (Sebastien Ray. Cotillard)
# ##    Date 10-oct-2016
# ##    last update 25-oct-2016
# ##
# ##    Please support genose.org, the author and his projects
# ##    
# ##    Based on genose.org tools
# ##
# ##    //////////////////////////////////////////////////////////////
# ##    // http://project2306.genose.org  // git :: project2306_ide //
# ##    /////////////////////////////////////////////////////////////
# ##
# ##    -- Cocotron community updates
# ##
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########


source $( find $(dirname $0) -name common_functions.sh -type f -print )
 
$scriptResources/downloadFilesIfNeeded.sh $downloadFolder ftp://ftp.remotesensing.org/pub/libtiff/${packedProduct}-${packedVersion}.tar.gz

$scriptResources/unarchiveFiles.sh  $downloadFolder $BUILD ${packedProduct}-${packedVersion}.tar.gz
cd   ${BUILD}/${BUILD}${packedProduct}-${packedVersion}

pwd 

INSTALL_PREFIX=${productCrossPorting_Target_compiler_dir_system}/libtiff
BINARY_PATH=$INSTALL_PREFIX/bin
INCLUDE_PATH=$INSTALL_PREFIX/include
LIBRARY_PATH=$INSTALL_PREFIX/lib
export CFLAGS="-DTIF_PLATFORM_CONSOLE"

echo "Install ${packedProduct} on TARGET : ${TARGET} ::  ${AS} ::  ${AR} :: ${RANLIB}"
mkdir -pv $BINARY_PATH
mkdir -pv $LIBRARY_PATH
mkdir -pv $INCLUDE_PATH

make clean

./configure --prefix="$INSTALL_PREFIX"   --disable-shared -host=$TARGET -target=$TARGET   AR=$AR CC=$GCC RANLIB=$RANLIB AS=$AS \
          --with-jpeg-include-dir=${productCrossPorting_Target_compiler_dir_system}/${libtiffProduct_depend}/include --with-jpeg-lib-dir=${productCrossPorting_Target_compiler_dir_system}/${libjpegProduct_install}/lib \
          --with-zlib-include-dir=${productCrossPorting_Target_compiler_dir_system}/${zlibProduct}-${zlibVersion}/include --with-zlib-lib-dir=${productCrossPorting_Target_compiler_dir_system}/${zlibProduct}-${zlibVersion}/lib \
         --enable-mdi --disable-jpeg12 --disable-cxx --disable-shared 

make && make install

