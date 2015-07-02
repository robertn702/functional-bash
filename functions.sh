#!/bin/bash

_echo() {
  echo "ITEM: $1"
  echo "IDX: $2"
}

# FOREACH
# =======
#
# EXAMPLE
# -------
# _each LIST[@] CALLBACK(ITEM, IDX)
#

_each() {
  declare -a local LIST=("${!1}")
  declare -f local CB=($2)
  local IDX=0

  for ITEM in ${LIST[@]}; do
    $CB $ITEM $IDX
    (( IDX++ ))
  done
}

# MAP
# ========
#
# EXAMPLE
# -------
# RESULT=$(_map LIST[@] CALLBACK(ITEM, IDX))
#

_addFive() {
  echo $(( $1 + 5 ))
}

_map() {
  # LIST = $1
  declare -a local LIST=("${!1}")
  declare -f local CB=("$2")

  # _each LIST[@] CB

  for ITEM in "${LIST[@]}"; do
    $CB $ITEM $IDX
  done
}

# TEST MAP
# ========
# list=(1 2 3 4 5)
# mapResult=$(_map list[@] _addFive)
# echo $mapResult

