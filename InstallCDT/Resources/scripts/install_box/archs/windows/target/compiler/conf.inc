# ## this file descripbe rules as BASH Variables

productCrossPorting_Target_compiler="i386-pc-mingw32msvc${osVersion}"
productCrossPorting_Target_compiler_ConfigureFlags=""


	if [ "${productCrossPorting_Target_arch}" = "i386" ]; then
		productCrossPorting_Target_compiler="i386-pc-mingw32msvc${osVersion}"
		productCrossPorting_Target_compiler_ConfigureFlags=""
	else
		tty_echo "Unsupported architecture $productCrossPorting_Target_arch on $productCrossPorting_Target"
	exit 1
	fi
 

