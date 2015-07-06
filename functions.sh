#!/bin/bash

# FOREACH
# =======
#
# EXAMPLE
# -------
# _each LIST[@] CALLBACK(ITEM, IDX)
#

_each() {
  declare -a LIST=("${!1}")
  declare -f CB=($2)

  for (( i = 0; i < ${#LIST[@]}; i++ )); {
    $CB ${LIST[x]} $x
  }
}

# TEST EACH
# ========
# echo_item() {
#   echo "ITEM: $1"
#   echo "IDX: $2"
# }
# list=(hello world)
# _each list[@] echo_item


# MAP
# ========
#
# EXAMPLE
# -------
# RESULT=$(_map LIST[@] CALLBACK(ITEM, IDX))
#

_map() {
  declare -a LIST=("${!1}")
  declare -f CB=("$2")

  echo $(_each LIST[@] $CB)
}

# TEST MAP
# ========
# addFive() {
#   echo $(( $1 + 5 ))
#   # return $(( $1 + 5 ))
# }
# list=(1 2 3 4 5)
# mapResult=$(_map list[@] addFive)
# echo "mapResult: $mapResult"


# REDUCE
# ========
#
# EXAMPLE
# -------
# RESULT=${_reduce LIST[@] CALLBACK(MEMO, VALUE) MEMO}
#

_reduce() {
  declare -a LIST=("${!1}")
  declare -f CB=("$2")
  local MEMO=$3
  local START=0

  if [ $# -lt 3 ]; then
    local MEMO="${LIST[0]}"
    local START=1
  fi

  for (( i = $START; i < ${#LIST[@]}; i++ )) {
    MEMO=$($CB $MEMO ${LIST[i]})
  }

  echo "Return Value: $MEMO "
}

# TEST REDUCE
# ========
# sum() {
#   echo $(( $1 + $2 ))
# }
# list=(1 2 3 4 5)
# reduceResult=$(_reduce list[@] sum)
# echo "reduceResult: $reduceResult"

