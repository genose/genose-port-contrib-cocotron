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

# ## All automatic

packedVersion="${packedVersionMajor}${packedVersionMinor}${packedVersionRev}${packedVersionPlatform}${packedVersionArch}${packedVersionPack}"
echo "Installing ${packedProduct} ..."

productCrossPorting_Target_default_compiler_dir_system="${productCrossPorting_Target_default_compiler_dir_system}/${packedProduct}-${packedVersion}"


INCLUDE=$productCrossPorting_Target_default_compiler_dir_system/include
BIN=$productCrossPorting_Target_default_compiler_dir_system/bin
LIB=$productCrossPorting_Target_default_compiler_dir_system/lib

$scriptResources/downloadFilesIfNeeded.sh $productCrossPorting_downloadFolder -c "${packedVersionCheck}"  "http://downloads.sourceforge.net/gnuwin32/${packedProduct}-${packedVersion}-lib.zip" -c "${packedVersionCheck}" "http://downloads.sourceforge.net/gnuwin32/${packedProduct}-${packedVersion}-bin.zip"
 
cd $TMPDIR

$scriptResources/unarchiveFiles.sh  $productCrossPorting_downloadFolder $TMPDIR "${packedProduct}-${packedVersion}-bin ${packedProduct}-${packedVersion}-lib"  

    # ########## # ########## # ##########
    unarchivedFile=""
    find_unarchive_dir "${packedProduct}" "${TMPDIR}"
    # ##
    echo "@@@@@@@ ..... (${unarchivedFile})" | tee  >&2 >> $SCRIPT_TTY
    # ########## # ########## # ##########
    
    cd ${unarchivedFile}
pwd
cp -v bin/libssl32.dll $productCrossPorting_Target_default_compiler_dir_system/bin/ || echo "Copy Error ...."  && send_exit $0 $LINENO | tee >&2 >> $SCRIPT_TTY
cp -v lib/libcrypto.a $productCrossPorting_Target_default_compiler_dir_system/lib/ || echo "Error ...."  && send_exit $0 $LINENO | tee >&2 >> $SCRIPT_TTY
cp -v lib/libssl.a $productCrossPorting_Target_default_compiler_dir_system/lib/ || echo "Error ...."   && send_exit $0 $LINENO | tee >&2 >> $SCRIPT_TTY
cp -vr include/${packedProduct} $productCrossPorting_Target_default_compiler_dir_system/include/ || echo "Error ...."   && send_exit $0 $LINENO | tee >&2 >> $SCRIPT_TTY

