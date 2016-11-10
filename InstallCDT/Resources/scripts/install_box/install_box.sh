#!/bin/sh

# ########## # ########### ########### ########### ##########
# ##
# ##    Created by Genose.org (Sebastien Ray. Cotillard)
# ##    Date 10-oct-2016
# ##    last update 10-nov-2016
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
DIALOG=${DIALOG=xdialog}
PWD=${PWD-$(pwd)}

# ################## # ##################
# ################## # ##################
_script=$( echo "$PWD/$0" | sed -e "s;${PWD};;g"  | sed -e "s;\.\/;;g" ) 
_script="$PWD/$0"
_script=$( echo "$_script" | sed -e "s;\.\/;;g" )

PWD=$( find $( dirname $_script | xargs dirname ) -name common_functions.sh -type f | xargs dirname )
_script=$( find $PWD -name "install_box.sh" -type f   ) 
 
# ## echo " script :: "$_script
# ################## # ##################
# ################## # ##################

install_box_dir=$( echo $_script | xargs dirname )
# ## echo " :::install_box_dir:: "$install_box_dir
# ################## # ##################
# ################## # ##################

source $(  find $(dirname $install_box_dir | xargs dirname  ) -name common_functions.sh -type f -print )

# ################## # ##################
# ################## # ##################

# ## targetList=$( basename $( ls -d Resources/scripts/install_box/archs/* | tr "\ " "\\n" )  )
targetListDesc=$( find $install_box_dir -name "desc.txt" -type f    | grep -i "target" | grep -vi "compiler" | grep -vi "ide" | sort )
 
echo "" > /tmp/install_box_desc.tmp
chmod 755 /tmp/install_box_desc.tmp

echo "" > /tmp/install_box.tmp
chmod 755 /tmp/install_box.tmp

for descfile in ${targetListDesc[@]} ; do
    source $descfile
    
    system_desc=$( echo ${descfile} | xargs dirname | xargs dirname | xargs basename  )
    compiler_desc_dir=$( echo ${descfile} | xargs dirname )
    compilerDescDir=$( find $compiler_desc_dir -name "desc.txt" -type f    | grep -i "compiler" | sort )
    
    echo  $system_desc "...." ${system_install_desc}
    echo ${system_install_desc}    | sed -e "s;\(.*$\);\"x${SYSTEM_HOST}\_${system_desc}:default\" \"From ${SYSTEM_HOST} \-\-\\ \>\> to SDK : \1\" off 0 xxzzxx;g" >> /tmp/install_box_desc.tmp
     
        for desccompiler in ${compilerDescDir[@]} ; do
            source $desccompiler
            echo ${system_install_desc}    | sed -e "s;\(.*$\);\"x${SYSTEM_HOST}\_${system_desc}:${desccompiler}\" \"Install Cross Compiler : ${compiler_desc} ( ${compiler_version} - ${compiler_date} )\" off 1 xxzzxx;g" >> /tmp/install_box_desc.tmp
        done
done

targetList=$( cat /tmp/install_box_desc.tmp )
 
# ## find $install_box_dir -name 'target' | tee | while IFS= read -r filename; do cat "compiler/$filename"; done

cat > /tmp/install_box.tmp <<EOF
#!/bin/bash

xdialog --title "Installation from ${SYSTEM_HOST}" \
    --treeview "Choose Target System and Compiler " 32 120 0 \
    "all_default:default" "Install All Targetable Systems Supported with Default Parameters for all Target" off 0 \
    "x_latest:default"  "Latest Default target Avail / Compatible with my System (${SYSTEM_HOST})"  off 0 \
    $( echo ${targetList[@]} | sed -e "s;xxzzxx;\
    ;g" )   
EOF

# ################## # ##################
# ################## # ##################

dailog_result=$( sh /tmp/install_box.tmp 2>&1 && echo $? )

switch_case=$( echo ${dailog_result} | tr "xx_" "\\n"  |  tail -n1 | awk '{if(length($2)){print $2}else{print $1}}' )
case  $switch_case in
  0)
    echo "Yes chosen.";;
  1)
    echo "No chosen."
    int_user
    ;;
  *)
    echo "Box closed."
    int_user
    ;;
esac

platform_choose=$( echo $dailog_result | tr "_" "\ " | tr ":" "\ " | awk '{ print $2 }' )

system_choose=$( echo $dailog_result | tr "_" "\ " | tr ":" "\ " | awk '{ print $1 }' )

compiler_choose=$( echo $dailog_result | tr ":" "\ " | awk '{ print $2 }' )

echo "::::" $dailog_result

case $platform_choose in
    default)
        platform_choose=${productCrossPorting_Target_default}
        ;;
    *) ;;
esac

# ################## # ##################
# ################## # ##################         
SYSTEM_TARGET="${platform_choose}"


cat > /tmp/install_box.tmp <<EOF
#!/bin/bash

xdialog 	--title "Target style for Target ${SYSTEM_TARGET} ?" \
        --yesno " Would you like to pack all Installation in platform/SDK style ? \
        \n This will move files to somethink like \n\
 \n \
 \n SDKROOT = \
 \n -  /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/ \
 \n  --OR -- \
 \n  -  /Applications/Xcode.app/Contents/Developer/Platforms/${SYSTEM_TARGET}.platform/Developer/SDKs/ \
 \n    \
 \n - {SDKROOT}/${SYSTEM_TARGET}.sdk/usr/include \
 \n - {SDKROOT}/${SYSTEM_TARGET}.sdk/bin/GCC \
 \n - {SDKROOT}/${SYSTEM_TARGET}.sdk/usr/include \
 \n - {SDKROOT}/${SYSTEM_TARGET}.sdk/Frameworks \
 \n
" 0 0 
EOF
 
# ################## # ##################
# ################## # ##################
dailog_result=$( sh /tmp/install_box.tmp 2>&1  && echo $? )
SDK_STYLE="--NO--"
echo "SDK_STYLE :: ${dailog_result}  :: "$?
switch_case=$( echo ${dailog_result} | tr "xx_" "\\n"  |  tail -n1 | awk '{if(length($2)){print $2}else{print $1}}' )
case  $switch_case in
  0)
    echo "Yes chosen."
    SDK_STYLE="/Applications/Xcode.app/Contents/Developer/Platforms/${SYSTEM_TARGET}.platform/Developer/SDKs/${SYSTEM_TARGET}${SYSTEM_TARGET_VERSION}.sdk/"
    echo "Should Create : ${SDK_STYLE} "
    echo "${SDK_STYLE}/System/Library/CoreServices"
    echo "${SDK_STYLE}/System/Library/Frameworks"
    echo "${SDK_STYLE}/System/Library/Printers"
    echo "${SDK_STYLE}/System/Library/PrivateFrameworks"
    ;;
  1)
    echo "No chosen.";;
  *)
    echo "Box closed."
    int_user
    ;;
esac

# ################## # ##################
# ################## # ##################
# ###### Choose a provided IDE
# ################## # ##################
# ################## # ##################

targetListIDEDesc=$( find "${install_box_dir}/archs/${SYSTEM_HOST}/host/ide" -name "desc.txt" -type f  | sed -e "s;\.\/;;g" | grep -vi "\/ide\/desc"  | sort )
 
echo "" > /tmp/install_box_desc.tmp

for descfile in ${targetListIDEDesc[@]} ; do
    source $descfile
    
    system_desc=$( echo ${descfile} | xargs dirname | xargs basename   )
    editor_desc_dir=$( echo ${descfile} | xargs dirname ) 
    echo " == " $system_desc "...."  ${editor_desc}
    
    echo ${editor_desc}    | sed -e "s;\(.*$\);\"${editor_desc}xx\_${editor_desc_dir}\" \"Use ${SYSTEM_HOST} :: Editor Integration : \1\" off 0 xxzzxx;g" >> /tmp/install_box_desc.tmp
done

# ################## # ##################
# ################## # ##################

targetList=$( cat /tmp/install_box_desc.tmp )

# ################## # ##################
# ################## # ##################

source "${install_box_dir}/archs/${SYSTEM_HOST}/host/ide/desc.txt"
  
# ################## # ##################
# ################## # ##################

cat > /tmp/install_box.tmp <<EOF
#!/bin/bash

xdialog --title "Installation of ${SYSTEM_HOST} " \
    --treeview "Choose your IDE / Text Editor \\n
    ${ediitor_desc}" 32 120 0 \
    "none:none" "I already have one" off 0 \
    $( echo ${targetList[@]} | sed -e "s;xxzzxx;\
    ;g" )   
EOF
 
dailog_result=$( sh /tmp/install_box.tmp 2>&1  && echo $? )
echo "::::" $dailog_result
 
switch_case=$( echo ${dailog_result} | tr "xx_" "\\n" |  tail -n1 | awk '{if(length($2)){print $2}else{print $1}}' )
 
case  $switch_case  in
  0)
    echo "Yes chosen.";;
  1)
    echo "No chosen.";;
  *)
    echo "Box closed."
    int_user
    ;;
esac

editor_choose=$( echo $dailog_result | tr "xx_" "\\n"  | tail -n1  )
editor_choosetxt=$( echo $dailog_result | tr "xx_" "\\n" | head -n1  )

echo $editor_choose"::::" $editor_choosetxt

cat > /tmp/install_box.tmp <<EOF
#!/bin/bash

xdialog 	--title "Resume for Installation Targeting ${SYSTEM_TARGET} " \
        --yesno " Installation wil use  the following in platform/SDK   \n \\
        Target : ${SYSTEM_TARGET} \n \\
        Compiler : ${compiler_choose} \\n \\
        Editor / IDE : ${editor_choosetxt} \\n \\
   "  30 64 0     
EOF

dailog_result=$( sh /tmp/install_box.tmp 2>&1  && echo $? )
echo "::Resume::" $dailog_result
switch_case=$( echo ${dailog_result} | tr "xx_" "\\n"  |  tail -n1 | awk '{if(length($2)){print $2}else{print $1}}' )
case  $switch_case  in
  0)
    echo "Yes chosen.";;
   
  *)
    echo "Box closed."
    
     xdialog  --timeout 10 	--title "Information "    --infobox "Installation Cancelled ...  "  0 64 10 
    int_user
    ;;
esac

# ################## # ##################
# ################## # ################## 
# ###### Resuming installation parameters ...
# ################## # ################## 

compteur=10
titrebarre="Installation en cours"
object_progress="..."

(
while test $compteur != 110
do
echo ${compteur}
echo "XXX"
echo "${titrebarre} ${compteur}\n\m pourcent \ncopie : ${object_progress}"
echo "XXX"
compteur=`expr $compteur + 10`
sleep 0.5
if [ ${compteur} -gt 80 ]; then
    titrebarre="Finalisation de l'installation, presque Fini ..."
fi
done
) |
$DIALOG --title "${titrebarre}" --gauge "Bonjour, ceci est une barre d'avancement" 20 70 0

SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_url=$( echo ${SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_url} | tr "{" "\ " | tr "}" "\ " | sed -e "s;\ ;;g" | sed -e "s;editor_download;${editor_download};g" )
productCrossPorting_Target_default_arch=${productCrossPorting_Target_default_arch}
productCrossPorting_Target_default_compiler=${productCrossPorting_Target_default_compiler}

SYSTEM_TARGET_IDEGUI_APP_sdk="${SDK_STYLE}"