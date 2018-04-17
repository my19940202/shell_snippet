query_arr=("鲜花" "手机助手" "北海旅游" "台湾旅游" "婚纱照");
for((i=1;i<=10;i++));
do
query_idx=`expr $i % 5`;
echo ${query_arr[$query_idx]};
echo 'sad'${query_arr[$query_idx]}'adfa';
done