#\\	反斜杠
#\a	警报，响铃
#\b	退格（删除键）
#\f	换页(FF)，将当前位置移到下页开头
#\n	换行
#\r	回车
#\t	水平制表符（tab键） 
#\v	垂直制表符

a=10
# echo "Value of a is $a \a \b \f \n \r \t \v"


# 替换要执行的命令

DATE=`date`
echo "Date is $DATE"

USERS=`who | wc -l`
echo "Logged in user are $USERS"

UP=`date ; uptime`
echo "Uptime is $UP"