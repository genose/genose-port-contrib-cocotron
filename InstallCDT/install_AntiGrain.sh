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

./install_FreeType.sh

# ## All automatic

packedVersion="${packedVersionMajor}${packedVersionMinor}${packedVersionRev}${packedVersionPlatform}${packedVersionArch}${packedVersionPack}"
echo "Installing ${packedProduct} ..."

productCrossPorting_Target_compiler_dir_system="${productCrossPorting_Target_compiler_dir_system}/${packedProduct}-${packedVersion}"

echo " :::: ${productCrossPorting_Target_compiler_dir_system}"
send_exit
$scriptResources/downloadFilesIfNeeded.sh $productCrossPorting_downloadFolder -c "${packedVersionCheck}" "http://www.antigrain.com/${packedProduct}-${packedVersion}.zip"

$scriptResources/unarchiveFiles.sh  $productCrossPorting_downloadFolder $BUILD  "${packedProduct}-${packedVersion}"
# ## unzip -o $productCrossPorting_downloadFolder/agg-$AGG_VERSION.zip

     # ########## # ########## # ##########
    unarchivedFile=""
    find_unarchive_dir "${packedProduct}" "${BUILD}"
    # ## echo "@@@@@@@ ..... (${unarchivedFile})" | tee  >&2 >> $SCRIPT_TTY
    # ########## # ########## # ##########
    
   cd ${unarchivedFile} || echo "Error ...." && ls -la $BUILD  && send_exit $0 $LINENO  | tee >&2 >> $SCRIPT_TTY
pwd

cd src || echo "Error ...." && ls -la $BUILD  && send_exit $0 $LINENO  | tee >&2 >> $SCRIPT_TTY

# Create a fake Cocotron uname for the build system
cat > uname <<EOF
#!/bin/sh

source $( find $(dirname $0) -name common_functions.sh -type f -print )

echo "Cocotron"
EOF
chmod +x uname
cd ..

# Create a Makefile.in.Cocotron
cat > Makefile.in.Cocotron <<EOF
AGGLIBS= -lagg 
AGGCXXFLAGS = -O3
CXX = ${productCrossPorting_Target_compiler_basedir}/bin/i386-pc-mingw32msvc-g++
C = ${productCrossPorting_Target_compiler_basedir}/bin/i386-pc-mingw32msvc-gcc
LIB = ${CrossPorting_Target_compiler_basedir}/bin/i386-pc-mingw32msvc-ar cr

.PHONY : clean
EOF

# include the local uname

PATH=.:$PATH

rm gpc/*
rm include/agg_conv_gpc.h
# The makefiles expect a .c file, so make an empty one
touch gpc/gpc.c

make

mkdir -p $productCrossPorting_Target_compiler_dir_system
(tar -cf - --exclude "Makefile*" include) | (cd $productCrossPorting_Target_compiler_dir_system;tar -xf -)
cp src/libagg.a $productCrossPorting_Target_compiler_dir_system
