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



# #### # #### # ####
# ## set a default value awise a NULL / not declared param
DEFAULT_FUNC_PARAM=""
DEFAULT="${DEFAULT_FUNC_PARAM}"
# #### # #### # ####


# ## SCRIPT_TTY=$( (ps ax | grep -i "install.sh" || ps ax | grep -vi "install.sh" | grep -vi "$0" | grep -i "install" | grep -i ".sh"  | grep -vi "log" || ps ax | grep $$) | awk '{ print "/dev/tty" $2 }' | uniq )
 
SCRIPT_TTY=$( ps ax | grep -i "install.sh" || ps ax | grep -vi "install.sh" | grep -vi "$0" | grep -i "install" | grep -i ".sh"  | grep -vi "log" || ps ax | grep $$ )

SCRIPT_TTY=$( echo "${SCRIPT_TTY[@]}" |   sort  | uniq  |  head -n1 | awk '{ print "/dev/tty" $2 }'  )
# #### # #### # ####
# ##
echo "# ##  TTY on  ${SCRIPT_TTY[@]}"

export HISTTIMEFORMAT="%d/%m/%y %T "
set -o history

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

SYSTEM_HOST=$( uname -s | tr "[:upper:]" "[:lower:]" )
SYSTEM_HOST_VERSION=$( ((sw_vers -productVersion  2>/dev/null  ) ||   uname -r )   | tr "." " " | awk '{ print  $1"."$2 }'  )

 
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

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

if [ "${SYSTEM_HOST}" = "darwin" ]; then
	 
    # ## tty_echo "#### On darwin System, some compilation and binaries send error ;; we make terminal SED Bytecode error more Friendly :: export LC_CTYPE=C ; export LANG=C"
    export LC_CTYPE=C ; export LANG=C
  
fi
 

# ## determining full path of this script
realpathx "$0"
 
# #### # #### # ####
# ## set a default value awise a NULL / not declared param
 
# ## echo "Declared :::: " $0 " :::: returned :::: "$realpathx_return
## 
installResources=$( echo $( dirname $( find $( dirname $( dirname "${realpathx_return}/" | grep -i "Resources" ||  echo "${realpathx_return}/" ) ) -name common_functions.sh -type f -exec  dirname {} \;    )   ) )
install_script_check_script=$( basename $realpathx_return | grep -i "install\_" | grep -vi "\_log" || echo "--NO--" )
install_script_check_script="${install_script_check_script}" && [[ "${install_script_check_script}" == "--NO--" ]] || install_script_check_script=$( echo "${install_script_check_script}" | tr "\-" "\ " | awk '{print $2}' )

install_script_check=$(  basename $realpathx_return  | grep -vi "\_log" | tr "\/" "\\n" | grep -i "install" | grep -vi "installcdt"  || echo "--NO--" )

install_script_check=$( echo "${install_script_check[*]}" | tr " " "\\n" | tr "\." "\\n"| grep -i "install"   || echo "--NO--" )
 
 
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

scriptResources="$installResources/scripts"
toolResources="$installResources/tools"
 
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

INSTALL_SCRIPT_DIR=$(dirname $installResources  )
INSTALL_SCRIPT_LOG=/tmp/install_log.log
INSTALL_SCRIPT_LOG_ERR=/tmp/install_log.err.log

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
 
if [ ! -d "$installResources" ];then
tty_dialog "Unable to locate Resources directory at "$installResources
 exit 1
fi

PWD=$( echo $PWD || pwd )
    source $( find $installResources -name "common_declare_*.inc.sh" -type f -print )

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

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
