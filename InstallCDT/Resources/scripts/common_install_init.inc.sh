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

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
 
tty_echo "#### Installl Script : " $INSTALL_SCRIPT_DIR
cd $INSTALL_SCRIPT_DIR

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

tty_echo "cleanong previous temp install "
rm -R /tmp/install_*

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
touch $INSTALL_SCRIPT_LOG
touch $INSTALL_SCRIPT_LOG_ERR
# ## in case of previous attempt ...
/bin/echo "Log initialised ..." > $INSTALL_SCRIPT_LOG  && /bin/echo "Log initialised ..." > $INSTALL_SCRIPT_LOG_ERR

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
tty_echo '####### ####### ####### ####### ####### ####### ####### ####### '
tty_echo '####### ####### ####### ####### ####### ####### ####### ####### '
tty_echo "    You can follow (in real time) all speechy operation thru Logs file's "
tty_echo "-- Install verbose logs : ${INSTALL_SCRIPT_LOG}"
tty_echo "-- Errors / Warnings logs : ${INSTALL_SCRIPT_LOG_ERR}"
tty_echo "####### ####### ####### ####### ####### ####### ####### ####### "
tty_echo "####### ####### ####### ####### ####### ####### ####### ####### "

tty_echo "######## So let see if you do the do ..."
# ########
# ########

SYSTEM_HOST_IDEGUI_RECOMMENDED=""
SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_name=""
SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_use=""
SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_major=""
SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_url=""
SYSTEM_HOST_IDEGUI_APP_SUPPORT_xcode3_dir="/Library/Application\ Support/Developer/Shared/Xcode/Specifications"


SYSTEM_TARGET_IDEGUI_APP_sdk="--NO--"

if [ "${SYSTEM_HOST}" = "darwin" ]; then
	
	SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_name="Xcode" 
	case $SYSTEM_HOST_VERSION in
		# ## 10.12) # ## MacOSX Sierra 10.12 is released at the that time (20-oct-2016), Dont stay at it for the moment
		10.11) SYSTEM_HOST_VERSION_NAME="EL_Captain" ;
		# ## Xcode 8.0 is released at the that time (20-oct-2016)
		SYSTEM_HOST_IDEGUI_RECOMMENDED=("7.2.1" "8.0")
		;;
		10.10)
                
                SYSTEM_HOST_VERSION_NAME="Yosemite";
		SYSTEM_HOST_IDEGUI_RECOMMENDED=("7.2.1" "6.4") 
		;;
		10.9) SYSTEM_HOST_VERSION_NAME="Mavericks" ;
		SYSTEM_HOST_IDEGUI_RECOMMENDED=("6.4" "5.1.1")
		;;
		10.8) SYSTEM_HOST_VERSION_NAME="Moutain_Lion" ;
		SYSTEM_HOST_IDEGUI_RECOMMENDED=("5.1.1" "4.6.3")
		;;
		10.7) SYSTEM_HOST_VERSION_NAME="Lion" ;
		SYSTEM_HOST_IDEGUI_RECOMMENDED=("4.6.3")
		;;
		10.6) SYSTEM_HOST_VERSION_NAME="Snow_Leopard" ;
		SYSTEM_HOST_IDEGUI_RECOMMENDED=("3.2.6")
		;;
		10.5) SYSTEM_HOST_VERSION_NAME="Leopard" ;
		SYSTEM_HOST_IDEGUI_RECOMMENDED=("3.2.6")
		;;
		10.4) SYSTEM_HOST_VERSION_NAME="Tiger";
		SYSTEM_HOST_IDEGUI_RECOMMENDED=("2.5")
		;;
		*)  SYSTEM_HOST_VERSION_NAME="MacOSX_Unsupported" ;;
	esac
		SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_use=$(echo ${SYSTEM_HOST_IDEGUI_RECOMMENDED[0]})
		SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_major=$( echo ${SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION}  | tr "." " " | awk '{ print  $1"."$2 }' )
		# ## up-to-date 20-oct-2016
                
		SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_url="{editor_download}/Xcode_${SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_use}/${SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_name}_${SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_use}.dmg"
                
else
    echo "##### Not a MacOS Host System"
	winsubstem=$( echo "${SYSTEM_HOST}"  | grep -i "win" || echo "--NO--" )
	if [ "${winsubstem}" == "--NO--" ]; then
		echo " ##### Windows Bash user .... "
		echo " #### Should visit : https://sourceforge.net/projects/xming/ "
	fi
fi

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

# ## macos / linux specific

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
InstalledSoftware_path_GUI__dialog_required=0
InstalledSoftware_path_GUI__dialog_use=0

InstalledSoftware_path_GUI__x11Window_url="https://dl.bintray.com/xquartz/downloads/XQuartz-2.7.9.dmg"
# ## /opt/X11/bin/xquartz
InstalledSoftware_path_GUI__x11Window=$( which xquartz )

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

# manual Xdialog install url
InstalledSoftware_path_GUI__xdialog_url="http://xdialog.free.fr/Xdialog-2.3.1.orig.tar.gz"

InstalledSoftware_path_GUI__xdialog=$( which xdialog  )
InstalledSoftware_path_GUI__dialog=$( which dialog  )

InstalledSoftware_path_GUI_dialog=$( ( test -x "${InstalledSoftware_path_GUI__xdialog}" ) && { echo ""${InstalledSoftware_path_GUI__xdialog}; } || {
( test -x "${InstalledSoftware_path_GUI__dialog}" ) && { echo ""${InstalledSoftware_path_GUI__dialog};
} || {
	echo "No";
}
}
 )

tty_echo "##### dialog :: $InstalledSoftware_path_GUI_dialog"


if [ ${#InstalledSoftware_path_GUI_dialog} -lt 5 ]; then
    tty_dialog "You MUST Install Xdialog GUI to continue ..." " see recommended for ${SYSTEM_HOST_VERSION_NAME}:${SYSTEM_HOST_VERSION}  )"
	if [ ${SYSTEM_HOST_TYPE} -eq 1 ]; then
            
		tty_yesyno " Would you like to Install it anyway  "
			xdialog_openurl=${tty_yesyno_response}
			xdialog_openurl_valid=${tty_yesyno_response_valid}
                        
		   # ########### # ############ ###########
	   if [ "${xdialog_openurl}" == "y" ]; then
		   tty_echo "Open Browser with xdialog_openurl"
		   # ## sleep 3
		   # ## can't download it without AUTH, so open the URL in browser
		  # ##
                  tty_waitforpath "which xdialog"
		  InstalledSoftware_path_GUI__dialog_required=1
		  InstalledSoftware_path_GUI_dialog="Required"
	   else
		   tty_dialog "Xdialog GUI  not installed " "see recommended ${SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_url}"
	   fi
	fi
	 else
		  InstalledSoftware_path_GUI__dialog_use=1
		tty_yesyno " Would you like to use Xdialog GUI for interactions  "
                 InstalledSoftware_path_GUI__dialog_use=0
			xdialog_openurl=${tty_yesyno_response}
			xdialog_openurl_valid=${tty_yesyno_response_valid}
		   # ########### # ############ ###########
	   if [ "${xdialog_openurl}" == "y" ]; then
		# ## tty_echo "Open Browser with xdialog_openurl"
		   # ## sleep 3
		   # ## can't download it without AUTH, so open the URL in browser
		  # ##  tty_waitforpath "which xdialog"
		  InstalledSoftware_path_GUI__dialog_required=0
		  InstalledSoftware_path_GUI__dialog_use=1
               
		else
			InstalledSoftware_path_GUI_dialog="No"
                   
	   fi	 
		 
fi
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
InstalledSoftware_path_Mac_open=$(which open)
InstalledSoftware_path_Mac_terminal=$( ls -d /Applications/Utilities/Terminal.app 2>$SCRIPT_TTY )

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

# ## linux specific
InstalledSoftware_path_linux_xterm=$(which xterm)
InstalledSoftware_path_linux_gnome_terminal=$(which gnome-terminal)
InstalledSoftware_path_linux_konsole=$(which konsole)
InstalledSoftware_path_linux__terminal=$(which terminal)

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

InstalledSoftware_path_terminal=$(
( test -x "${InstalledSoftware_path_linux_gnome_terminal}" ) && { echo "${InstalledSoftware_path_linux_gnome_terminal} -e "; } || {
( test -x "${InstalledSoftware_path_linux_konsole}" ) && { echo "${InstalledSoftware_path_linux_konsole} -e "; } || {
( test -x "${InstalledSoftware_path_linux_terminal}" ) && { echo "${InstalledSoftware_path_linux_terminal} -e "; } || {
( test -x "${InstalledSoftware_path_Mac_terminal}" ) && { echo "${InstalledSoftware_path_Mac_open} -a ${InstalledSoftware_path_Mac_terminal}"; } || {
( test -x "${InstalledSoftware_path_linux_xterm}" ) && { echo "${InstalledSoftware_path_linux_xterm} -e "; } || {

tty_echo "";
}
}
}
}
}

)

tty_echo "#### Terminal :: ${InstalledSoftware_path_terminal}"

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

os_showLiveLogs=""
os_showLiveLogs_valid=0

if [ "${#InstalledSoftware_path_terminal}" -gt 5 ]; then
        
        tty_echo "---- Would you Following installation with Live Logs ... "

        tty_yesyno " Open Logs over Terminal Window ... "
        
        os_showLiveLogs=${tty_yesyno_response}
        os_showLiveLogs_valid=${tty_yesyno_response_valid}
        # ###########

        # ########### # ############ ###########
    if [ "${os_showLiveLogs}" == "y" ]; then
        # ###########
        tty_dialog "--" " >>>> Determining if Logs are Opens or Not ..." 
        os_showLiveLogs_open=( $( ps waux | grep -i 'tail -f' | grep -i 'install_log' | awk '{ print "\  \"" $13 "\"\ "; }' ) )
        os_showLiveLogs_open_pid=( $( ps waux | grep -i 'tail -f' | grep -i 'install_log' | awk '{ print "\  " $2 "\ "; }' ) )
 

        os_showLiveLogs_open_cnt=${#os_showLiveLogs_open[@]}
        # ###########
        if [ ${os_showLiveLogs_open_cnt} -gt 0 ]; then
            tty_echo " >>>> Skipping :: some logs stills Opens ... (${os_showLiveLogs_open[@]})"
            tty_echo " >>>> PIDs (${os_showLiveLogs_open_pid[@]})"

        else
        # ###########
            tty_echo " >>>> Opening Logs ..."

            # ## darwin Specific first
            # ## can be adapted to Linux with GNU Screen or TYY/PTS shell

            touch /tmp/show_install_log.sh && chmod 755 /tmp/show_install_log.sh
            echo '#!/bin/sh
            cd '${INSTALL_SCRIPT_DIR}'
echo " finding functions ...."
source $( find '${INSTALL_SCRIPT_DIR}' -name common_functions.sh -type f -print )
echo " found functions ...."
' > /tmp/show_install_log.sh
            echo "tail -f ${INSTALL_SCRIPT_LOG}" >> /tmp/show_install_log.sh

            touch /tmp/show_install_log_err.sh && chmod 755 /tmp/show_install_log_err.sh
            echo '#!/bin/sh
            cd '${INSTALL_SCRIPT_DIR}'
echo " finding functions ...."
source $( find '${INSTALL_SCRIPT_DIR}' -name common_functions.sh -type f -print )
echo " found functions ...."
' > /tmp/show_install_log_err.sh
            echo "tail -f ${INSTALL_SCRIPT_LOG_ERR}" >> /tmp/show_install_log_err.sh

            ${InstalledSoftware_path_terminal} /tmp/show_install_log.sh &
            ${InstalledSoftware_path_terminal} /tmp/show_install_log_err.sh &
        fi
        # ###########
    else
            tty_echo " #### NO Assisted Live logs ..."
    fi
        # ###########
else
    tty_echo " #### Assisted Live logs not implemented for Platform (${SYSTEM_HOST}) ..."
    os_showLiveLogs="n"
fi

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

if [ "${os_showLiveLogs}" == "-" ] || [ "${os_showLiveLogs}" == "n" ]; then

tty_dialog "LiveLogs" " You Still can follow (in real time) all speechy operation thru Logs file's "

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

tty_echo "## Install verbose in :"
tty_echo " "
tty_echo "tail -f $INSTALL_SCRIPT_LOG"
tty_echo " "
tty_echo "####### ####### ####### ####### ####### ####### ####### ####### "
tty_echo "## Errors and Warnings in :"
tty_echo " "
tty_echo "tail -f $INSTALL_SCRIPT_LOG_ERR"
tty_echo " "
tty_echo "####### ####### ####### ####### ####### ####### ####### ####### "

fi

 if [ ${InstalledSoftware_path_GUI__dialog_required} -lt 1 ]; then
        source $( find $( pwd ) -name install_box  -type d -exec echo {}"/archs/darwin/host/ide/apple_xcode/desc.txt" \; )
        SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_url=$( echo ${SYSTEM_HOST_IDEGUI_RECOMMENDED_VERSION_url} | tr "{" "\ " | tr "}" "\ " | sed -e "s;\ ;;g" | sed -e "s;editor_download;${editor_download};g" )
 fi

install_proc_script=$( find $( pwd )  -name "${SYSTEM_HOST}_proc_script.inc.sh" )

if [ -x "${install_proc_script}" ] && [ -f  "${install_proc_script}" ] ; then
    source ${install_proc_script}
else
    echo " ######## Warning : incomplete Install.sh::${install_proc_script} support for : ${SYSTEM_HOST} "
fi
if [ ${InstalledSoftware_path_GUI__dialog_use} -gt 0 ]; then
    source $( find $PWD -name "install_box.sh" -type f -print )
fi


# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
echo " :: SYSTEM_TARGET_IDEGUI_APP_sdk :: ${SYSTEM_TARGET_IDEGUI_APP_sdk} "

if [ "${SYSTEM_TARGET_IDEGUI_APP_sdk}"  == "--NO--" ]; then
    if [ -w "${SYSTEM_HOST_IDEGUI_APP_SUPPORT_xcode3_dir}" ]; then
            tty_echo "####  >>>> Permissions properly set up, continuing install."
    else
            tty_echo "####  >>>> For this script to complete successfully, the directory ${SYSTEM_HOST_IDEGUI_APP_SUPPORT_xcode3_dir} must be writeable by you, and we've detected that it isn't.  "
            exit 1
    fi

else
    echo " Install in  : ${SYSTEM_TARGET_IDEGUI_APP_sdk}";
fi