#!/bin/bash

#文字種、文字数、行数を指定すると、その文字数のランダム文字列を行数分生成する。
#文字種はtrコマンドのSETと同じ。

function isNumeric(){
local total=0
total=`expr $total + $1 2>/dev/null`

if [ $? -le 1 ]; then
  echo >/dev/null
else
  echo $1
  echo "引数が整数ではない。"
  exit -1
fi
}

function isIntAndGtZero(){
local result=$1
isNumeric ${result}
if [ ${result} -gt 0 ]; then
  echo >/dev/null
else
  echo ${result}
  echo '引数が0以下。0より大きい必要がある。'
  exit -1
fi
}

#引数の長さが3ならば代入
if [ $# -eq 3 ]; then
   CHAR_TYPE=$1
   LENGTH=$2
   LINES=$3
else
   echo "引数過不足。文字種、文字数、1行の文字数と行数を指定すること。（3個）"
   exit -1
fi

isIntAndGtZero ${LENGTH}
isIntAndGtZero ${LINES}
cat /dev/urandom | tr -dc "${CHAR_TYPE}" | fold -w "${LENGTH}" | head -n "${LINES}"
