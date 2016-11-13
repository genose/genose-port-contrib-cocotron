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

function tty_echo() {
    # ## echo " ----- >>>>>"
    local local_PARAMS="${@}"
    # ## local_PARAMS=($( /bin/echo "${local_PARAMS[@]}" ))
    # ##   /bin/echo ":::: params :::: "${local_PARAMS}
	/bin/echo "${local_PARAMS[@]}" >>  "${SCRIPT_TTY}"
    local_PARAMS=""
}

function tty_dialog() {
# ## echo " dialog received :: "$*
    tty_dialog_ask=$(echo $@   | tr ":" "\:" | sed -e"s; ;\ ;g"  | sed -e"s;:+:;\\
;g"  )
    # ## echo "====== ::::;;;;" ${tty_dialog_ask[@]}
    # ## InstalledSoftware_path_GUI__dialog_use=1
    if [ ${InstalledSoftware_path_GUI__dialog_use-0} -gt 0 ]; then
     
cat > /tmp/install_box.tmp <<EOF
#!/bin/bash
 
    "${InstalledSoftware_path_GUI_dialog}" 	--title "Information " \
    --infobox " $tty_dialog_ask \n\\
     \n\\
    "  0 120 10 
     
EOF

dailog_result=$( sh /tmp/install_box.tmp 2>&1 && echo $? )


    else
        tty_dialog_title=$1
        tty_dialog_message=$2
        tty_echo " "
        tty_echo "########### # ########### ########### ########### ###########"  
        tty_echo "########### # ########### ########### ########### ###########"  
        tty_echo "# ##    $tty_dialog_title ::                                  "  
        tty_echo "# ##        -- $tty_dialog_message                                     "  
        tty_echo "########### # ########### ########### ########### ###########"  
        tty_echo "########### # ########### ########### ########### ###########"  
        tty_echo " "
     fi
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
function lastcmd(){
	
CallStackHistory=$(history |tail -n15)

last_script_name=$(echo $CallStackHistory | tr " " "\n" | grep -i "\.sh" | tail -n1 )

last=$(echo $CallStackHistory | tail -n5 | sed 's/[0-9]* //')
# printf "##### >>>> Call Stack / last command ($last_script_name) :: []"
#echo "++++"
#	for line_last in $( echo ""$last"" | tr ";" "\n" ) ; do
#		tty_echo " >>>> "$line_last
#	done 
#echo "##### >>>> should exit <<<<"
SCRIPT_TTY_STACK=$( ( ps ax  | grep -vi "$0" | grep -i "install" | grep -i ".sh"  | grep -vi "log" || ps ax | grep $$) | awk '{ print "/dev/tty" $6 }'  )
SCRIPT_TTY_SUPER=$( basename $( echo "${SCRIPT_TTY_STACK[*]-${DEFAULT}}" | tail -n1 )  )
SCRIPT_TTY_UP=$( basename $( echo "${SCRIPT_TTY_STACK[*]-${DEFAULT}}" | head -n1 )  )
tyy_in=$(echo $SCRIPT_TTY | sed -e 's;/dev/tty;;g' )
    tyy_out_ps_match=$( ps ax | grep -i "$tyy_in"  | grep -i "install" | grep -i ".sh" | grep -vi 'grep' | grep -vi 'exec')
    
    tyy_out=$( echo "${tyy_out_ps_match[*]}" | awk '{ print $2 }' | uniq )
    tyy_out_ps=$( echo "${tyy_out_ps_match[*]}" | awk '{ print $1 }' | uniq )
    echo " "| tee >&2 >> $SCRIPT_TTY
    echo "#### @@@@  #### @@@@  "   | tee >&2 >> $SCRIPT_TTY
    echo "#### @@@@ Receive Quit .... from ($tyy_in:"$( basename "$0"   )") in (up:${SCRIPT_TTY_UP-${DEFAULT}} from super:${SCRIPT_TTY_SUPER-${DEFAULT}})  to ($tyy_out):("$( echo "${tyy_out_ps[*]}" | tr "\\n" '; ' ) ") " | tee >&2 >> $SCRIPT_TTY
    echo "#### @@@@  #### @@@@  "   | tee >&2 >> $SCRIPT_TTY
    echo " "| tee >&2 >> $SCRIPT_TTY
    echo "@@@@@@@@   @@@@@@@@   @@@@@@@@ " | tee >&2 >> $SCRIPT_TTY
    echo "@@@@@@@@  Call Stack  @@@@@@@@ " | tee >&2 >> $SCRIPT_TTY
    echo "@@@@@@@@   @@@@@@@@   @@@@@@@@ " | tee >&2 >> $SCRIPT_TTY
     echo " "| tee >&2 >> $SCRIPT_TTY
    echo " #0 - > ${SCRIPT_TTY} : ("$(whoami)")"| tee >&2 >> $SCRIPT_TTY
    num=0
    num_x=0
    for l_stack in $( echo "${SCRIPT_TTY_STACK[*]-${DEFAULT}}" | uniq ) ; do
        let "num=num+1"
        let "num_x=num*2"
        v=$(printf "%-${num_x}s" "-")
        l=$(printf "%-${num_x}s" " ")
		n=$(printf "%-${num}s" " ")
        c=$(printf "%-${#num}s" " ")
        # ## echo " #${num} ${n// / }i"  | tee >&2 >> $SCRIPT_TTY
        # ## echo " ${c// / } ${l// / }L${v// /-} > > ${l_stack}" | tee >&2 >> $SCRIPT_TTY
		echo " #${num} ${l// / }L${v// /-} > > ${l_stack}" | tee >&2 >> $SCRIPT_TTY
    done

}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

function tty_waitforpath () {
    
    tty_awaitingpath=$1
    tty_awaitingpath_since=0
    tty_awaitingpath_since_too_long=300
    
    tty_awaitingpath_valid_path=$( $( echo "$tty_awaitingpath" ) || echo false )
    tty_awaitingpath_valid=$( test -x $tty_awaitingpath_valid_path && echo 1 || echo 0 )
    
    # ########### # ############ ###########
     tty_awaitingpath_valid=$( test -x $tty_awaitingpath_valid_path && echo 1 || echo 0 )
    echo "#### >>>>> Awaiting for path : ${tty_awaitingpath} :: ${tty_awaitingpath_valid}"
    while [  $tty_awaitingpath_valid -eq 0  ]; do
        printf "." >> $SCRIPT_TTY
        sleep 1
        
        tty_awaitingpath_valid_path=$( $( echo "$tty_awaitingpath" ) || echo false )
        tty_awaitingpath_valid=$( test -x $tty_awaitingpath_valid_path && echo 1 || echo 0 )
        let "tty_awaitingpath_since= tty_awaitingpath_since + 1"
        let "tty_awaitingpath_since_long= ((tty_awaitingpath_since %60) == 0)?0:1"
        
        
        if [ $tty_awaitingpath_since_too_long -lt $tty_awaitingpath_since ]; then
            tty_echo " "
            exit_witherror " Still Waiting ... Too Long, Come back when it's done "
        fi
        
        if [ $tty_awaitingpath_since_long -eq 0 ]; then
            
            tty_echo " Still Waiting "
        fi
    done
    echo "..........."
    echo "#### >>>>> quit for path : ${tty_awaitingpath} :: ${tty_awaitingpath_valid}"
    tty_echo "####### ####### ####### ####### ####### ####### ####### ####### "
    tty_echo "####### ####### ####### ####### ####### ####### ####### ####### "

}

tty_yesyno_response=""
tty_yesyno_response_valid=0

function tty_yesyno () {


tty_yesyno_response=""
tty_yesyno_response_valid=0
tty_yesyno_ask="$1"    
    # ########### # ############ ###########
    while [  $tty_yesyno_response_valid -eq 0 ]; do
        tty_yesyno_response_valid=0
        tty_yesyno_response=""

        echo "" > /tmp/install_box.tmp
 if [ ${InstalledSoftware_path_GUI__dialog_use} -gt 0 ]; then
     
cat > /tmp/install_box.tmp <<EOF
#!/bin/bash

    "${InstalledSoftware_path_GUI_dialog}" 	--title "Resume for Installation Targeting ${SYSTEM_TARGET} " \
    --timeout 10 \
    --yesno " $tty_yesyno_ask \n\\
     \n\\
    (Y/n) Default is (Yes, timeout : 10sec)  \n\\
    "  0 0     
EOF
            
            dailog_result=$( sh /tmp/install_box.tmp 2>&1  && echo $? ||  echo $?  )
            echo "::YESYNO::" $dailog_result
            switch_case=$( echo ${dailog_result} | tr "xx_" "\\n"  |  tail -n1 | awk '{if(length($2)){print $2}else{print $1}}' )
            case  $switch_case  in
           
            0)
                echo "Yes chosen."
                tty_yesyno_response="y";;
            1)
                echo "No chosen."
                tty_yesyno_response="n";;
            *)
                echo "Box closed. / unknow option"
                "${InstalledSoftware_path_GUI_dialog}"  --timeout 10 	--title "Information "    --msgbox "Installation Cancelled ...  "  20 80
                int_user
            ;;
            esac
        
    else
        # ###########
        read -t 10 -p ">>>>>>>>> $1  ? (Y/n) Default is (Yes, timeout : 10sec) : "  tty_yesyno_response
        # ###########
    fi
        
        
        tty_yesyno_response=$( echo "$tty_yesyno_response" | tr "[:upper:]" "[:lower:]" )
        
        if [ "$tty_yesyno_response" == "" ]; then
            tty_yesyno_response="y"
            tty_echo " --- Using default answer ::(${tty_yesyno_response}) --- "
        fi
        # ###########
        if [ "$tty_yesyno_response" == "y" ] || [ "$tty_yesyno_response" == "yes" ]; then
            tty_yesyno_response="y"
            tty_yesyno_response_valid=1
            break
        fi
        # ###########
        if [ "$tty_yesyno_response" == "n" ] || [ "$tty_yesyno_response" == "no" ]; then
            tty_yesyno_response="n"
            tty_yesyno_response_valid=1
            break
        fi
        
        # ###########
        tty_echo "####### ####### ####### ####### ####### ####### ####### ####### "
        tty_echo "#### Please answer by (Y or n) Default is (Y) ..."
        tty_echo "####### ####### ####### ####### ####### ####### ####### ####### "
        
    done
    
    tty_echo "####### ####### ####### ####### ####### ####### ####### ####### "
    tty_echo "####### ####### ####### ####### ####### ####### ####### ####### "

}

# ############# SIG Trap / EXIT

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

function int_user() {
exit_code="User interruption"

tty_dialog "SIGINT caught :: ${exit_code}" "Installation Exit  :: press enter to quit "

exit 1
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

exit_code="Unknow Reason"
function exit_witherror() {

tty_dialog "Trapped ERROR" "$1"

exit_code=$1
exit 1
}
function finish() {
# ## TODO, try to catch exit code ....

message_quit="Unexpectedly,"

if [ "$exit_code" == "Unknow Reason" ]; then
message_quit="Something went wrong,"
else
if [ "$exit_code" == "User interruption" ]; then
message_quit="User request,"

fi

fi
lastcmd
tty_dialog "Trapped Exit" " ${message_quit} (${exit_code})"
tty_echo " ##### QUIT #####"
}

# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

function send_exit ()
{
    #   echo " #### called :: "
    local SCRIPT_TTY_STACK_script=$( echo ${1-${DEFAULT}} || echo $0 )
    local SCRIPT_TTY_STACK_script_line=$( echo ${2-${DEFAULT}} || echo "--##--")
    tyy_in=$(echo $SCRIPT_TTY | sed -e 's;/dev/tty;;g' )
    tyy_out_ps_match=$( ps ax | grep -i "$tyy_in"  | grep -i "install" | grep -i ".sh" | grep -vi 'grep' | grep -vi 'exec')
    
    tyy_out=$( echo "${tyy_out_ps_match[*]}" | awk '{ print $2 }' | uniq )
    tyy_out_ps=$( echo "${tyy_out_ps_match[*]}" | awk '{ print $1 }' | uniq )
    echo " "| tee >&2 >> $SCRIPT_TTY
    echo "#### @@@@  #### @@@@  "   | tee >&2 >> $SCRIPT_TTY
    echo "#### @@@@ Send Quit .... from ($tyy_in:"$( basename "$0"   )") in (up:${SCRIPT_TTY_UP-${DEFAULT}} from super:${SCRIPT_TTY_SUPER-${DEFAULT}})  to ($tyy_out):("$( echo "${tyy_out_ps[*]}" | tr "\\n" '; ' ) ") " | tee >&2 >> $SCRIPT_TTY
    echo "#### @@@@  #### @@@@  "   | tee >&2 >> $SCRIPT_TTY
    echo " "| tee >&2 >> $SCRIPT_TTY
    echo "@@@@@@@@   @@@@@@@@   @@@@@@@@ " | tee >&2 >> $SCRIPT_TTY
    echo "@@@@@@@@  Call Stack  @@@@@@@@ " | tee >&2 >> $SCRIPT_TTY
    echo "@@@@@@@@   @@@@@@@@   @@@@@@@@ " | tee >&2 >> $SCRIPT_TTY
    echo " "| tee >&2 >> $SCRIPT_TTY
    echo " #0 - > ${SCRIPT_TTY} : ("$(whoami)")"| tee >&2 >> $SCRIPT_TTY
    num=0
    num_x=0
    for l_stack in $( echo "${SCRIPT_TTY_STACK[*]-${DEFAULT}}" | uniq ) ; do
    let "num=num+1"
    let "num_x=num*2"
    v=$(printf "%-${num_x}s" "-")
    l=$(printf "%-${num_x}s" " ")
    
    echo " #${num} ${l// / }L${v// /-} > > ${l_stack}" | tee >&2 >> $SCRIPT_TTY
    done
    let "num=num+1"
    let "num_x=num*2"
    v=$(printf "%-${num_x}s" "-")
    l=$(printf "%-${num_x}s" " ")
    
    echo " #${num} ${l// / }L${v// /-} > > ${SCRIPT_TTY_STACK_script} :: ${SCRIPT_TTY_STACK_script_line}" | tee >&2 >> $SCRIPT_TTY
    echo " "| tee >&2 >> $SCRIPT_TTY
    echo "@@@@@@@@   @@@@@@@@   @@@@@@@@ " | tee >&2 >> $SCRIPT_TTY
    echo "#### @@@@  #### @@@@  "   | tee >&2 >> $SCRIPT_TTY
kill -INT  $tyy_out_ps 2>/dev/null
kill -QUIT $tyy_out_ps 2>/dev/null

 
}
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

function init_trap_master()
{
   
trap finish EXIT

trap int_user SIGINT
   
}
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########

unarchivedFile="/bin/false"

find_unarchive_dir ()
{
    # ## find unarchived ... cause zlib-1.2.5.win32.zip == > > expanded to give :  ./zlib-lib
    XPWD="${PWD-$(pwd)}"
    find_unarchive_basedir="${2-${XPWD}}"
    
    unarchivedFile=$( echo "${1-${DEFAULT}}"  | tr "-" " " | awk '{ print $1"*"  }' )
    
    # ##
    echo "find unarchivedFile :: into ${find_unarchive_basedir}"
    
    unarchivedFile=$(  find "${find_unarchive_basedir}" -not -path "${find_unarchive_basedir}" -name  "${unarchivedFile}*" -type d -print  )
    
    echo "${unarchivedFile[*]}" 
    unarchivedFile=$( echo "${unarchivedFile[*]}" | head -n1  )
}
source $( find $( echo $PWD || pwd ) -name common_declare.sh -type f -print )


# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########