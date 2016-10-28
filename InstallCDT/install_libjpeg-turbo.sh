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
echo "Installing ${packedProduct} ..."
$scriptResources/downloadFilesIfNeeded.sh $downloadFolder http://freefr.dl.sourceforge.net/project/${packedProduct}/${packedVersion}/${packedProduct}-${packedVersion}.tar.gz
 
$scriptResources/unarchiveFiles.sh  $productCrossPorting_downloadFolder $BUILD  "${packedProduct}-${packedVersion}"

    # ########## # ########## # ##########
    unarchivedFile=""
    find_unarchive_dir "${packedProduct}" "${BUILD}/${packedProduct}-${packedVersion}"
    # ## echo "@@@@@@@ ..... (${unarchivedFile})" | tee  >&2 >> $SCRIPT_TTY
    # ########## # ########## # ##########
    
    cd ${unarchivedFile}

make clean
productCrossPorting_Target_default_compiler_dir_system="${productCrossPorting_Target_default_compiler_dir_system}/${packedProduct_depend}"

./configure --prefix="$PREFIX"  --disable-shared --host=$TARGET --target=$TARGET  AR=$AR AS=$AS CC=$GCC RANLIB=$RANLIB --with-jpeg8

make && make install

tty_echo "#### ${packedProduct} installed in (${PWD}) "