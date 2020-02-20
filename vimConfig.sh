#########################################################################
# File Name: vimConfig.sh
# Author: zero
# System: Aarch64
# created Time: Thu Feb 20 19:01:54 2020
#########################################################################
#!/bin/bash

#安装Termux程序,并进入主目录
cd

#更换清华源
echo "#deb https://termux.org/packages/ stable main" > $PREFIX/etc/apt/sources.list;echo "deb https://mirrors.tuna.tsinghua.edu.cn/termux stable main" >> $PREFIX/etc/apt/sources.list

#更新源
pkg update && pkg upgrade -y
echo "如果出现[Y/n],输入y并回车，下同"

#安装常用软件包
pkg install vim curl wget git unzip unrar -y

#gcc安装
#添加源
echo "deb https://its-pointless.github.io/files/ termux extras" >> $PREFIX/etc/apt/sources.list
#下载公共密钥
wget https://its-pointless.github.io/pointless.gpg
#安装
pkg install gnupg -y
apt-key add pointless.gpg
pkg update -y
#安装gcc编译器
pkg install gcc-9 -y
#检测安装是否成功
gcc -v &> log.txt
RESULT="`grep \"gcc version 9.2.0 (GCC)\" log.txt`"
if [ -n "$RESULT" ]
then
	echo "gcc安装成功"
else
	echo "gcc安装失败"
fi
rm log.txt
#创建软连接
ln -s ~/../usr/bin/gcc-9 ~/../usr/bin/gcc
