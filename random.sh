#!/bin/bash

#文字数と行数を指定すると、その文字数のランダム文字列を行数分生成する。

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

#引数の長さが2ならば代入
if [ $# -eq 2 ]; then
   LENGTH=$1
   LINES=$2
else
   echo "引数過不足。1行の文字数と行数を指定すること。（2個）"
   exit -1
fi

isIntAndGtZero ${LENGTH}
isIntAndGtZero ${LINES}

cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${LENGTH} | head -${LINES}
