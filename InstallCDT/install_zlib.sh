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
 
echo "Installing ${packedProduct} ..."

# ## productCrossPorting_Target_default_compiler_dir_system="${productCrossPorting_Target_default_compiler_dir_system}/${packedProduct}-${packedVersion}"
# We need the headers/libraries, zlib.net only provides a dll or source which is more work

if [ -f "$productCrossPorting_Target_default_compiler_dir_system/${packedProduct}-${zlibVVersion}/lib/libz.dll.a" ]; then
    tty_echo " ${packedProduct} pre-installed ... (" "$productCrossPorting_Target_default_compiler_dir_system/${packedProduct}-${packedVersion}/lib/libz.dll.a" ")"
else
    tty_echo "#### Installing ${packedProduct}"
    $scriptResources/downloadFilesIfNeeded.sh $productCrossPorting_downloadFolder -c "${packedVersionCheck}" "ftp://ftp.zlatkovic.com/libxml/${packedProduct}-xxx.zip" 
   
    $scriptResources/unarchiveFiles.sh  $productCrossPorting_downloadFolder $productCrossPorting_Target_default_compiler_dir_system  "${packedProduct}-${packedVersion}"

    # ########## # ########## # ##########
    unarchivedFile=""
    find_unarchive_dir "${packedProduct}" "${productCrossPorting_Target_default_compiler_dir_system}"
    # ## echo "@@@@@@@ ..... (${unarchivedFile})" | tee  >&2 >> $SCRIPT_TTY
    # ########## # ########## # ##########
    
    cd ${unarchivedFile}
    cp -vp ${unarchivedFile}/lib/zlib.lib ${unarchivedFile}/lib/libz.a ||  echo "Error copy ..." && send_exit $0 $LINENO 
    cp -vp ${unarchivedFile}/lib/zdll.lib ${unarchivedFile}/lib/libz.dll.a ||  echo "Error copy ..."  && send_exit $0 $LINENO 

fi
tty_echo "#### ${packedProduct} installed in (${PWD}) "