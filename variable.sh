#!/usr/bin/env bash
# echo $PATH
#set -u #if variable are not defined use this setting will tell error
x="fuck you"

# 两种方式输出变量都可以
echo $x
echo ${x}

# 循环输出
for skill in Ada Coffe Action Java
do
    echo "I am good at ${skill}Script"
done

# 设置了 x 只读 即为不能被后续操作修改
# readonly x
# x="go fuck youself"
# echo ${x}

# 删除变量
y=123123132
unset y
echo "this is y ${y}"