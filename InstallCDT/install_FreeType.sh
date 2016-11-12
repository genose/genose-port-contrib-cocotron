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

./install_zlib.sh

# ## All automatic

packedVersion="${packedVersionMajor}${packedVersionMinor}${packedVersionRev}${packedVersionPlatform}${packedVersionArch}${packedVersionPack}"
echo "Installing ${packedProduct} ..."

$scriptResources/downloadFilesIfNeeded.sh $productCrossPorting_downloadFolder -c "${packedVersionCheck}" "http://downloads.sourceforge.net/gnuwin32/${packedProduct}-${packedVersion}${packedVersionPack}.zip"

productCrossPorting_Target_compiler_dir_system="${productCrossPorting_Target_compiler_dir_system}/${packedProduct}-${packedVersion}"

$scriptResources/unarchiveFiles.sh  $productCrossPorting_downloadFolder $productCrossPorting_Target_compiler_dir_system   "${packedProduct}-${packedVersion}${packedVersionPack}"

