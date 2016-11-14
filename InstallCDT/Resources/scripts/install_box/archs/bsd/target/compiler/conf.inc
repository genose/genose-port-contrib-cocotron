# ## this file descripbe rules as BASH Variables

productCrossPorting_Target_compiler=""
productCrossPorting_Target_compiler_ConfigureFlags=""


	if [ $productCrossPorting_Target_arch = "i386" ]; then
		productCrossPorting_Target_compiler="i386-pc-freebsd${osVersion}"
		productCrossPorting_Target_compiler_ConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	elif [ $productCrossPorting_Target_arch = "x86_64" ]; then
		productCrossPorting_Target_compiler="x86_64-pc-freebsd${osVersion}"
		productCrossPorting_Target_compiler_ConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
		binutilsConfigureFlags="--enable-64-bit-bfd"
	else
		tty_echo "Unsupported architecture $productCrossPorting_Target_arch on $productCrossPorting_Target"
		exit 1
	fi 
