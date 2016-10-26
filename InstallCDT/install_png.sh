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
 
packedVersionMajor="1.6"
packedVersionMinor=".18"
packedVersionRev=""
packedVersionPlatform=""
packedVersionArch=""
packedVersionCheck="${packedVersionMajor}:${packedVersionMinor}:${packedVersionRev}:${packedVersionPlatform}:${packedVersionArch}"
packedVersion="${packedVersionMajor}${packedVersionMinor}${packedVersionRev}${packedVersionPlatform}${packedVersionArch}"
packedProduct="libpng"

tty_echo "Installing ${packedProduct}"
$scriptResources/downloadFilesIfNeeded.sh $downloadFolder ftp://ftp.simplesystems.org/pub/libpng/png/src/$( echo ${packedVersionMajor} | sed -e "s;.;;g" ) /${packedProduct}-${packedVersion}.tar.gz

    $scriptResources/unarchiveFiles.sh  $downloadFolder $BUILD  "${packedProduct}-${packedVersion}"

    # ########## # ########## # ##########
    unarchivedFile=""
    find_unarchive_dir "${packedProduct}" "${BUILD}"
    # ## echo "@@@@@@@ ..... (${unarchivedFile})" | tee  >&2 >> $SCRIPT_TTY
    # ########## # ########## # ##########
    cd ${unarchivedFile}/lib 
pwd 

INSTALL_PREFIX=${productCrossPorting_Target_default_compiler_dir_system}/libpng
BINARY_PATH=$INSTALL_PREFIX/bin
INCLUDE_PATH=$INSTALL_PREFIX/include
LIBRARY_PATH=$INSTALL_PREFIX/lib

export LDFLAGS="-L$(ls -d ${productCrossPorting_Target_default_compiler_dir_system}/zlib*| head -n1 )/lib"
export CFLAGS="-I$(ls -d ${productCrossPorting_Target_default_compiler_dir_system}/zlib* | head -n1 )/include"

GCC="$GCC $CFLAGS"
make clean
make -p $BINARY_PATH
make -p $LIBRARY_PATH
make -p $INCLUDE_PATH

echo ./configure --prefix="$INSTALL_PREFIX"   --disable-shared --host=$TARGET --target=$TARGET  AR=$AR CC=$GCC RANLIB=$RANLIB AS=$AS
./configure --prefix="$INSTALL_PREFIX"  --disable-shared --host=$TARGET --target=$TARGET   -with-zlib-prefix=$BASEDIR/zlib* AR="$AR" CC="$GCC" RANLIB="$RANLIB" AS="$AS"

make && make install

