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
 

$scriptResources/downloadFilesIfNeeded.sh $TMPDIR -c "${packedVersion}" "ftp://sourceware.org/pub/${packedProduct}${packedVersionPlatform}/dll-latest/dll/${packedVersionArch}/pthreadGC2.dll \
ftp://sourceware.org/pub/${packedProduct}${packedVersionPlatform}/dll-latest/lib/${packedVersionArch}/libpthreadGC2.a \
ftp://sourceware.org/pub/${packedProduct}${packedVersionPlatform}/dll-latest/include/pthread.h \
ftp://sourceware.org/pub/${packedProduct}${packedVersionPlatform}/dll-latest/include/sched.h \
ftp://sourceware.org/pub/${packedProduct}${packedVersionPlatform}/dll-latest/include/semaphore.h"


cp $TMPDIR/pthreadGC2.dll  ${productCrossPorting_Target_default_compiler_dir_system}/bin || send_exit $0 $LINENO
cp $TMPDIR/libpthreadGC2.a  ${productCrossPorting_Target_default_compiler_dir_system}/lib || send_exit $0 $LINENO
cp $TMPDIR/pthread.h    ${productCrossPorting_Target_default_compiler_dir_system}/include || send_exit $0 $LINENO
cp $TMPDIR/sched.h      ${productCrossPorting_Target_default_compiler_dir_system}/include || send_exit $0 $LINENO
cp $TMPDIR/semaphore.h  ${productCrossPorting_Target_default_compiler_dir_system}/include || send_exit $0 $LINENO

