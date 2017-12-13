#!/usr/bin/awk -F
# FS指定列分割符 OFS列输出分隔符
# table head
BEGIN{
    FS = OFS = ",";
    print "name\tage"
}
{
    print NR,NF,$1
}
END{
    print "-----table end------"
}
