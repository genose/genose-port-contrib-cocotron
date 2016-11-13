#!/bin/sh

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
# all test should succesfully past to continue, all with errors
bootstrapped_function=${bootstrapped_function-$( echo 0 )}

# ## echo " ::::get  bootstrapped_function :::: ${bootstrapped_function} "


if [ "${bootstrapped_function-0}" == "0" ]; then  
    # ##### ##### ##### ##### ##### ####
    # ##### ##### ##### ##### ##### #### 
    testbash_backyard_valid=1
    # ##### ##### ##### ##### ##### ####
    # ##### ##### ##### ##### ##### ####
    substr=ab
    testbash_backyard_true=$( [[ "abc" == *"$substr"* ]] && echo "yes" || echo "no"  )  # yes
    testbash_backyard_false=$([[ "bcd" == *"$substr"* ]] && echo "no" || echo "yes" )   # no
    
    testbash_backyard_cond_test_a="no" &&  [[ 0 -eq 0 ]]  && true ||  testbash_backyard_cond_test="yes"
    # ## echo "testbash_backyard_cond_test == ${testbash_backyard_cond_test}"
    testbash_backyard_cond_test_b="no" &&  [[ 0 -eq 0  ]] &&  true  && testbash_backyard_cond_test="yes"
    # ## echo "testbash_backyard_cond_test == ${testbash_backyard_cond_test}"
    # ##### ##### ##### ##### ##### ####
    # ##### ##### ##### ##### ##### ####
    # on darwin shell can have Res 0 and parenthesis at the same time ... this can be the boot shell
    testbash_backyard_ps_tty=$( ps waux | tr '\(' '\;' | tr '\)' '\;' |  grep -vi '\\(' | grep -i "bash" | awk '{print $7}' | sort | uniq )
    # ##### ##### ##### ##### ##### ####
    # ##### ##### ##### ##### ##### ####
    testbash_backyard_ps_tty_res=$( ps waux | tr '\(' '\;' | tr '\)' '\;' | grep -v ';' | grep -i "bash" | awk '{print $6}' | sort  | uniq )
    testbash_backyard_ps_tty_res=$( echo ${testbash_backyard_ps_tty_res[0]} | tr "\ " "\\n" | head -n1 )
    # ##### ##### ##### ##### ##### ####
    # ##### ##### ##### ##### ##### ####
    testbash_backyard_ps_tty_test=$( echo ${testbash_backyard_ps_tty_res} )
    # ##### ##### ##### ##### ##### ####
    # ##### ##### ##### ##### ##### ####
    # ## testbash_backyard_ps_tty_test=abc
    # ## echo "::::::" ${testbash_backyard_ps_tty_test}
    # ## not so qtrange ...; is a dyn cast of string to obtain 00 or a numbre that represent the ressource ID
    let 'testbash_backyard_ps_tty_test=testbash_backyard_ps_tty_test++ '
    # ## echo "::::::" ${testbash_backyard_ps_tty_test}
    let 'testbash_backyard_ps_tty_test=testbash_backyard_ps_tty_test-- '
    # ## echo "::::::" ${testbash_backyard_ps_tty_test}
    let 'testbash_backyard_ps_tty_test=testbash_backyard_ps_tty_test++ '
    # ## echo "::::::" ${testbash_backyard_ps_tty_test}
    testbash_backyard_ps_tty_test_valid="no" &&  [[ ${testbash_backyard_ps_tty_test} -gt 0 ]]  && testbash_backyard_ps_tty_test_valid="yes"
    # ## echo "::::::" ${testbash_backyard_ps_tty_test_valid}
    if [ "${testbash_backyard_ps_tty_test_valid}" == "yes" ] && [ ${testbash_backyard_ps_tty_res} -gt 1 ]; then
            echo ""
    else
        # ## echo "#### ERROR #### Shell Process not compatible ..."
        BASH_required_features=$( echo " Shell Process not compatible ... ("$(which ps )") ;;;; " && echo ${BASH_required_features[*]} )
        testbash_backyard_valid=0
    fi
    # ##### ##### ##### ##### ##### ####
    # ##### ##### ##### ##### ##### ####
    if [ "${testbash_backyard_false}" == "yes" ] && [ "${testbash_backyard_true}" == "yes" ]; then
        echo " "
    else
       BASH_required_features=$( echo " 'bash subtrings :: filename GLOB ' ;;;; " && echo ${BASH_required_features[*]} )
       testbash_backyard_valid=0
    fi
    
    testbash_backyard_real_brand="no" && [[ -f /proc/version ]] && testbash_backyard_real_brand="yes"
    
    if [ "${testbash_backyard_real_brand}" == "no" ]; then
        testbash_backyard_real_brand=$( [[ $( uname -s | tr "[:upper:]" "[:lower:]" ) == "darwin" ]] && echo "darwin" || echo "no" ) 
    elif [ -f /proc/version ]; then
        # ## test windows 10 fra-king Bash port
        testbash_backyard_real_brand=$( /proc/version | tr "[:upper:]" "[:lower:]" | tr '\-' '\\n' | grep -i "microsoft" | head -n1  && echo "no" )
        if [ ${#testbash_backyard_real_brand} -lt 2 ]; then
            testbash_backyard_real_brand="Unix like"
        fi
    else
        testbash_backyard_real_brand="no"
    fi
    
    if [ "${testbash_backyard_real_brand}" == "no" ]; then
        BASH_required_features=$( echo " Operating system ;;;; " && echo ${BASH_required_features[*]} )
    fi
    
    
    # ## bash bug ...; ??
    # ## $ {#local_PARAMS[*]} !== $ @
    function bash_args_bugs() {
        echo " ----- >>>>>"
        local local_PARAMS=$@
        echo ":::: local params :::: "${local_PARAMS[*]}
        
         echo ":::: gloabl params :::: " $@
        if [ "$@" <>  "${local_PARAMS}" ]; then
            # ## tty_echo " buggy params .... "
            echo "#### Warning #### Bash seems buggy :: $@ :::: ${local_PARAMS}"
        fi
        local_PARAMS=""
    }
    
    # ## bash_args_bugs " .... checking args in bash ...."
    # ## echo " testbash_backyard_real_brand == ${testbash_backyard_real_brand} "
    # ##### ##### ##### ##### ##### ####
    # ##### ##### ##### ##### ##### ####
    if [ ${testbash_backyard_valid} -eq 1 ]; then
        # ## echo " Bash compatible :: True "
        # ## PWD=$( echo $PWD || pwd )
        pwd
        PWD=${PWD-$(pwd)}
        _script=${_script-$( echo "$PWD/$0"  | sed -e "s;\.\/;;g" | sed -e "s;${PWD};;g"  | sed -e "s;\.\/;;g" ) }
        #_script=$( echo "$PWD/$0"  | sed -e "s;\.\/;;g" | sed -e "s;${PWD};;g"  | sed -e "s;\.\/;;g" ) 
        #
        _script="$PWD/$0"
        echo " ww==== "$PWD
        echo " ll==== "$0
        _script=$( echo "$_script" | sed -e "s;${PWD}/${PWD};${PWD};g" | sed -e "s;\.\/;;g" )
        echo " dd==== "$_script
        
     
    # ## todo :: test -x on find 
        ( test -x "${PWD}/common_functions.sh" ) && { echo "${PWD}/common_functions.sh"; } || {
                                                                                                echo ""
                                                                                                 find $PWD -name common_functions.sh -type f | xargs dirname 
                                                                                               } 
        
        # ##
        echo "Bootstrap functions .... in ;; $PWD ;;"
        
         
        source $( find $PWD -name "common_func_def.inc.sh" -type f -print )
        # ##
        echo "Bootstrap functions .... "
    else
        echo " Bash compatible :: False "
        echo " "
        echo " #### ERROR #### Your BASH / Shell version / interpreter doesnt understanding some required features :\n ;;;;"${BASH_required_features[*]} | sed -e 's:;;;;:\
     - :g'
        echo " #### QUIT ####"
        exit
    fi
    bootstrapped_function="$_script"
else
    echo " :::: previously bootstrapped_function :::: ${bootstrapped_function} "
fi
# ## so after all this shit, we finally take compiled path defs
if [ -f "${INSTALL_SCRIPT_DEF}" ]; then
    # ## finalised build declaration
    source "${INSTALL_SCRIPT_DEF}"
else
    exit_witherror " :: file def are not found :: something went wrong "
fi
# ## echo "unexpected exit .... Bootstrap functions .... "
# ########## # ########### ########### ########### ##########
# ########## # ########### ########### ########### ##########
