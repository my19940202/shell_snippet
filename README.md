# 常用命令

| 类型 | 命令 | 作用 |
| -------- | -------------------- | -------------------- |
| 文件操作 | ls 20161*.log <br/> ls 20160[1-9]*.log | 正则方式筛选输出|
| 文件操作 | tar -zcvf target.tar.gz sourcefile | 压缩|
| 文件操作 | gzip -9 xx | 会覆盖源文件|
| 文件操作 | tar -zxvf target.tar.gz | 解压缩|
| 文件操作 | du -hs path | 查看文件大小（Mb单位）|
| 文件操作 | df | 磁盘情况预览|
| 文件操作 | cp -r xx yy | 递归方式拷贝（拷贝所有文件和文件夹）|
| 文件操作 | wget http://a.com/b.jpg -P pic/ | wget 指定文件存放的目录|
| 文件操作 | chmod 755 imgcat <br/> chmod +x xx.sh<br/> chmod -x xx.sh | imgcat是imgcat.sh 去掉了后缀名,可以直接 ./imgcat (sh imgcat.sh)|
| 文件操作 | scp -r username@servername:/path/filename /target/path | 拷贝别人开发机的文件(-r 拷贝所有文件和文件夹)|
| 文件操作 | find . -name '*.png' -depth 2 | 深度为2时查找png文件 |
| hadoop | hadoop fs -getmerge /app/2016 data.txt | 2016目录下的所有文件merge到data.txt中 |
| hadoop | hadoop fs -cat,-ls,-dus,-rmr | fs类型的多种操作 |
| 进程 | ps -ax ps -le &#166; grep node | 查看进程,加上grep进行各种过滤|
| 字符处理 | iconv -f 'utf-8' -t 'gbk' a.txt > b.txt | utf8=>gbk |
| 字符处理 | grep -o 'xxx' data.txt &#166; wc -l<br/> grep -r 'name' ./<br/>grep -a1 'name' ./<br/> | data.txt中的xxx的出现次数<br/>查看当前目录下面的所有含有name字符串的文件 <br/>输出上下一行(a1), 下一行(A1) |
| 字符处理 | sed 's/\t/,/g’ data.txt | data.txt中的tab=>','|
| 字符处理 | sed -n '5,10p' data.txt <br/> sed -n '10p' data.txt<br/> cat nohup.out&#166; head -n 100<br/> cat nohup.out&#166; tail -n 100 | 看5-10行，看第10行,头100，尾100 |
| sort | sort -n -r -k 2 -t ':' result > result_sorted | key:value形式的文件按照value进行排序 |
| 其他 | date +%Y-%m-%d <br/>date -d yesterday +%Y%m%d <br/>date -d tomorrow +%Y%m%d <br/>date -d '30 days ago' +%Y%m%d | 时间获取 |
| 其他 | tailf nohup.out | 一旦nohup.out更新就去刷新输出 |
| 其他 | crontab -e | 定时任务配置 |
| 其他 | git remote -v | git查看remote仓库地址 |
| 其他 | npm list --depth=1 2>/dev/null | 查看npm以及目录安装的包（过滤错误信息） |


### sort 专题
```
$ cat test.data
a 1
b 2
c 99
d 0
e 91
f 3
# -r 降序 -n 升序 -k1 k2 (指定排序key)
$ cat test.data | sort -k1 -n
a 1
b 2
c 99
d 0
e 91
f 3

$ cat test.data | sort -k2 -n
d 0
a 1
b 2
f 3
c 99
# 去除重复行
$ sort -n test.data | uniq
```

### grep专题
```
高亮处理 --color=auto
# match 多个关键字
grep -E 'xxx|yyy|zzz' data

# invert -match 不包含的关键字
grep -v 'xxx|yyy|zzz' data

# 输出目标结果（输出 xfuck you x）
echo "asdxfuck you x1231" | grep -o 'x.*x'

# 关于正则
## 元字符 \b \w \W
## []代表范围
grep "[0-9]" data #match 数字
grep "[789]" data #match 789
grep "[^0-9]" data #match 数字取反
grep "[^a-zA-Z0-9]" data #match 特俗字符
## {}重复的次数
[0-9]\{1,3\} match 1~3位的数字

## *?+ 重复字符
*: 重复次数 n >= 0
+: 重复次数 n >= 1
?: 重复次数 n = 0 || 1

num* match "nummmm" "num" "nu"
num\+ match "nummmm" "num" 至少要有一个
\(re\)* match 'rerere' 和空行
\(re\)\+ match 'rerere' 去掉了空行

##例子
匹配 log中的tu字段
grep -oE "tu=u[0-9]{6,7}" --color=auto
```

### awk专题
```
#!/bin/awk -f
# FS指定列分割符 OFS列输出分隔符
BEGIN{
FS = OFS = "\t";
}
{
split($1, key, "#");
new_key = key[1]"#"key[3];
if (key[2] == 0) pv1[new_key] += $2;
pv2[new_key] += $3;
clk[new_key] += $4;
gain[new_key] += $5;
cnt[new_key] += $6;
}
END{
for (i in pv1) {
print i, pv1[i], pv2[i], clk[i], gain[i], cnt[i];
}
}


##脚本方式调用
-F 定义间隔符
awk -F ',' '{print $1,$4}' new_data
awk -F ',' '{print "name:"$1"\tbirthday"$4}' new_data

内置参数的使用
awk -F "," "{print NR,NF}" new_data
NR 行号 NF 字段数量
awk -F "," '{printf("Line:%s,Col:%s\n", NR,NF)}' new_data
```

```
# for 输出没有按照下标来的
$ awk 'BEGIN{info="this is a test";split(info,tA," ");print length(tA);for(k in tA){print k,tA[k];}}'
4
2 is
3 a
4 test
1 this

# 文件夹文件大小总计
ls -l | awk 'BEGIN{size=0} {size+=$5} END{print "size is " size}'
# stat 非空行数
awk 'BEGIN{cout=0} $1!~/^$/ {cout+=1} END{print "line number is"cout}' list_data
# stat第5行后面的数据
awk -F ',' 'BEGIN{cout=0} {if (NR > 5) name[cout++]=$1} END{for(i=0;i < cout;i++) print i,name[i] }' list_data

```
# curl 进行请求
```
# 其他细节可以 curl -h 自己查看

curl -i -X POST \
-H "application/x-www-form-urlencoded; charset=UTF-8" \
-d \
'{"pageNo":"2","pageSize":"10"}' \
'http://cpu.baidu.com/1003/d77e414'
## get 请求
curl -G http://imageplus.baidu.com/ui

## curl 带上 cookie请求
curl --cookie "name=fuckyou" http://xx.com/api
```

# 环境变量添加
```
# 新增了一个hadoop client
export PATH=$PATH:/home/xishengbo/hadoop_client_yq/hadoop/bin
```
# svn
```
svn commit -m “恢复到某修订版（某修订版作废）”
```
# 权限赋予
```
理解 文件、目录的权限的不同 r w x

让 xxx.sh 可执行即为 ./xxx.sh 运行
chmod 777 xxx.sh

让 xxx.cpp不可执行
chmod -x xxx.cpp
```
# 模板测试服务的快速重启
```
rm lu-ui
rm ../log/*log*
wget http://10.145.78.238:8114/output/bin/lu-ui
chmod 777 lu-ui
kill $(ps aux | grep 'bin/lu-ui' | awk '{print $2}')
```

# vim 放入后台以及切换到前台
```
vim界面下 ctrl + z
要回到前台
jobs 查看当前后台任务
通过 fg 1 切换回来
```

# 文件大小排序
```
ls -Slgrepr
```

# tmux 的使用
```
用于缓存自己的开发环境 不用每次开发的时候都重新打开环境
tmux
tmux ls
tmux kill-server
tmux kill-session -t s_name
tmux attach -t s_name
ctrl + b + n/p (next previous window)
ctrl + b + $ (rename)
```

# mysql 操作
```
mysql -uUSERNAME -pPASSWORK -P4100 -hHOST test_db
mysql -uxishengbo -pWNXhRY4L9Q -P4100 -hst01-dba-sdc-bak03.st01 cb_webdb

waptuList="111,2222,333"
select ad_param from ad_demand where ad_position_id in ($waptuList)
order by create_time
group by group_id
DATE_FORMAT(st_date, "%Y-%m-%d")

like "%xsb%" // like的用法
```
# 网络相关
```
## 查看请求baidu.com 数据包所经过的IP节点 一般用于问题排查
traceroute baidu.com
netstat 查看本机端口的状态
```

# 发压力测试
```
ab -c 2 -n 10 http://127.0.0.1:8800?c=1&b=1
各类限制条件自己看参数吧 get post都能发的
```
# 观察 /bin 有没有完全启动起来的方法
- 通过top命令 看改程序的 cpu占用情况，一般刚开始启动 占用很高（做各种初始化工作，载入配置等等）
- tailf 观察log目录log，一般启动完成后 日志量开始讲减慢