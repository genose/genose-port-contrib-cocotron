#!/bin/sh


# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
# ##
# ##    Created by Genose.org (Sebastien Ray. Cotillard)
# ##    Date 10-oct-2016
# ##    last update 31-oct-2016
# ##
# ##    Please support genose.org, the author and his projects
# ##    
# ##    Based on genose.org tools
# ##
# ##    //////////////////////////////////////////////////////////////
# ##    // http://project2306.genose.org  // git :: project2306_ide //
# ##    /////////////////////////////////////////////////////////////
# ##
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
# ##
# ##    -- Cocotron community updates
# ##
# ##    Cocotron installer community updates
# ##    Based from Christopher J. W. Lloyd
# ##        :: Cocotron project ::
# ##
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

# ## MOST of declared value are for transitionnal purpose ... Shall be deleted soon

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########


cat >> "${INSTALL_SCRIPT_DEF}" <<EOF

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

scriptResources=$installResources/scripts/

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

enableLanguages="c,objc,c++,obj-c++"

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

installFolder=/Developer
productName=Cocotron
productVersion=1.0

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

binutilsVersion=2.21-20111025
# ## binutilsVersion="2.21.1"
binutilsProduct="binutils"

mingwruntimeVersion="3.20"
mingwruntimeProduct="mingwruntime"

mingwapiVersion="3.17-2"
mingwapiProduct="mingwapi"

gmpVersion="4.2.3"
gmpProduct="gmp"

mpfrVersion="2.3.2"
mpfrProduct="mpfr"

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########


# ## Version ALLWAYS in format

# ## a.b.c:rev:platform:arch
# ## replace a position with xx
# ## a.b.xx:xx:win32:xx

# ## a.b.xx:xx:xx:noarch
# ## a.b.8:-g1:linux:i386
# ## a.b.4:-e4:linux:x86
# ## 16.xx.xx:xx:win32:xx

# ## if you do the follow ... uuuh, well ... don t blame me
# ## 16..8:xx:win32:xx

antigrainVersion="2.4:xx:xx:xx:xx"
antigrainProduct="agg"

freetypeVersion="2.3.5:-1:xx:xx:-bin"
freetypeProduct="freetype"

glutVersion="36:xx:xx:xx:ddls"
glutProduct="glut"

hunspellVersion="1.3.1:xx:xx:xx:xx"
hunspellProduct="hunspell"

iconvVersion="1.9.2:xx:.win32:xx:xx"
iconvProduct="iconv"

libjpegVersion="xx:.v8c:xx:xx:xx"
libjpegProduct_packed="src"
libjpegProduct_type="lib"
libjpegProduct="jpeg"
libjpegProduct_install="${libjpegProduct_type}${libjpegProduct}"


libjpegturboVersion="1.3.0:xx:xx:xx:xx"
libjpegturboProduct="libjpeg-turbo"
libjpegturboProduct_base="${libjpegProduct}"
libjpegturboProduct_depend="${libjpegProduct_type}${libjpegProduct}"

libtiffVersion="xx:xx:xx:xx:xx"
libtiffProduct="libtiff"
libtiffProduct_depend="${libjpegProduct}"

opensslVersion="0.9.8:h-1:xx:xx:xx"
opensslProduct="openssl"

pthreadVersion="xx:xx:-win32:x86:xx"
pthreadProduct_type="dll"
pthreadProduct="pthreads"

plibcVersion="0.1.5:xx:xx:xx:xx"
plibcProduct="plibc"

pngVersion="1.6.18:xx:xx:xx:xx"
pngProduct="png"

sqliteVersion="3150000:xx:-win32:-x86:-dll"
sqliteProduct="sqlite"

xml2Version="1.9.2:xx:.win32:xx:xx"
xml2Product="xml2"

zlibVersion="1.2.5:xx:.win32:xx:"
zlibProduct_type=""
zlibProduct="zlib"
zlibProduct_install="${zlibProduct_type}${zlibProduct}"

zlib_srcVersion="${zlibVersion}"
zlib_srcProduct="${zlibProduct}"

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

binutilsConfigureFlags=""

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

# #################
# URLs
# #################

# ########### ##########
# ## 2016 deprecated
# ## url_Download_GPL3_v1="https://code.google.com/archive/p/cocotron-tools-gpl3/downloads/"
# ########### ##########

# ########### ##########
# ## 2016/10 new
# ## but still deprecated ...
url_google_cocotron_Download_GPL3="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/cocotron-tools-gpl3"
url_google_cocotron_Download_ARCHIVE="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/"
# ########### ##########

EOF

productCrossPorting_default_Name="Cocotron"
productCrossPorting_default_Version="1.0"
if [ "${#SDK_STYLE}" -lt 2 ]; then
    productCrossPorting_default_Folder="/Developer/${productCrossPorting_default_Name}/${productCrossPorting_default_Version}"
else
    productCrossPorting_default_Folder="${SDK_STYLE_PATH}"
fi
    
productCrossPorting_default_downloadFolder="${productCrossPorting_default_Folder}/tmp/Downloads"
productCrossPorting_default_sourceFolder="${productCrossPorting_default_Folder}/tmp/Source"
productCrossPorting_default_binFolder="${productCrossPorting_default_Folder}/bin"

productCrossPorting_Target_default="windows"
productCrossPorting_Target_default_version=""
productCrossPorting_Target_default_arch="i386"
productCrossPorting_Target_default_arch_wordSize="32"

productCrossPorting_Target_default_Folder_arch="${productCrossPorting_default_Folder}/${productCrossPorting_Target_default_arch}"

# ## informative name
productCrossPorting_default_compiler="gcc"

productCrossPorting_Target_default_compiler_getLatest="--no--"
productCrossPorting_Target_default_compiler="mingw32msvc"
# ## destination dir shall not be changed
productCrossPorting_Target_default_compiler_name="mingw32msvc"
productCrossPorting_Target_default_compiler_version=""
productCrossPorting_Target_default_compiler_version_Date=""

productCrossPorting_Target_default_compiler_dir_name="${productCrossPorting_Target_default_arch}-${productCrossPorting_Target_default_compiler_name}/"
productCrossPorting_Target_default_compiler_dir_system="${productCrossPorting_default_Folder}/system/${productCrossPorting_Target_default_compiler_dir_name}"
#i386-pc-mingw32msvc$osVersion
productCrossPorting_Target_default_compiler="${productCrossPorting_Target_default_arch}-pc-${productCrossPorting_Target_default_compiler_name}${SYSTEM_TARGET_VERSION}"
#gcc / llvm


productCrossPorting_Target_default_compiler_dir_build_platform="${productCrossPorting_default_Folder}/build/$productCrossPorting_Target_default/$productCrossPorting_Target_default_arch"
productCrossPorting_Target_default_compiler_dir_base_platform="${productCrossPorting_default_Folder}/$productCrossPorting_Target_default/$productCrossPorting_Target_default_arch"

productCrossPorting_Target_default_compiler_dir_base_interface="${productCrossPorting_default_Folder}/PlatformInterfaces/"
productCrossPorting_Target_default_compiler_dir_base_interface_compiler="${productCrossPorting_default_Folder}/PlatformInterfaces/${productCrossPorting_Target_default_compiler}"


productCrossPorting_Target_default_compiler_basedir="${productCrossPorting_Target_default_compiler_dir_base_platform}/${productCrossPorting_Target_default_compiler}${productCrossPorting_Target_default_compiler_version}/"

productCrossPorting_Target_compiler_ConfigureFlags=""


productCrossPorting_Host_default_compiler_getLatest="--no--"
productCrossPorting_Host_default_compiler="gcc"
productCrossPorting_Host_default_compiler_name="gcc"
productCrossPorting_Host_default_compiler_version="4.3.1"
productCrossPorting_Host_default_compiler_version_Date="-02242010"


productCrossPorting_Host_default_compiler_basedir="${productCrossPorting_Target_default_compiler_dir_base_platform}/${productCrossPorting_Host_default_compiler}${productCrossPorting_Host_default_compiler_version}/"

productCrossPorting_Target_avail=$( find "${PWD}" -name archs -exec ls  -d {}   \;  | tr "\ " "\\n" )

echo "===== "${productCrossPorting_Target_avail[@]}


#finalise definition ....
# ## rebuilt later
