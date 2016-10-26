#!/bin/sh

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
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



# #### # #### # ####
# ## set a default value awise a NULL / not declared param

# #### # #### # ####
# ## set a default value awise a NULL / not declared param
DEFAULT_FUNC_PARAM=""
DEFAULT="${DEFAULT_FUNC_PARAM}"
# #### # #### # ####


SCRIPT_TTY=$( (ps ax | grep -i "install.sh" || ps ax | grep -vi "install.sh" | grep -vi "$0" | grep -i "install" | grep -i ".sh"  | grep -vi "log" || ps ax | grep $$) | awk '{ print "/dev/tty" $2 }' | uniq )

# #### # #### # ####
export HISTTIMEFORMAT="%d/%m/%y %T "
set -o history

# ########### ########### ########### ########### ########### ########### ##########
# ## http://stackoverflow.com/questions/3572030/bash-script-absolute-path-with-osx
# ########### ########### ########### ########### ########### ########### ##########
declare realpathx_return="./"
realpathx() {

OURPWD=$PWD
cd "$(dirname "$1")"
LINK=$(readlink "$(basename "$1")")
while [ "$LINK" ]; do
cd "$(dirname "$LINK")"
LINK=$(readlink "$(basename "$1")")
done
REALPATH="$PWD/$(basename "$1")"
cd "$OURPWD"
# ## echo ":::: realpathx == ${REALPATH} "
    realpathx_return=${REALPATH}

}

realpathx $0
## 
installResources=$( dirname "${realpathx_return}/"  | grep -i "Resources"  && true ||  dirname $( find $( dirname $( dirname "${realpathx_return}/" ) ) -name common_functions.sh -type f -exec  dirname {} \;    )   )
##
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

# ## binutilsVersion=2.21-20111025
binutilsVersion="2.21.1"
binutilsProduct="binutils"

mingwruntimeVersion="3.20"
mingwruntimeProduct="mingwruntime"

mingwapiVersion="3.17:-2"
mingwapiProduct="mingwapi"

gmpVersion="4.2.3"
gmpProduct="gmp"

mpfrVersion="2.3.2"
binutilsProduct="mpfr"

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
# ########### ##########

productCrossPorting_Name="Cocotron"
productCrossPorting_Version="1.0"
productCrossPorting_Folder="/Developer/${productCrossPorting_Name}/${productCrossPorting_Version}"
productCrossPorting_downloadFolder="${productCrossPorting_Folder}/Downloads"
productCrossPorting_Target_default="Windows"
productCrossPorting_Target_default_arch="i386"
productCrossPorting_Target_default_arch_wordSize="32"
productCrossPorting_Target_default_compiler="gcc"

productCrossPorting_sourceFolder="${productCrossPorting_Folder}/Source"

productCrossPorting_Target_default_compiler_dir_build_platform="${productCrossPorting_Folder}/build/$productCrossPorting_Target_default/$productCrossPorting_Target_default_arch"
productCrossPorting_Target_default_compiler_dir_base_platform="${productCrossPorting_Folder}/$productCrossPorting_Target_default/$productCrossPorting_Target_default_arch"

productCrossPorting_Target_default_compiler_dir_base_interface="${productCrossPorting_Folder}/PlatformInterfaces/"
productCrossPorting_Target_default_compiler_dir_base_interface_compiler="${productCrossPorting_Folder}/PlatformInterfaces/"

productCrossPorting_Target_default_compiler_version="4.3.1"
productCrossPorting_Target_default_compiler_version_Date=""

productCrossPorting_Target_default_compiler_dir_name="i386-mingw32msvc/"
productCrossPorting_Target_default_compiler_dir_system=`pwd`/../system/${productCrossPorting_Target_default_compiler_dir_name}

productCrossPorting_Target_default_compiler_basedir="${productCrossPorting_Target_default_compiler_dir_base_platform}/${productCrossPorting_Target_default_compiler}-${productCrossPorting_Target_default_compiler_version}/"

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

productCrossPorting_Target_avail=("Windows" "Linux" "BSD" "Solaris" "Darwin")



# ## productCrossPorting_Target_default=""
# ## productCrossPorting_Target_default_arch=""
# ## productCrossPorting_Target_default_compiler_version=""
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
realpathx $0
install_script_check=$( basename $realpathx_return | grep -i "install" >/dev/null && echo "install" || echo "--NO--" )

if [  "${install_script_check}" == "install" ]; then
    tty_echo ":::: do  ${install_script_check} :: $0" 
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
    
    osVersion=${7-$DEFAULT}
    
    if [ ""$osVersion"" = "" ];then
            if [ ""$osVersion"" = "" -a ""$productCrossPorting_Target_default"" = "Solaris" ];then
                    osVersion="2.10"
            elif [ ""$osVersion"" = "" -a ""$productCrossPorting_Target_default"" = "FreeBSD" ];then
                    osVersion="7"
            else
                    osVersion=""
            fi
    else
            osVersion=$osVersion
    fi
    
    # ########## # ########### ########### ########### ##########
    # ########## # ########### ########### ########### ##########
    
    if [ $productCrossPorting_Target_default_arch = "x86_64" ];then
            productCrossPorting_Target_default_arch_wordSize="64"
    else
            productCrossPorting_Target_default_arch_wordSize="32"
    fi
fi

packedVersionMajor=""
packedVersionMinor=""
packedVersionRev=""
packedVersionPlatform=".win32"
packedVersionArch="-X86"
packedVersionCheck="${packedVersionMajor-xx}:${packedVersionMinor-xx}:${packedVersionRev-xx}:${packedVersionPlatform-xx}:${packedVersionArch-xx}"
packedVersion="${packedVersionMajor-xx}${packedVersionMinor-xx}${packedVersionRev-xx}${packedVersionPlatform-xx}${packedVersionArch-xx}"
packedProduct=""


packedVersion=$(            eval "echo "$( echo '${'$( basename $0 | tr "_" "\ " | tr "." "\ " | sed -e "s;\-;;g" | tr "[:upper:]" "[:lower:]" | awk '{ print $2 }' )'Version}') )
packedVersionMajor=$(       echo "${packedVersion}" | tr ":" "\ " | awk '{ print $1 }' | sed -e "s;\.;\ \.\ ;g"  | awk '{ print $1$2$3 }' | sed -e "s;xx;;g" | sed -e "s; ;;g"  )
packedVersionMinor=$(       echo "${packedVersion}" | tr ":" "\ " | awk '{ print $1 }' | sed -e "s;\.;\ \.\ ;g"  | awk '{ print $4$5 }' | sed -e "s;xx;;g" | sed -e "s; ;;g"  )

packedVersionRev=$(         echo "${packedVersion}" | tr ":" "\ " | awk '{ print $2 }' | sed -e "s;\.;\ \.\ ;g"  | awk '{ print $1$2$3 }' | sed -e "s;xx;;g" | sed -e "s; ;;g"  )
packedVersionPlatform=$(    echo "${packedVersion}" | tr ":" "\ " | awk '{ print $3 }' | sed -e "s;\.;\ \.\ ;g"  | awk '{ print $1$2$3 }' | sed -e "s;xx;;g" | sed -e "s; ;;g"  )

packedVersionArch=$(        echo "${packedVersion}" | tr ":" "\ " | awk '{ print $4 }' | sed -e "s;\.;\ \.\ ;g"  | awk '{ print $1$2$3 }' | sed -e "s;xx;;g" | sed -e "s; ;;g"  )
packedVersionPack=$(        echo "${packedVersion}" | tr ":" "\ " | awk '{ print $5 }' | sed -e "s;\.;\ \.\ ;g"  | awk '{ print $1$2$3 }' | sed -e "s;xx;;g" | sed -e "s; ;;g"  )

packedVersionCheck="${packedVersionMajor}:${packedVersionMinor}:${packedVersionRev_xml}:${packedVersionPlatform}:${packedVersionArch}:${packedVersionPack}"

packedProduct=$(            eval "echo "$( echo '${'$( basename $0 | tr "_" "\ " | tr "." "\ " | tr "[:upper:]" "[:lower:]" | awk '{ print $2 }' )'Product}') )
packedProduct_base=$(       eval "echo "$( echo '${'$( basename $0 | tr "_" "\ " | tr "." "\ " | tr "[:upper:]" "[:lower:]" | awk '{ print $2 }' )'Product_base}') )
packedProduct_depend=$(     eval "echo "$( echo '${'$( basename $0 | tr "_" "\ " | tr "." "\ " | tr "[:upper:]" "[:lower:]" | awk '{ print $2 }' )'Product_depend}') )

packedProduct_packed=$(     eval "echo "$( echo '${'$( basename $0 | tr "_" "\ " | tr "." "\ " | tr "[:upper:]" "[:lower:]" | awk '{ print $2 }' )'Product_packed}') )
packedProduct_type=$(       eval "echo "$( echo '${'$( basename $0 | tr "_" "\ " | tr "." "\ " | tr "[:upper:]" "[:lower:]" | awk '{ print $2 }' )'Product_type}') )

packedProduct_install=$(    eval "echo "$( echo '${'$( basename $0 | tr "_" "\ " | tr "." "\ " | tr "[:upper:]" "[:lower:]" | awk '{ print $2 }' )'Product_install}') )


GCC=$(   echo $( ls "${productCrossPorting_Target_default_compiler_dir_base_platform}/${productCrossPorting_Target_default_compiler}-${productCrossPorting_Target_default_compiler_version}"/bin/*gcc | head -n1 ) )
# ## |  tr -s " " ":" | cut -d':' -f 2 | awk "{print $1;  fflush();}"

AS=$(    echo $( ls "${productCrossPorting_Target_default_compiler_dir_base_platform}/${productCrossPorting_Target_default_compiler}-${productCrossPorting_Target_default_compiler_version}"/bin/*as | head -n1 ) )
AR=$(    echo $( ls "${productCrossPorting_Target_default_compiler_dir_base_platform}/${productCrossPorting_Target_default_compiler}-${productCrossPorting_Target_default_compiler_version}"/bin/*ar | head -n1 )  )
RANLIB=$( echo $( ls "${productCrossPorting_Target_default_compiler_dir_base_platform}/${productCrossPorting_Target_default_compiler}-${productCrossPorting_Target_default_compiler_version}"/bin/*ranlib | head -n1 ) )

INCLUDE="${productCrossPorting_Target_default_compiler_dir_system}/include"
BIN="${productCrossPorting_Target_default_compiler_dir_system}/bin"
LIB="${productCrossPorting_Target_default_compiler_dir_system}/lib"
 
export TARGET=$( $GCC -dumpmachine )
export MAKE=$( echo "${MAKE}" && true || which make )

BUILD=$( echo "/tmp/"$( basename $0 | tr "." " " | awk '{print $1}' ) )
TMPDIR=$( echo "/tmp/"$( basename $0 | tr "." " " | awk '{print $1}' ) )

mkdir -p $BUILD
rm -Rv $BUILD/* 2>/dev/null
 

mkdir -p $TMPDIR
rm -Rv $TMPDIR/* 2>/dev/null
# cd $TMPDIR

mkdir -p $productCrossPorting_Target_default_compiler_dir_system
mkdir -p $productCrossPorting_Target_default_compiler_dir_system/include
mkdir -p $productCrossPorting_Target_default_compiler_dir_system/bin
mkdir -p $productCrossPorting_Target_default_compiler_dir_system/lib

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

SYSTEM_HOST=$( uname -s | tr "[:upper:]" "[:lower:]" )
SYSTEM_HOST_VERSION=$( ((sw_vers -productVersion  2>/dev/null  ) ||   uname -r )   | tr "." " " | awk '{ print  $1"."$2 }'  )

echo "...."

SYSTEM_HOST_VERSION_NAME=$( uname -s | tr "[:upper:]" "[:lower:]" )
# ## system type
# ## 1 : MacOS
# ## 2 : Unix / GNU / Linux
# ## 3 : Windows
SYSTEM_HOST_TYPE=1
# ########
# ########
# ## Cocotrons Default Goal : Apple Cocoa -- > > Windows
SYSTEM_TARGET_TYPE=3
# ########
# ########

