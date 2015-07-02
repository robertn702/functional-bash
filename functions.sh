#!/bin/bash

# Example:
#
# LIST
# ----
# LIST=(this is my list)
#
# CALLBACK:
# ---------
# _echo() {
#   echo "ITEM: $1"
#   echo "IDX: $2"
# }
#
# FUNCTION CALL
# -------------
# _each() LIST[@] _echo
#

_each() {
  declare -a local LIST=("${!1}")
  local IDX=0

  for ITEM in ${LIST[@]}; do
    $2 $ITEM $IDX
    (( IDX++ ))
  done
}

# Example:
#
# LIST
# ----
# LIST=(1, 2, 3, 4, 5)
#
# CALLBACK:
# ---------
# _addFive() {
#   $1 + 5
# }
#
# FUNCTION CALL
# -------------
# _each() LIST[@] _echo
#

_map() {
  local RETURN_LIST=()
  RETURN_LIST+=_each $1 $2
}

# _reduce() {
#   LIST=$1
#   CALLBACK=$2
#   INITIAL_VALUE=$3
#   # if initial value exists then set total to initial value else
#   for ITEM in $LIST
#     TOTAL = CALLBACK $TOTAL, $ITEM
# }

# _includes() {

# }

