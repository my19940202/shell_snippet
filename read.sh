#!/usr/bin/env bash
# 这个read 接受参数 -t 10 等待10S 没有输入就停止运行
# 
read -p "please input your name here " -t 10 name
echo "your name is "$name

# read -p "please input your password " -s pwd
# echo "\n"
# echo $pwd

# 限定输入的字符的数量
# read -p "please input your param " -n 2 xsxs
# echo "\n"
# echo $xsxs