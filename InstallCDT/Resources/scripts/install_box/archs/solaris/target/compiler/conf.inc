# ## this file descripbe rules as BASH Variables

productCrossPorting_Target_compiler=""
productCrossPorting_Target_compiler_ConfigureFlags=""

	if [ $productCrossPorting_Target_arch = "sparc" ]; then
		productCrossPorting_Target_compiler="sparc-sun-solaris${osVersion}"
		productCrossPorting_Target_compiler_ConfigureFlags="--enable-version-specific-runtime-libs --enable-shared --enable-threads=posix --disable-checking --disable-libunwind-exceptions --with-system-zlib --enable-__cxa_atexit"
	else
		tty_echo "Unsupported architecture $productCrossPorting_Target_arch on $productCrossPorting_Target"
		exit 1
	 fi
 
