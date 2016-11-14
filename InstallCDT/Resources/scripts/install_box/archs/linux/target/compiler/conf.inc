# ## this file descripbe rules as BASH Variables

productCrossPorting_Target_compiler=""
productCrossPorting_Target_compiler_ConfigureFlags=""

if [ $productCrossPorting_Target_arch = "i386" ]; then
		productCrossPorting_Target_compiler="i386-ubuntu-linux${osVersion}"
		productCrossPorting_Target_compiler_ConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	elif [ $productCrossPorting_Target_arch = "arm" ]; then
		productCrossPorting_Target_compiler="arm-none-linux-gnueabi${osVersion}"
		productCrossPorting_Target_compiler_ConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	elif [ $productCrossPorting_Target_arch = "ppc" ]; then
   	 	productCrossPorting_Target_compiler="powerpc-unknown-linux${osVersion}"
    		productCrossPorting_Target_compiler_ConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	elif [ $productCrossPorting_Target_arch = "x86_64" ]; then
		productCrossPorting_Target_compiler="x86_64-pc-linux${osVersion}"
		productCrossPorting_Target_compiler_ConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
		binutilsConfigureFlags="--enable-64-bit-bfd"
	else
		tty_echo "Unsupported architecture $productCrossPorting_Target_arch on $productCrossPorting_Target"
		exit 1
	fi
