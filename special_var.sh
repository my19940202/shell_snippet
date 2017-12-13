# 特殊常量
echo "File Name: $0"
echo "1st Parameter : $1"
echo "2nd Parameter : $2"
echo "Quoted Values: $@"
echo "Quoted Values: $*"
echo "Total Number of Parameters : $#"
echo "ppid : $$"


#  $@ $* 之间还是有点区别的   感觉不是很重要
#  但是当它们被双引号(" ")包含时，"$*" 会将所有的参数作为一个整体，以"$1 $2 … $n"的形式输出所有参数；"$@" 会将各个参数分开，以"$1" "$2" … "$n" 的形式输出所有参数。
