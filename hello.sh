#!/usr/bin/env bash
#echo $PATH
#set -u #if variable are not defined use this setting will tell error
x="fuck you"
a=2
b=3
c=5
echo $x
#无法直接进行加减
echo $a+$b+$c


#string contact 
x="qwwrqwqweq"
x="$x"123
echo $x
echo $xxx


if id $1 &> /dev/null 
then
     echo "user exist"
else
     echo "no this user"
fi

echo "test---------------"
# && ||  通过判断上一条命令的返回值  确定下一条命令是否执行
echo $x && echo "middle" && echo "last"


echo $x || echo "middle" && echo "last"


echo $$  #输出当前的pid的值
echo $!
