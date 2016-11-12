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

productCrossPorting_Target_compiler_dir_system="${productCrossPorting_Target_compiler_dir_system}/${packedProduct}-${packedVersion}"

rm -Rv $productCrossPorting_downloadFolder/${packedProduct}*

$scriptResources/downloadFilesIfNeeded.sh $productCrossPorting_downloadFolder "https://sqlite.org/2016/${packedProduct}${packedVersionPack}${packedVersionPlatform}${packedVersionArch}-${packedVersion}.zip"
# ## "http://cocotron.googlecode.com/files/sqlite-dll-win32-x86-3070600.zip"

$scriptResources/unarchiveFiles.sh  $productCrossPorting_downloadFolder "${TMPDIR}" "${packedProduct}${packedVersionPack}${packedVersionPlatform}${packedVersionArch}-${packedVersion}"
    
    # ########## # ########## # ##########
    unarchivedFile=""
    find_unarchive_dir "${packedProduct}" "${TMPDIR}"
    # ## echo "@@@@@@@ ..... (${unarchivedFile})" | tee  >&2 >> $SCRIPT_TTY
    # ########## # ########## # ##########
    
    cd ${unarchivedFile}
    
    cp -vp sqlite3.* ${productCrossPorting_Target_compiler_dir_system}/bin/

# ## build the new binarie file like :: cp -vp $productCrossPorting_Target_compiler_dir_system/bin/sqlite3.dll $productCrossPorting_Target_compiler_dir_system/lib/libsqlite3.a

${productCrossPorting_Target_compiler_basedir}/bin/i386-pc-mingw32msvc-dlltool --def ${productCrossPorting_Target_compiler_dir_system}/bin/sqlite3.def --dllname sqlite3.dll --output-lib ${productCrossPorting_Target_compiler_dir_system}/lib/libsqlite3.a


tty_echo "#### ${packedProduct} installed in (${PWD}) "