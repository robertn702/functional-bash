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

  for ((x=0; x<${#LIST[@]}; x++)) {
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
# }
# list=(1 2 3 4 5)
# mapResult=$(_map list[@] addFive)
# echo $mapResult


# REDUCE
# ========
#
# EXAMPLE
# -------
# RESULT=${_reduce LIST[@] CALLBACK(MEMO, VALUE) MEMO}
#

_reduce() {
  declare -a  LIST=("${!1}")
  declare -f  CB=("$2")

  local MEMO=$3
  local START=0
  local IDX=0
  # echo "MEMO: $MEMO"
  # echo "START: $START"
  # echo "IDX: $IDX"

  #
  if [ $# -lt 4 ]
    then
      local MEMO="${LIST[0]}"
      echo "MEMO is 1: $MEMO"
      local START=1
  fi

  for VALUE in "${LIST[@]}"; do
    if [ "$IDX" -ge "$START" ]
      then
        $(MEMO+=$(($CB $MEMO $VALUE)))
        echo "MEMO: $MEMO"
    fi
    (( IDX++ ))
  done
  return $MEMO
}

# TEST REDUCE
# ========
# sum() {
#   # echo "1: $1"
#   # echo "2: $2"
#   echo $(( $1 + $2 ))
# }
# list=(1 2 3 4 5)
# reduceResult=$(_reduce list[@] sum 0)
# echo $reduceResult

