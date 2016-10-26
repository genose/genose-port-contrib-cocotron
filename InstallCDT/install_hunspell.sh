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

$scriptResources/downloadFilesIfNeeded.sh $productCrossPorting_downloadFolder -c "${packedVersionCheck}" http://downloads.sourceforge.net/${packedProduct}/${packedProduct}-${packedVersion}.tar.gz
 cd $BUILD
$scriptResources/unarchiveFiles.sh  $productCrossPorting_downloadFolder $BUILD   "${packedProduct}-${packedVersion}"
# ## tar -xvzf $productCrossPorting_downloadFolder/hunspell-${packedVersion}.tar.gz

    # ########## # ########## # ##########
    unarchivedFile=""
    find_unarchive_dir "${packedProduct}" "${TMPDIR}"
    # ##
    echo "@@@@@@@ ..... (${unarchivedFile})" | tee  >&2 >> $SCRIPT_TTY
    # ########## # ########## # ##########
    
    cd ${unarchivedFile} || echo "Error ...." && ls -la $BUILD  && send_exit $0 $LINENO  | tee >&2 >> $SCRIPT_TTY
pwd

cd src || echo "Error ...." && ls -la $BUILD  && send_exit $0 $LINENO  | tee >&2 >> $SCRIPT_TTY

productCrossPorting_Target_default_compiler_dir_system="${productCrossPorting_Target_default_compiler_dir_system}/${packedProduct}-${packedVersion}"
 
${productCrossPorting_Target_default_compiler_basedir}/bin/i386-pc-mingw32msvc-g++ -shared -O2 -ansi -pedantic ${packedProduct}/affentry.cxx ${packedProduct}/affixmgr.cxx ${packedProduct}/hashmgr.cxx ${packedProduct}/suggestmgr.cxx ${packedProduct}/csutil.cxx ${packedProduct}/phonet.cxx ${packedProduct}/${packedProduct}.cxx ${packedProduct}/filemgr.cxx ${packedProduct}/hunzip.cxx ${packedProduct}/replist.cxx parsers/textparser.cxx parsers/firstparser.cxx parsers/htmlparser.cxx parsers/latexparser.cxx parsers/manparser.cxx -I${packedProduct} -Iwin_api win_api/${packedProduct}dll.c -o ${packedProduct}."${packedVersion}".dll -Wl,--out-implib,lib${packedProduct}."${packedVersion}".a


cp win_api/${packedProduct}dll.h                $productCrossPorting_Target_default_compiler_dir_system/include  || echo "Error ...."  && send_exit $0 $LINENO  | tee >&2 >> $SCRIPT_TTY
cp ${packedProduct}/*.hxx                       $productCrossPorting_Target_default_compiler_dir_system/include  || echo "Error ...."  && send_exit $0 $LINENO  | tee >&2 >> $SCRIPT_TTY
cp ${packedProduct}/*.h                         $productCrossPorting_Target_default_compiler_dir_system/include  || echo "Error ...."  && send_exit $0 $LINENO  | tee >&2 >> $SCRIPT_TTY
cp "${packedProduct}.${packedVersion}".dll      $productCrossPorting_Target_default_compiler_dir_system/bin      || echo "Error ...."  && send_exit $0 $LINENO  | tee >&2 >> $SCRIPT_TTY
cp "lib${packedProduct}.${packedVersion}".a     $productCrossPorting_Target_default_compiler_dir_system/lib      || echo "Error ...."  && send_exit $0 $LINENO  | tee >&2 >> $SCRIPT_TTY

