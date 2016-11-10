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

productCrossPorting_Name="Cocotron"
productCrossPorting_Version="1.0"
productCrossPorting_Folder="/Developer/${productCrossPorting_Name}/${productCrossPorting_Version}"
productCrossPorting_downloadFolder="${productCrossPorting_Folder}/Downloads"
productCrossPorting_sourceFolder="${productCrossPorting_Folder}/Source"
productCrossPorting_binFolder="${productCrossPorting_Folder}/bin"

productCrossPorting_default_compiler="gcc"

productCrossPorting_Target_default="Windows"
productCrossPorting_Target_default_arch="i386"
productCrossPorting_Target_default_arch_wordSize="32"

productCrossPorting_Target_default_compiler="gcc"

productCrossPorting_Target_default_compiler_dir_build_platform="${productCrossPorting_Folder}/build/$productCrossPorting_Target_default/$productCrossPorting_Target_default_arch"
productCrossPorting_Target_default_compiler_dir_base_platform="${productCrossPorting_Folder}/$productCrossPorting_Target_default/$productCrossPorting_Target_default_arch"

productCrossPorting_Target_default_compiler_dir_base_interface="${productCrossPorting_Folder}/PlatformInterfaces/"
productCrossPorting_Target_default_compiler_dir_base_interface_compiler="${productCrossPorting_Folder}/PlatformInterfaces/"

productCrossPorting_Target_default_compiler_version="4.3.1"
productCrossPorting_Target_default_compiler_version_Date=""

productCrossPorting_Target_default_compiler_dir_name="i386-mingw32msvc/"
productCrossPorting_Target_default_compiler_dir_system=`pwd`/../system/${productCrossPorting_Target_default_compiler_dir_name}

productCrossPorting_Target_default_compiler_basedir="${productCrossPorting_Target_default_compiler_dir_base_platform}/${productCrossPorting_Target_default_compiler}-${productCrossPorting_Target_default_compiler_version}/"


productCrossPorting_set_compiler="gcc"
productCrossPorting_set_compiler_dir_system="${productCrossPorting_Target_default_compiler_dir_system}"



if [ -f "${productCrossPorting_Target_default_compiler_dir_base_interface}" ]; then
    echo ""
else
    mkdir -p $productCrossPorting_downloadFolder
    mkdir -p $productCrossPorting_sourceFolder
    
    mkdir -p $productCrossPorting_Target_default_compiler_dir_build_platform
    mkdir -p $productCrossPorting_Target_default_compiler_dir_base_platform
    
    mkdir -p $productCrossPorting_Target_default_compiler_dir_base_interface
    mkdir -p $productCrossPorting_Target_default_compiler_basedir
    
    mkdir -p $productCrossPorting_Target_default_compiler_dir_system/bin
    mkdir -p $productCrossPorting_Target_default_compiler_dir_system/lib
    mkdir -p $productCrossPorting_Target_default_compiler_dir_system/include
fi

productCrossPorting_Target_avail=("Windows" "Linux" "BSD" "Solaris" "darwin")



# ## productCrossPorting_Target_default=""
# ## productCrossPorting_Target_default_arch=""
# ## productCrossPorting_Target_default_compiler_version=""
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

if [  "${install_script_check_script}" == "--NO--" ] && [  "${install_script_check}" == "--NO--" ]; then
     tty_echo ":::: NO install  ${install_script_check} :: $install_script_check_script :: $0"
    
elif [  "${install_script_check}" == "install" ]; then
    tty_echo ":::: Begin install  ${install_script_check} :: $install_script_check_script :: $0"
    
    if [ ""${1-$DEFAULT}"" = "" ]; then
      productCrossPorting_Target_default="${productCrossPorting_Target_default}"
    else
      productCrossPorting_Target_default=${1-$DEFAULT}
    fi
    # ########## # ########### ########### ########### ##########
    # ########## # ########### ########### ########### ##########
    
    if [ ""${2-$DEFAULT}"" = "" ];then
      productCrossPorting_Target_default_arch="${productCrossPorting_Target_default_arch}"
    else
      productCrossPorting_Target_default_arch=${2-$DEFAULT}
    fi
    # ########## # ########### ########### ########### ##########
    # ########## # ########### ########### ########### ##########
    
    if [ ""${3-$DEFAULT}"" = "" ];then
            productCrossPorting_Target_default_compiler="${productCrossPorting_Target_default_compiler}"
    else
            productCrossPorting_Target_default_compiler=${3-$DEFAULT}
    fi
    # ########## # ########### ########### ########### ##########
    # ########## # ########### ########### ########### ##########
     
    # ## productCrossPorting_Target_default_compiler_version="4.3.1"
    
    if [ ""${4-$DEFAULT}"" = "" ];then
      productCrossPorting_Target_default_compiler_version="${productCrossPorting_Target_default_compiler_version}"
    else
      productCrossPorting_Target_default_compiler_version=${4-$DEFAULT}
    fi
    # ########## # ########### ########### ########### ##########
    # ########## # ########### ########### ########### ##########
    
    # ########## # ########### ########### ########### ##########
    # ########## # ########### ########### ########### ##########
    
    if [ ""${5-$DEFAULT}"" = "" ];then
            if [ "$productCrossPorting_Target_default_compiler" = "gcc" ]; then
                    productCrossPorting_Target_default_compiler_version=$productCrossPorting_Target_default_compiler_version
            elif [ "$productCrossPorting_Target_default_compiler" = "llvm-clang" ]; then
                    productCrossPorting_Target_default_compiler_version="trunk"
            else
                    tty_echo "Unknown $productCrossPorting_Target_default_compiler "$productCrossPorting_Target_default_compiler
                    send_exit $0 $LINENO
            fi
    else
            productCrossPorting_Target_default_compiler_version=${5-$DEFAULT}
    fi
    
    # ########## # ########### ########### ########### ##########
    # ########## # ########### ########### ########### ##########
    
    if [ ""${6-$DEFAULT}"" = "" ];then
            if [ "$productCrossPorting_Target_default_compiler" = "gcc" ]; then
            productCrossPorting_Target_default_compiler_version_Date="-02242010"
            elif [ "$productCrossPorting_Target_default_compiler" = "llvm-clang" ]; then
            productCrossPorting_Target_default_compiler_version_Date="-05042011"
            else
                    tty_echo "Unknown $productCrossPorting_Target_default_compiler "$productCrossPorting_Target_default_compiler
                    exit 1
            fi
    else
            productCrossPorting_Target_default_compiler_version_Date="-"${6-$DEFAULT}
    fi
    
    # ########## # ########### ########### ########### ##########
    # ########## # ########### ########### ########### ##########
    
    osVersion=${7-${DEFAULT}}
    
    if [ "${osVersion}" = "" ];then
            if [ "${osVersion}" = "" ] && [ "${productCrossPorting_Target_default}" = "Solaris" ]; then
                    osVersion="2.10"
            elif [ "${osVersion}" = "" ] && [ "${productCrossPorting_Target_default}" = "FreeBSD" ]; then
                    osVersion="7"
            else
                    osVersion=""
            fi
    else
            osVersion="${osVersion}"
    fi
    
    # ########## # ########### ########### ########### ##########
    # ########## # ########### ########### ########### ##########
    
    if [ $productCrossPorting_Target_default_arch = "x86_64" ];then
            productCrossPorting_Target_default_arch_wordSize="64"
    else
            productCrossPorting_Target_default_arch_wordSize="32"
    fi
fi
