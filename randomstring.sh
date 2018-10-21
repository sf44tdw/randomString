#!/bin/bash


usage_exit() {
        echo "Usage: $0 [-t type] [-n number] [-l lines]" 1>&2
        echo "文字種、文字数、行数を指定すると、その文字数のランダム文字列を行数分生成する。" 1>&2
        echo "文字種はtrコマンドのSETと同じ。省略した場合は'[:graph:]'がセットされる。" 1>&2
        echo "-t 文字種" 1>&2
        echo "-n 文字数" 1>&2
        echo "-l 行数" 1>&2
        exit 1
}

ENABLE_t="f"
ENABLE_n="f"
ENABLE_l="f"

while getopts t:n:l: OPT
do
    case $OPT in
        t)  ENABLE_t="t";CHAR_TYPE="${OPTARG}"
            ;;
        n)  ENABLE_n="t";LENGTH="${OPTARG}"
            ;;
        l)  ENABLE_l="t";LINES="${OPTARG}"
            ;;
        :|\?) usage_exit
            ;;
    esac
done

shift $((OPTIND - 1))

[ "${ENABLE_t}" != "t" ] && CHAR_TYPE='[:graph:]'
[ "${ENABLE_n}" != "t" ] && usage_exit
[ "${ENABLE_l}" != "t" ] && usage_exit

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

isIntAndGtZero ${LENGTH}
isIntAndGtZero ${LINES}
cat /dev/urandom | tr -dc "${CHAR_TYPE}" | fold -w "${LENGTH}" | head -n "${LINES}"
