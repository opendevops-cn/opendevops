# Inception

> opendevops平台所用插件Inception部署文档， 部分文档会因为版本迭代不可用，此文档只作为参考文档，谢谢。

**1.在任何一台安装docker的主机上拉取镜像**

> docker pull ss1917/inception:latest

**2.编辑inception配置文件，注意修改inception_remote四处配置项，指定一个数据库用以保存inception的备份及回滚语句**

```
cat >/etc/inc.cnf <<EOF 
[inception]
general_log=1
general_log_file=/var/log/inception.log
port=6669
socket=/tmp/inc.socket
character-set-client-handshake=OFF
character-set-server=utf8
#config backup database
inception_remote_system_password=aabb1122
inception_remote_system_user=inception_web
inception_remote_backup_port=3306
inception_remote_backup_host=172.16.0.211

inception_check_dml_where=ON
inception_check_dml_limit=OFF
inception_check_dml_orderby=OFF
inception_enable_select_star=ON
inception_enable_orderby_rand=ON
inception_enable_nullable=ON
inception_enable_foreign_key=ON
inception_max_key_parts=5
inception_max_update_rows=MAX
inception_max_keys=6
inception_enable_not_innodb=ON
inception_support_charset=utf8mb4,utf8
inception_check_table_comment=OFF
inception_check_column_comment=OFF
inception_check_primary_key=OFF
inception_enable_partition_table=OFF
inception_enable_enum_set_bit=ON
inception_check_index_prefix=OFF
inception_enable_autoincrement_unsigned=ON
inception_max_char_length=16
inception_check_autoincrement_init_value=OFF
inception_check_autoincrement_datatype=OFF
inception_check_timestamp_default=OFF
inception_enable_column_charset=OFF
inception_check_autoincrement_name=OFF
inception_merge_alter_table=OFF
inception_check_column_default_value=ON
inception_enable_blob_type=ON
inception_enable_identifer_keyword=ON
bind_address=0.0.0.0
inception_check_identifier=ON
EOF

```

**3.启动，主要参数为暴露容器6669端口，挂载本地inc.cnf文件到容器中的/etc目录下**

> docker run -itd -p 6669:6669 -v /etc/inc.cnf:/etc/inc.cnf --name=inception ss1917/inception:latest

> 在主机上测试连接6669端口成功，服务已正常启动。

**inc.cnf配置文件参数简要说明**

```
[inception]
general_log=1
general_log_file=/var/log/inception.log
port=6669
socket=/tmp/inc.socket
character-set-client-handshake=0
character-set-server=utf8

#备份相关
#需要开启binlog
inception_remote_system_password=123456
inception_remote_system_user=user
inception_remote_backup_port=3306
inception_remote_backup_host=10.0.0.24

#在DML语句中没有WHERE条件时，是不是要报错
inception_check_dml_where=1
#在DML语句中使用了LIMIT时，是不是要报错
inception_check_dml_limit=1
#在DML语句中使用了Order By时，是不是要报错
inception_check_dml_orderby
#Select*时是不是要报错
inception_enable_select_star=1
#order by rand时是不是报错
inception_enable_orderby_rand=1
#创建或者新增列时如果列为NULL，是不是报错
inception_enable_nullable=1
#是不是支持外键
inception_enable_foreign_key=1
#一个索引中，列的最大个数，超过这个数目则报错(1-64)
inception_max_key_parts=5
#在一个修改语句中，预计影响的最大行数，超过这个数就报错(1-max)
inception_max_update_rows=10000
#一个表中，最大的索引数目，超过这个数则报错(1-1024)
inception_max_keys=16
#建表指定的存储引擎不为Innodb，不报错
inception_enable_not_innodb=0
#表示在建表或者建库时支持的字符集，如果需要多个，则用逗号分隔，影响的范围是建表、设置会话字符集、修改表字符集属性等
inception_support_charset=utf8mb4
#建表时，表没有注释时报错
inception_check_table_comment=1
#建表时，列没有注释时报错
inception_check_column_comment=1
#建表时，如果没有主键，则报错
inception_check_primary_key=1
#是不是支持分区表
inception_enable_partition_table=0
#是不是支持enum,set,bit数据类型
inception_enable_enum_set_bit=0
#是不是要检查索引名字前缀为"idx_"，检查唯一索引前缀是不是"uniq_"
inception_check_index_prefix=1
#自增列是不是要为无符号型
inception_enable_autoincrement_unsigned=1
#当char类型的长度大于这个值时，就提示将其转换为VARCHAR(1-max)
inception_max_char_length=16
#当建表时自增列的值指定的不为1，则报错
inception_check_autoincrement_init_value=1
#当建表时自增列的类型不为int或者bigint时报错
inception_check_autoincrement_datatype=1
#建表时，如果没有为timestamp类型指定默认值，则报错
inception_check_timestamp_default=0
#允许列自己设置字符集
inception_enable_column_charset=0
#建表时，如果指定的自增列的名字不为ID，则报错，说明是有意义的，给提示
inception_check_autoincrement_name=1
#在多个改同一个表的语句出现时，报错，提示合成一个
inception_merge_alter_table=1
#检查在建表、修改列、新增列时，新的列属性是不是要有默认值
inception_check_column_default_value=1
#检查是不是支持BLOB字段，包括建表、修改列、新增列操作
inception_enable_blob_type=1
#检查在SQL语句中，是不是有标识符被写成MySQL的关键字，默认值为报警。
inception_enable_identifer_keyword=1
#这个参数的作用是为了匹配Python客户端每次自动设置auto_commit=0的，如果取消则会报错，针对Inception本身没有实际意义
#auto_commit=0
#这个参数实际上就是MySQL数据库原来的参数，因为Incpetion没有权限验证过程，那么为了实现更安全的访问，可以给Inception服务器的这个参数设置某台机器（Inception上层的应用程序）不地址，这样
#其它非法程序是不可访问的，那么再加上Inception执行的选项中的用户名密码，对MySQL就更加安全
bind_address=127.0.0.1
#inception_user
#inception_password
#inception_enable_sql_statistic
#inception_read_only
#打开与关闭Inception对SQL语句中各种名字的检查，如果设置为ON，则如果发现名字中存在除数字字母下划线之外的字符时，报Identifier "invalidname" is invalid, valid options: [a-z,A-Z,0-9,_].
inception_check_identifier=1

#inception_osc_min_table_size=1
#inception_osc_bin_dir=/data/temp
#inception_osc_chunk_time=0.1

```
**Inception使用方法**

> 1.Inception规定，在语句的最开始位置，要加上inception_magic_start;语句，在执行语句块的最后加上inception_magic_commit;语句，这2个语句在 Inception 中都是合法的、具有标记性质的可被正确解析的 SQL 语句。被包围起来的所有需要审核或者执行的语句都必须要在每条之后加上分号，其实就是批量执行SQL语句。（包括use database语句之后也要加分号，这点与 MySQL 客户端不同），不然存在语法错误

> 2.目前执行只支持通过C/C++接口、Python接口来对Inception访问，这一段必须是一次性的通过执行接口提交给Inception，那么在处理完成之后，Inception会返回一个结果集，来告诉我们这些语句中存在什么错误，或者是完全正常等等。

**下面是一个python脚本访问inception的简单例子，指定连接测试的mysql服务器为10.0.0.24**

```
cat >inc-mysql.py <<EOF
#!/usr/bin/env python
#coding=utf8
import MySQLdb
sql='''/*--user=root;--password=123456;--host=10.0.0.24;--execute=1;--port=3306;*/\
    inception_magic_start;\
    use test;\
    CREATE TABLE shinezone(id int);\
    inception_magic_commit;'''
#print sql
try:
        conn=MySQLdb.connect(host='127.0.0.1',user='',passwd='',db='',port=6669)
        cur=conn.cursor()
        ret=cur.execute(sql)
        result=cur.fetchall()
        num_fields = len(cur.description)
        field_names = [i[0] for i in cur.description]
        print field_names
        for row in result:
                print row[0], "|",row[1],"|",row[2],"|",row[3],"|",row[4],"|",row[5],"|",row[6],"|",row[7],"|",row[8],"|",row[9],"|",row[10]
        cur.close()
        conn.close()
except MySQLdb.Error,e:
             print "Mysql Error %d: %s" % (e.args[0], e.args[1])
EOF

```

**执行脚本**

> python inc-mysql.py

> 更改建表语句:

> CREATE TABLE shinezone(id int comment 'test' primary key) engine=innodb DEFAULT CHARSET=utf8mb4 comment '测试';\

```
cat >inc-mysql.py <<EOF
#!/usr/bin/env python
#coding=utf8
import MySQLdb
sql='''/*--user=root;--password=123456;--host=10.0.0.24;--execute=1;--port=3306;*/\
    inception_magic_start;\
    use test;\
    CREATE TABLE shinezone(id int comment 'test' primary key) engine=innodb DEFAULT CHARSET=utf8mb4 comment '测试';\
    inception_magic_commit;'''
#print sql
try:
        conn=MySQLdb.connect(host='127.0.0.1',user='',passwd='',db='',port=6669)
        cur=conn.cursor()
        ret=cur.execute(sql)
        result=cur.fetchall()
        num_fields = len(cur.description)
        field_names = [i[0] for i in cur.description]
        print field_names
        for row in result:
                print row[0], "|",row[1],"|",row[2],"|",row[3],"|",row[4],"|",row[5],"|",row[6],"|",row[7],"|",row[8],"|",row[9],"|",row[10]
        cur.close()
        conn.close()
except MySQLdb.Error,e:
             print "Mysql Error %d: %s" % (e.args[0], e.args[1])
EOF

```

> 执行下脚本，同时生成回滚语句，记录在inception备份库中.

> 备份机器的库名组成是由线上机器的 IP 地址的点换成下划线，再加上端口号，再加上库名三部分，在生成的备份中,可以看到inception自动生成的回滚语句
