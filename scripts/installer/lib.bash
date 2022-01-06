#!/usr/bin/env bash

# function readarray() {
#   local __resultvar=$1
#   declare -a __local_array
#   let i=0
#   while IFS=$'\n' read -r line_data; do
#       __local_array[i]=${line_data}
#       ((++i))
#   done < $2
#   if [[ "$__resultvar" ]]; then
#     eval $__resultvar="'${__local_array[@]}'"
#   else
#     echo "${__local_array[@]}"
#   fi
# }

function pressany() {
  read -p "Press ENTER to continue..."
}

function is_array() {
  local variable_name=$1
  [[ "$(declare -p $variable_name 2>/dev/null)" =~ "declare -a" ]]
}

function get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}

function display_install_step() {
  TITLE=$1
  TEXT=""
  if [[ -n $2 ]]; then
    TEXT=$2
  else
    TEXT=$1
  fi

  if [[ $DRY_RUN == 1 ]]; then
    whiptail \
      --title "DRY RUN MODE. Installation: $TITLE" \
      --msgbox "DRY RUN MODE.\nWe will now install $TEXT" 0 0
  else
    whiptail \
      --title "Installation: $TITLE" \
      --msgbox "We will now install $TEXT" 0 0
  fi
}

function get_partition_info() {
  echo $(lsblk -o SIZE,FSTYPE,LABEL,MOUNTPOINT -n $1)
}

function dequote() {
  echo "$(sed -e 's/^"//' -e 's/"$//' <<< "$1")"
}

function get_partuuid() {
  DISK=$(sed -e 's/^"//' -e 's/"$//' <<< "$1")
  echo "$(lsblk -o PARTUUID -n $DISK)"
}

