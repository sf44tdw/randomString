#!/bin/bash

TARGET_SCRIPT="randomstring.sh"

INSTALL_DIR="/usr/local/bin"

INSTALL_FLAG="install"

UNINSTALL_FLAG="uninstall"

#引数の長さが1ならば代入
if [ $# -eq 1 ]; then
   IO=$1
else
   echo "引数過不足。処理フラグ (インストール = ${INSTALL_FLAG} /アンインストール = ${UNINSTALL_FLAG}) を指定すること。（1個）"
   exit 1
fi

if [ ${IO} = ${INSTALL_FLAG} ]; then
    echo "インストール"
    chmod a+rx ${TARGET_SCRIPT} && cp -f ${TARGET_SCRIPT} ${INSTALL_DIR} && echo "インストール成功" && exit 0
    echo "インストール失敗"
    exit 2
fi

if [ ${IO} = ${UNINSTALL_FLAG} ]; then
    echo "アンインストール"
    rm -f "${INSTALL_DIR}/${TARGET_SCRIPT}" && echo "アンインストール成功" && exit 0
    echo "アンインストール失敗"
    exit 3
fi

echo "引数異常 ${INSTALL}"
exit 4
