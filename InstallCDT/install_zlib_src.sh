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

$scriptResources/downloadFilesIfNeeded.sh $downloadFolder -c "${packedVersionCheck}" "http://freefr.dl.sourceforge.net/project/libpng/${packedProduct}/${packedVersion}/${packedProduct}-${packVersion}.tar.bz2"

$scriptResources/unarchiveFiles.sh  $productCrossPorting_downloadFolder $BUILD  "${packedProduct}-${packedVersion}"

    # ########## # ########## # ##########
    unarchivedFile=""
    find_unarchive_dir "${packedProduct}" "${BUILD}"
    # ## echo "@@@@@@@ ..... (${unarchivedFile})" | tee  >&2 >> $SCRIPT_TTY
    # ########## # ########## # ##########
    
    cd ${unarchivedFile}
pwd 
 
INSTALL_PREFIX=${productCrossPorting_Target_default_compiler_dir_system}/${packedProduct}-${packVersion}/
BINARY_PATH=$INSTALL_PREFIX/bin
INCLUDE_PATH=$INSTALL_PREFIX/include
LIBRARY_PATH=$INSTALL_PREFIX/lib

make clean
make -p $BINARY_PATH
make -p $LIBRARY_PATH
make -p $INCLUDE_PATH

PATH=${productCrossPorting_Target_default_compiler_dir_build_platform}/$( echo "${binutilsProduct}-${binutilsVersion}" | sed -e "s;:;;g"  | | sed -e "s;xx;;" )/binutils:$PATH make -f win32/Makefile.gcc  CC=$GCC AR=$AR RANLIB=$RANLIB RCFLAGS="-I ${productCrossPorting_Target_default_compiler_dir_base_interface}/${productCrossPorting_Target_default_compiler_dir_name}/include -DGCC_WINDRES" BINARY_PATH=$BINARY_PATH INCLUDE_PATH=$INCLUDE_PATH LIBRARY_PATH=$LIBRARY_PATH SHARED_MODE=1 install

tty_echo "#### ${packedProduct} installed in (${PWD}) "