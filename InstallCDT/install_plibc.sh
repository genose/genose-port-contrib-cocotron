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


INCLUDE="${productCrossPorting_Target_default_compiler_dir_system}/include"
BIN="${productCrossPorting_Target_default_compiler_dir_system}/bin"
LIB="${productCrossPorting_Target_default_compiler_dir_system}/lib"

# ## All automatic

packedVersion="${packedVersionMajor}${packedVersionMinor}${packedVersionRev}${packedVersionPlatform}${packedVersionArch}${packedVersionPack}"
echo "Installing ${packedProduct} ..."
rm -Rv ${TMPDIR}/${packedProduct}*
$scriptResources/downloadFilesIfNeeded.sh $productCrossPorting_downloadFolder  -c "${packedVersionCheck}" "http://sourceforge.net/projects/${packedProduct}/files/plibc/${plibVersion}/${packedProduct}-${packedVersion}.zip"

$scriptResources/unarchiveFiles.sh  $productCrossPorting_downloadFolder $TMPDIR "${packedProduct}-${packedVersion}"  

    # ########## # ########## # ##########
    unarchivedFile=""
    find_unarchive_dir "${packedProduct}" "${TMPDIR}"
    # ## echo "@@@@@@@ ..... (${unarchivedFile})" | tee  >&2 >> $SCRIPT_TTY
    # ########## # ########## # ##########
    
    cd ${unarchivedFile}
pwd
mkdir -p $productCrossPorting_Target_default_compiler_dir_system/bin
cp bin/libplibc-1.dll  $productCrossPorting_Target_default_compiler_dir_system/bin || send_exit $0 $LINENO

mkdir -p $productCrossPorting_Target_default_compiler_dir_system/lib
cp lib/libplibc.dll.a $productCrossPorting_Target_default_compiler_dir_system/lib/libplibc.a || send_exit $0 $LINENO

mkdir -p $productCrossPorting_Target_default_compiler_dir_system/include
cp -Rv include/* $productCrossPorting_Target_default_compiler_dir_system/include/ || send_exit $0 $LINENO

tty_echo "#### ${packedProduct} installed in (${PWD}) "