#!/bin/bash
 
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
 
packedVersionMajor=""
packedVersionMinor=""
packedVersionRev=".v8c"
packedVersionPlatform=""
packedVersionArch=""
packedVersionCheck="${packedVersionMajor}:${packedVersionMinor}:${packedVersionRev}:${packedVersionPlatform}:${packedVersionArch}"
packedVersion="${packedVersionMajor}${packedVersionMinor}${packedVersionRev}${packedVersionPlatform}${packedVersionArch}"
packedProduct="jpegsrc"

$scriptResources/downloadFilesIfNeeded.sh $productCrossPorting_downloadFolder http://www.ijg.org/files/${packedProduct}${packedVersion}.tar.gz

$scriptResources/unarchiveFiles.sh $productCrossPorting_downloadFolder $BUILD  ${packedProduct}${packedVersion} 


    # ########## # ########## # ##########
    unarchivedFile=""
    find_unarchive_dir "${packedProduct}" "${BUILD}/${packedProduct}-${packedVersion} "
    # ## echo "@@@@@@@ ..... (${unarchivedFile})" | tee  >&2 >> $SCRIPT_TTY
    # ########## # ########## # ##########
    
    cd ${unarchivedFile}

echo "***************************************** *"
echo "***************************************** *"
echo "Configure with  :: "
echo " --prefix=$productCrossPorting_Target_default_compiler_dir_system "
echo " --disable-shared "
echo " --host=$TARGET "
echo " --target=$TARGET "
echo " CC=$GCC "
echo " RANLIB=" $RANLIB
echo "***************************************** *"
echo "***************************************** *"

./configure --prefix="$productCrossPorting_Target_default_compiler_dir_system" --disable-shared -host=$TARGET -target=$TARGET CC=$GCC RANLIB=$RANLIB

tty_echo "Install ${packedProduct} on TARGET : ${TARGET} ::  ${AS} ::  ${AR} :: ${RANLIB}"

make && make install

