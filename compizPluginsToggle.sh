#!/bin/bash

# compiz plugins toggle - allows activating / desactivating plugins from the cli on Ubuntu 14.04 ( can't be done no more with gconftool2 :/ )

# R: params to be supported:
# -a=<plug1>,<plug2>    => activate the <plug>(s) passed after the equal sign
# -d=<plug1>,<plug2>    => desactivate the <plug>(s) passed after the equal sign
# -t=<plug1>,<plug2>    => toggle the <plug>(s) passed after the equal sign
# -s=<plug1>,<plug2>    => return the state of the <plug>(s) passed after the equal sign ( separated with commas if more than one <plug> is passed )
# -h                    => show the above text

# foreach arg
# == -a ? -> get everything after its "=", replace every comma by "', '" + prepend & append "'", update* the active plugs string with that
# == -d ? -> get everything after its "=", split by commas + prepend & append "'" to each chunk, then loop over them updating* the active plugs string to itself without each of them
# == -t ? -> get everything after its "=", split by commas + prepend & append "'" to each chunk, then loop over to find if there are present in the active plugs string: if so, strip* them, else add* them
# == -s ? -> get everything after its "=", split by commas + prepend & append "'" to each chunk, then loop over to find if there are present in the active plugs string: return a "..,..," string with their states
#
#* we may benefit from helper functions, a LOT ;D



# ----

# get plugs from arg
getPlugsFromArg(){
  argPlugs="${1:3}"
  echo "'${argPlugs//,/"', '"}'"
}

# route parameters
handleArgs(){
  if [[ "$1" == -a=* ]]; then
    #echo "activate stuff !"
    #plugs_ta="${1:3}"
    #echo "PLUGS TO BE ACTIVATED: '${plugs_ta//,/"', '"}'"
    plugs_ta=$(getPlugsFromArg $1)
    echo "PLUGS TO BE ACTIVATED: $plugs_ta"
  elif [[ "$1" == -d=* ]]; then
    #echo "desactivate stuff !"
    plugs_td=$(getPlugsFromArg $1)
    echo "PLUGS TO BE DESACTIVATED: $plugs_td"
  elif [[ "$1" == -t=* ]]; then
    #echo "toggle stuff !"
    plugs_tt=$(getPlugsFromArg $1)
    echo "PLUGS TO BE TOGGLED: $plugs_tt"
  elif [[ "$1" == -s=* ]]; then
    #echo "get stuff states !"
    plugs_gs=$(getPlugsFromArg $1)
    echo "PLUGS TO GET STATES OF: $plugs_gs"
  else
    echo "unknown argument received: $1"
  fi
}

# handle parameters 
if (( $# != 0 )); then
  #echo "The arguments passed were: $@ ."  
  for arg in "$@"; do handleArgs $arg; done;
  # TODO: batch process the args after gettings them in different vars ?
else
  echo "no argument received"
fi

exit
