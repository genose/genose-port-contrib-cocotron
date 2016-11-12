#!/bin/sh


# ########## # ########### ########### ########### ##########
# ##
# ##    Cocotron installer community updates
# ##    Based from Christopher J. W. Lloyd
# ##        :: Cocotron project ::
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
# ##    -- Cocotron community updates
# ##
# ########## # ########### ########### ########### ##########
 

# ########## # ########### ########### ########### ##########
# ##
# ##    Modified 10-oct-2016 by Genose.org (Sebastien Ray. Cotillard)
# ##
# ##    Change Log :
# ##
# ##		- Loves "# ## " sequence
# ##		- Hates so much, but when it cant be, Loves "long shell sentences " when don t know alternative
# ##        - Script Cosmetics
# ##        - More Screen & Script Cosmetics ...
# ##        - Lots and Lots More Screen & Script Cosmetics ...
# ##        - Lots and Lots More GUI Friendly ...
# ##
# ##        - Separated logs in 3 parts (User Screen progress, Error log, Install log)
# ##
# ##        - Zip / Tar / GZ, platform dependant uniformisation / standardisation
# ##
# ##    - Curl and Download Improvements (see ressources/scripts/downloadIfNeeded.sh)
# ## 	- Curl based Version checker for download updates ( Http and Ftp thru http )
# ##
# ##     - Remove Deprecated :
# ##       ---- > > Google Url updates to Git
# ##       ---- > > Url updates to Git / SourceForge
# ##
# ##    - GUI Friendly (MACOS X / Linux)
# ##      ---- > > use of gnome-terminal / xterm / konsole / Terminal.app to follow script progress thru 2 more window with args : Error log, Install log
# ##
# ##    - ADDED More Pipes to Log files and Install.sh Screen's Pipe == > > ${SCRIPT_TTY}
# ##    - ADDED More Graphical Pipe and Trap Ctrl-c / Exit  and send status to ${SCRIPT_TTY}
# ##
# ##    MacOS Contributions
# ##        - Fix for Sed RE error: illegal byte sequence on Mac OS X
# ##        -- > > Sed error when compile so fix it with printenv specific 2 commands ( export LC_CTYPE=C ; export LANG=C )
# ##
# ##        - Fix Zip / Tar / GZ, sometime don't extract
# ##        ---- > >  so use MacOSX's "Archive Utility.app" instead
# ##
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
# ##
echo "Starting up install ..."
PWD=${PWD-$(pwd)}
source $( find $PWD -name common_functions.sh -type f -print )
# ########## # ########### ########### ########### ##########
# ##
# ########## # ########### ########### ########### ##########
# ##
# ########## # ########### ########### ########### ##########
# ## Cocotron Project
#Copyright (c) 2006 Christopher J. W. Lloyd
#
#Permission is hereby granted, free of charge, to any person obtaining a copy of this
#software and associated documentation files (the "Software"), to deal in the Software
#without restriction, including without limitation the rights to use, copy, modify,
#merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
#permit persons to whom the Software is furnished to do so, subject to the following
#conditions:
#
#The above copyright notice and this permission notice shall be included in all copies
#or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
#INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
#PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
#OR OTHER DEALINGS IN THE SOFTWARE.
#
# Inspired by the build-cross.sh script by Sam Lantinga, et al
# Usage: install.sh <platform> <architecture> <productCrossPorting_Target_compiler> <productCrossPorting_Target_compiler-version> <osVersion>"
# Windows i386, Linux i386, Solaris sparc

# ##  ((sw_vers 2>/dev/null | grep -i "ProductVersion" ) ||  ( uname -r | awk '{ print  "/."$1 }' ))  | tr "." " " | awk '{ print  $2"."$3 }'
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

init_trap_master $0

tty_dialog "########### # ########### ########### ########### ###########" :+:\
 "########### # ########### ########### ########### ###########" :+:\
"# ##                                                     ## #" :+:\
"# ##     Welcome to The Cocotron's InstallCDT script     ## #" :+:\
"# ##                                                     ## #" :+:\
"# ##     Running on ($SCRIPT_TTY):($SYSTEM_HOST : $SYSTEM_HOST_VERSION : $SYSTEM_HOST_VERSION_NAME)      ## #" :+:\
"# ##                                                     ## #" :+:\
"########### # ########### ########### ########### ###########" :+:\
"########### # ########### ########### ########### ###########" :+:\


 
source $( find $PWD -name common_install_init.inc.sh -type f -print )

# ## set eu :: darwin problematic
set -eu
 
if [ $productCrossPorting_Target = "Windows" ];then
	if [ $productCrossPorting_Target_arch = "i386" ];then
		productCrossPorting_Target_compiler="i386-pc-mingw32msvc${osVersion}"
		compilerConfigureFlags=""
	else
		tty_echo "Unsupported architecture $productCrossPorting_Target_arch on $productCrossPorting_Target"
	exit 1
	fi
elif [ $productCrossPorting_Target = "Linux" ];then
	if [ $productCrossPorting_Target_arch = "i386" ];then
		productCrossPorting_Target_compiler="i386-ubuntu-linux${osVersion}"
		compilerConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	elif [ $productCrossPorting_Target_arch = "arm" ];then
		productCrossPorting_Target_compiler="arm-none-linux-gnueabi${osVersion}"
		compilerConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	elif [ $productCrossPorting_Target_arch = "ppc" ];then
   	 	productCrossPorting_Target_compiler="powerpc-unknown-linux${osVersion}"
    		compilerConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	elif [ $productCrossPorting_Target_arch = "x86_64" ];then
		productCrossPorting_Target_compiler="x86_64-pc-linux${osVersion}"
		compilerConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
		binutilsConfigureFlags="--enable-64-bit-bfd"
	else
		tty_echo "Unsupported architecture $productCrossPorting_Target_arch on $productCrossPorting_Target"
		exit 1
	fi
elif [ $productCrossPorting_Target = "FreeBSD" ];then
	if [ $productCrossPorting_Target_arch = "i386" ];then
		productCrossPorting_Target_compiler="i386-pc-freebsd${osVersion}"
		compilerConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	elif [ $productCrossPorting_Target_arch = "x86_64" ];then
		productCrossPorting_Target_compiler="x86_64-pc-freebsd${osVersion}"
		compilerConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
		binutilsConfigureFlags="--enable-64-bit-bfd"
	else
		tty_echo "Unsupported architecture $productCrossPorting_Target_arch on $productCrossPorting_Target"
		exit 1
	fi
elif [ $productCrossPorting_Target = "Solaris" ];then
	if [ $productCrossPorting_Target_arch = "sparc" ];then
		productCrossPorting_Target_compiler="sparc-sun-solaris${osVersion}"
		compilerConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	else
		tty_echo "Unsupported architecture $productCrossPorting_Target_arch on $productCrossPorting_Target"
		exit 1
	 fi
elif [ $productCrossPorting_Target = "darwin" ];then
	if [ $productCrossPorting_Target_arch = "i386" ];then
		productCrossPorting_Target_compiler="${productCrossPorting_Target_arch}-unknown-darwin${osVersion}"
		compilerConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	else
		tty_echo "Unsupported architecture $productCrossPorting_Target_arch on $productCrossPorting_Target"
		exit 1
	 fi

else
	tty_echo "Unsupported platform $productCrossPorting_Target"
	exit 1
fi
 
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

PATH="$productCrossPorting_Host_compiler_basedir/bin:$PATH"

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

downloadCompilerIfNeeded(){
###

tty_echo "Downloading ${productCrossPorting_Host_compiler}-${productCrossPorting_Host_compiler_version}${productCrossPorting_Host_compiler_version_Date} (if needed) ..."

# ## ${url_google_cocotron_Download_GPL3}/binutils-$binutilsVersion.tar.gz
# ## https://ftp.gnu.org/gnu/gmp/gmp-$gmpVersion.tar.bz2 https://ftp.gnu.org/gnu/binutils/binutils-$binutilsVersion.tar.bz2 \

	$scriptResources/downloadFilesIfNeeded.sh $productCrossPorting_downloadFolder \
	"${url_google_cocotron_Download_GPL3}/${productCrossPorting_Host_compiler}-${productCrossPorting_Host_compiler_version}${productCrossPorting_Host_compiler_version_Date}.tar.bz2 \	
	${url_google_cocotron_Download_ARCHIVE}/cocotron-binutils-2-21/binutils-$binutilsVersion.tar.gz \
	${url_google_cocotron_Download_GPL3}/mpfr-$mpfrVersion.tar.bz2"
	
	$scriptResources/unarchiveFiles.sh $productCrossPorting_downloadFolder $productCrossPorting_sourceFolder \
	"${productCrossPorting_Host_compiler}-${productCrossPorting_Host_compiler_version}${productCrossPorting_Host_compiler_version_Date} \
	binutils-$binutilsVersion gmp-$gmpVersion \
	mpfr-$mpfrVersion"
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########


createWindowsInterfaceIfNeeded(){
	"$scriptResources/downloadFilesIfNeeded.sh" $productCrossPorting_downloadFolder "${url_google_cocotron_Download_GPL3}/mingwrt-${mingwruntimeVersion}-mingw32-dev.tar.gz ${url_google_cocotron_Download_GPL3}/w32api-${mingwapiVersion}-mingw32-dev.tar.gz"

	"$scriptResources/unarchiveFiles.sh" $productCrossPorting_downloadFolder $productCrossPorting_Target_compiler_dir_base_interface_compiler "mingwrt-$mingwruntimeVersion-mingw32-dev w32api-${mingwapiVersion}-mingw32-dev"
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########


createLinuxInterfaceIfNeeded(){
# Interface is created before script execution, see doc.s
tty_echo "Done."
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########


createFreeBSDInterfaceIfNeeded(){
# Interface is created before script execution, see doc.s
tty_echo "Done."
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########


createSolarisInterfaceIfNeeded(){
# Interface is created before script execution, see doc.s
tty_echo "Done."
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

createdarwinInterfaceIfNeeded(){
# Interface is created before script execution, see doc.s
tty_echo "Done."
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

copyPlatformInterface(){
	if [ ! -d $productCrossPorting_Target_compiler_dir_base_interface_compiler ];then
		exit_witherror "Interface (headers, libraries, etc.) not present at "$productCrossPorting_Target_compiler_dir_base_interface_compiler", exiting"
		# ## exit 1
	else
		mkdir -p $productCrossPorting_Host_compiler_basedir/$productCrossPorting_Target_compiler
		# ###### TODO bsdtar
		(cd $productCrossPorting_Host_compiler_basedir;bsdtar -cf - *) | (cd $productCrossPorting_Host_compiler_basedir/$productCrossPorting_Target_compiler;bsdtar -xf -)
	fi
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

configureAndInstall_binutils() {
	tty_echo "Configuring, building and installing binutils "$binutilsVersion
	rm -rf $productCrossPorting_Target_compiler_dir_build_platform/binutils-$binutilsVersion
	mkdir -p $productCrossPorting_Target_compiler_dir_build_platform/binutils-$binutilsVersion
	pushd $productCrossPorting_Target_compiler_dir_build_platform/binutils-$binutilsVersion

	CFLAGS="-m${productCrossPorting_Target_arch_wordSize} -Wformat=0 -Wno-error -Wno-error=unused-value" $productCrossPorting_sourceFolder/binutils-$binutilsVersion/configure --prefix="$productCrossPorting_Host_compiler_basedir" --target=$productCrossPorting_Target_compiler $binutilsConfigureFlags
	tty_echo $productCrossPorting_Host_compiler_basedir/binutils-$binutilsVersion
	tty_echo $CFlAGS
	make
	make install
	popd
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

configureAndInstall_gmpAndMpfr() {
	tty_echo "Configuring and building and installing gmp "$gmpVersion
	rm -rf $productCrossPorting_Target_compiler_dir_build_platform/gmp-$gmpVersion
	mkdir -p $productCrossPorting_Target_compiler_dir_build_platform/gmp-$gmpVersion
	pushd $productCrossPorting_Target_compiler_dir_build_platform/gmp-$gmpVersion

	ABI=${productCrossPorting_Target_arch_wordSize} $productCrossPorting_sourceFolder/gmp-$gmpVersion/configure --prefix="$productCrossPorting_Host_compiler_basedir"
	make
	make install

	popd
	
    tty_echo "Configuring and building mpfr "$mpfrVersion
	rm -rf $productCrossPorting_Target_compiler_dir_build_platform/mpfr-$mpfrVersion
	mkdir -p $productCrossPorting_Target_compiler_dir_build_platform/mpfr-$mpfrVersion
	pushd $productCrossPorting_Target_compiler_dir_build_platform/mpfr-$mpfrVersion

	$productCrossPorting_sourceFolder/mpfr-$mpfrVersion/configure --prefix="$productCrossPorting_Host_compiler_basedir" --with-gmp-build=$productCrossPorting_Target_compiler_dir_build_platform/gmp-$gmpVersion
	make
	make install

	popd
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

configureAndInstall_compiler() {
	tty_echo "Configuring, building and installing $productCrossPorting_Host_compiler "$productCrossPorting_Host_compiler_version

if [ "$productCrossPorting_Host_compiler" = "gcc" ]; then	
# ##  rm -rf $productCrossPorting_Target_compiler_dir_build_platform/$productCrossPorting_Host_compiler-$productCrossPorting_Host_compiler_version
	mkdir -p $productCrossPorting_Target_compiler_dir_build_platform/$productCrossPorting_Host_compiler-$productCrossPorting_Host_compiler_version
	pushd $productCrossPorting_Target_compiler_dir_build_platform/$productCrossPorting_Host_compiler-$productCrossPorting_Host_compiler_version
# make clean
	CFLAGS="-m${productCrossPorting_Target_arch_wordSize}" $productCrossPorting_sourceFolder/$productCrossPorting_Host_compiler-$productCrossPorting_Host_compiler_version/configure -v \
		--prefix="$productCrossPorting_Host_compiler_basedir" --target=$productCrossPorting_Target_compiler \
		--with-gnu-as --with-gnu-ld --with-headers=$productCrossPorting_Host_compiler_basedir/$productCrossPorting_Target_compiler/include \
		--without-newlib --disable-multilib --disable-libssp --disable-nls --enable-languages="$enableLanguages" \
		--with-gmp=$productCrossPorting_Target_compiler_dir_build_platform/gmp-$gmpVersion --enable-decimal-float \
		--with-mpfr=$productCrossPorting_Host_compiler_basedir --enable-checking=release \
		--enable-objc-gc \
		$compilerConfigureFlags
	echo "MAKEINFO = :" >> Makefile
	make 
	make install
	popd

elif [ "$productCrossPorting_Host_compiler" = "llvm-clang" ]; then	
	if [ ! -e "$productCrossPorting_Folder/$productCrossPorting_Host_compiler-$productCrossPorting_Host_compiler_version/bin/clang" ]; then
		rm -rf $productCrossPorting_Target_compiler_dir_build_platform/$productCrossPorting_Host_compiler-$productCrossPorting_Host_compiler_version
		mkdir -p $productCrossPorting_Target_compiler_dir_build_platform/$productCrossPorting_Host_compiler-$productCrossPorting_Host_compiler_version
		pushd $productCrossPorting_Target_compiler_dir_build_platform/$productCrossPorting_Host_compiler-$productCrossPorting_Host_compiler_version
make clean
		$productCrossPorting_sourceFolder/$productCrossPorting_Host_compiler-$productCrossPorting_Host_compiler_version/configure --enable-optimized \
		--prefix="$productCrossPorting_Folder/$productCrossPorting_Host_compiler-$productCrossPorting_Host_compiler_version"
		make 
		make install
		popd
	else
		tty_echo "Compiler $productCrossPorting_Host_compiler already exists"
	fi
else
	tty_echo "Unknown Compiler $productCrossPorting_Host_compiler"
	exit 1
fi

}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

stripBinaries() {
	tty_echo -n "Stripping binaries ..."
	for x in `find $productCrossPorting_Target_compiler_basedir/bin -type f -print`
	do
		strip $x
	done
	for x in `find $productCrossPorting_Target_compiler_basedir/$productCrossPorting_Target_compiler/bin/ -type f -print`
	do
		strip $x
	done
    if [ "$productCrossPorting_Host_compiler" = "gcc" ]; then
	    for x in `find $productCrossPorting_Target_compiler_basedir/libexec/$productCrossPorting_Host_compiler/$productCrossPorting_Target_compiler/$productCrossPorting_Host_compiler_version -type f -print`
	    do
		    strip $x
	    done
	fi
	tty_echo "done."
}
	
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
	tty_echo "########### # ########### ########### ########### ###########"
	tty_echo "########### # ########### ########### ########### ###########"
	tty_yesyno " ##### >>>>>> Install compiler $productCrossPorting_Host_compiler section ... "
	tty_echo "########### # ########### ########### ########### ###########"
	tty_echo "########### # ########### ########### ########### ###########"
	install_compiler_section_response=${tty_yesyno_response}
	install_compiler_section_response_valid=${tty_yesyno_response_valid}
	
if [ "${install_compiler_section_response}" == "y" ]; then 
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	tty_echo "COCOTRON  :: Platform Interface  :: May Build interface for : $productCrossPorting_Target"
	
	"create${productCrossPorting_Target}InterfaceIfNeeded" 1>>$INSTALL_SCRIPT_LOG  2>>$INSTALL_SCRIPT_LOG_ERR
	tty_echo "COCOTRON  :: Platform Interface  :: completed"
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	tty_echo "COCOTRON  :: Download Pre-requis"
	downloadCompilerIfNeeded 1>>$INSTALL_SCRIPT_LOG  2>>$INSTALL_SCRIPT_LOG_ERR
	tty_echo "COCOTRON  :: Download Pre-requis :: completed"
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	tty_echo "COCOTRON  :: Platform Interface  :: Copying the platform interface.  This could take a while.."
	if [ $productCrossPorting_Target != "darwin" ]; then
		copyPlatformInterface 1>>$INSTALL_SCRIPT_LOG  2>>$INSTALL_SCRIPT_LOG_ERR
	fi
	tty_echo "COCOTRON  :: Platform Interface  :: completed"
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	tty_echo "COCOTRON  :: Tools :: Build and install.  This could take a while.."
	echo "bin util " >>$INSTALL_SCRIPT_LOG 
	tty_echo "COCOTRON  :: Tools  :: binutils ..."
	configureAndInstall_binutils 1>>$INSTALL_SCRIPT_LOG  2>>$INSTALL_SCRIPT_LOG_ERR
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	tty_echo "COCOTRON  :: Tools  :: gmpAndMpfr ..."
	configureAndInstall_gmpAndMpfr 1>>$INSTALL_SCRIPT_LOG  2>>$INSTALL_SCRIPT_LOG_ERR
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	tty_echo "COCOTRON  :: Tools  :: complete"
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	tty_echo "COCOTRON  :: COMPILER  :: Build and install.  This could take a while.."
	
	configureAndInstall_compiler 1>>$INSTALL_SCRIPT_LOG  2>>$INSTALL_SCRIPT_LOG_ERR
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	tty_echo "COCOTRON  :: COMPILER  :: Make strip bin ..."
	
	stripBinaries 1>>$INSTALL_SCRIPT_LOG  2>>$INSTALL_SCRIPT_LOG_ERR
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	tty_echo "COCOTRON  :: COMPILER  :: completed"
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	tty_echo "COCOTRON  :: SPECS  :: Creating specifications ..."
	
	"$scriptResources/createSpecifications.sh" $productCrossPorting_Host_compiler $productCrossPorting_Target $productCrossPorting_Name $productCrossPorting_Version \
	$productCrossPorting_Target_compiler "$installResources/Specifications"  $productCrossPorting_Host_compiler $productCrossPorting_Host_compiler_version
	
	tty_echo "COCOTRON  :: SPECS  :: completed"
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	
	tty_echo "COCOTRON  :: Building tools ..."
	mkdir -p $productCrossPorting_binFolder
	cc "$toolResources/retargetBundle.m" -framework Foundation -o $productCrossPorting_binFolder/retargetBundle
	tty_echo "done."
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	if [ "${productCrossPorting_Host_compiler}" = "gcc" ]; then
		(cd ${productCrossPorting_Target_compiler_basedir}/..;ln -fs ${productCrossPorting_Host_compiler}-${productCrossPorting_Host_compiler_version} g++-${productCrossPorting_Host_compiler_version})
	elif [ "${productCrossPorting_Host_compiler}" = "llvm-clang" ]; then	
		(cd ${productCrossPorting_Target_compiler_basedir}/..;ln -fs ${productCrossPorting_Host_compiler}-${productCrossPorting_Host_compiler_version} llvm-clang++-${productCrossPorting_Host_compiler_version})
	else
		tty_echo "Unknown Compiler ${productCrossPorting_Host_compiler}"
		exit 1
	fi
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	if [ "${productCrossPorting_Host_compiler}" = "llvm-clang" ]; then
	# you need to install also gcc because -ccc-gcc-name is required for cross compiling with clang (this is required for choosing the right assembler 'as' tool. 
	# there is no flag for referencing only this tool :-(
	tty_echo -n "Creating clang script for architecture $productCrossPorting_Target_arch ...in " ${productCrossPorting_Target_compiler_dir_base_platform}/llvm-clang-${productCrossPorting_Host_compiler_version}/bin/${productCrossPorting_Target_compiler}-llvm-clang
	
	echo '#!/bin/sh \
\
source $( find $(dirname $0) -name common_functions.sh -type f -print ) \
' > ${productCrossPorting_Target_compiler_dir_base_platform}/llvm-clang-${productCrossPorting_Host_compiler_version}/bin/${productCrossPorting_Target_compiler}-llvm-clang
	
	echo "$productCrossPorting_Folder/$productCrossPorting_Target_compiler-$productCrossPorting_Target_compiler_version/bin/clang -fcocotron-runtime -ccc-host-triple $productCrossPorting_Target_compiler -ccc-gcc-name $installFolder/$productName/$productVersion/$productCrossPorting_Target/$productCrossPorting_Target_arch/gcc-$productCrossPorting_Host_compiler_version/bin/$productCrossPorting_Target_compiler-gcc \
	-I${productCrossPorting_Target_compiler_dir_base_platform}/llvm-clang-${productCrossPorting_Host_compiler_version}/${productCrossPorting_Target_compiler}/include \"\$@\""  >> ${productCrossPorting_Target_compiler_dir_base_platform}/llvm-clang-$productCrossPorting_Host_compiler_version/bin/$productCrossPorting_Target_compiler-llvm-clang
	
	chmod +x ${productCrossPorting_Target_compiler_dir_base_platform}/llvm-clang-${productCrossPorting_Host_compiler_version}/bin/${productCrossPorting_Target_compiler}-llvm-clang
	tty_echo "done."
	fi
	
	# ########## # ########### ########### ########### ##########
	# ########## # ########### ########### ########### ##########
	
	/bin/echo
else
	tty_echo "#### >>>> skipping productCrossPorting_Target_compiler Section ...."
fi
tty_echo "COCOTRON  :: Libraries :: Install other script ..."

ls $INSTALL_SCRIPT_DIR/*_*.sh | sort

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
other_script=($(ls $INSTALL_SCRIPT_DIR/install_*.sh | sort ))
for  cur_script in  ${other_script[@]} ; do
	tty_echo ">>>> Build : ${cur_script} "
	${cur_script} 1>>$INSTALL_SCRIPT_LOG  2>>$INSTALL_SCRIPT_LOG_ERR
	history | tail -n2
	exit
done
tty_echo "COCOTRON  :: Libraries :: completed"

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

tty_echo "COCOTRON  :: Cleaning "

rm -Rv /tmp/install*

tty_echo "COCOTRON  :: Cleaning :: completed"

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

tty_echo "COCOTRON  :: Thanks ;)"
tty_echo -n "..."

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########


# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

# patch for mingmw

#/bin/bash
# ## export `printenv`
# gccnew=$( echo  $@ | \
# sed -e "s;MacOSX10.11.sdk;MacOSX10.4u.sdk;g" | \
# sed -e "s;-o ;-o;g" | \
# sed -e "s;-Xlinker /;-Xlinker/;g" | \
# sed -e "s;-framework ;-framework;g" | \
# sed -e "s;\ ;\n ;g" | \
# grep -vi  "macosx-version-min" )
# ## gccnew=$( echo "$0.origin $gccnew" )
# clear
# $0.origin $gccnew
# exit $?



