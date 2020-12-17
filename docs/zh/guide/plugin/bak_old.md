# 插件文档

[[toc]]

::: tip
插件部署提供参考
:::

###  SQLAdvisor部署文档

> opendevops平台所用插件SQLAdvisor部署文档， 部分文档会因为版本迭代不可用，此文档只作为参考文档，谢谢。


**简介**

>SQLAdvisor是一个分析SQL给出索引优化建议的工具。它基于MySQL原生态词法解析，结合分析SQL中的where条件、聚合条件、多表Join关系 给出索引优化建议。  主要功能：输出SQL索引优化建议,[更多介绍](https://github.com/Meituan-Dianping/SQLAdvisor/blob/master/doc/THEORY_PRACTICES.md)


**安装使用**

```
#编译依赖项sqlparser
git clone https://github.com/Meituan-Dianping/SQLAdvisor.git
cd SQLAdvisor
1.cmake -DBUILD_CONFIG=mysql_release -DCMAKE_BUILD_TYPE=debug -DCMAKE_INSTALL_PREFIX=/usr/local/sqlparser ./
2.make && make install

#安装SQLAdvisor源码
cd SQLAdvisor/sqladvisor/
cmake -DCMAKE_BUILD_TYPE=debug ./
make
cp sqladvisor  /usr/bin/

#使用帮助
sqladvisor  --help

#举个栗子
sqladvisor  -u root -p 123456 -P 3306 -h 10.0.0.24 -q "select permission_id from base_server_user_group_permission_relation;" -d work_permission_0 -v 1
```

> 编译完成后可删除整个sqladvisor目录，仅保留可执行文件sqladvisor。



### sonarQube部署文档

> opendevops平台所用插件SonarQube部署文档， 部分文档会因为版本迭代不可用，此文档只作为参考文档，谢谢。

[官网](https://www.sonarqube.org/)


**简介**

> SonarQube 是一个开源的代码分析平台, 用来持续分析和评测项目源代码的质量。 通过SonarQube我们可以检测出项目中重复代码， 潜在bug， 代码风格问题，缺乏单元测试等问题， 并通过一个web ui展示出来。

**基础的架构**
- Database
- SonarQube Server
- SonarQube Scanner
- Project
- Nginx （如果不需要通过nginx转发则不需要Nginx模块）

**SonarQube服务端** 


直接拉取仓库中的docker镜像启动服务, docker、docker-compose安装参考[初始化脚本](https://github.com/opendevops-cn/opendevops/tree/master/scripts)

```
mkdir -p /data/sonarqube/

cat >/data/sonarqube/docker-compose.yml <<EOF
version: "2"

services:
  sonarqube:
    image: ss1917/sonarqube:latest
    ports:
      - "9000:9000"
    networks:
      - sonarnet
    environment:
      - SONARQUBE_JDBC_URL=jdbc:postgresql://db:5432/sonar
    volumes:
      - /data/sonarqube/conf:/opt/sonarqube/conf
      - /data/sonarqube/data:/opt/sonarqube/data
      - /data/sonarqube/extensions:/opt/sonarqube/extensions
      - /data/sonarqube/bundled-plugins:/opt/sonarqube/lib/bundled-plugins

  db:
    image: postgres
    networks:
      - sonarnet
    environment:
      - POSTGRES_USER=sonar
      - POSTGRES_PASSWORD=sonar
    volumes:
      - postgresql:/var/lib/postgresql
      - postgresql_data:/var/lib/postgresql/data

networks:
  sonarnet:
    driver: bridge

volumes:
  postgresql:
  postgresql_data:
EOF

cd /data/sonarqube
docker-compose up -d

```

启动docker后访问ip:9000，代表服务已启动,默认登录密码admin/admin

![login_sonar](/login_sonar.png)

SonarQube配置安装插件，汉化。

![chinese_plug](/chinese_plug.png)
![sonarp_plug](/sonarp_plug.png)

如图进入marketplace，搜索汉化包,各类语言代码扫描依赖包， 安装完毕后自动重启。

![sonar_reboot](/sonar_reboot.png)

接下来开始配置sonarqube服务全局配置。

![sonar_global](/sonar_global.png)

**主要配置项：**

- Server base URL (定义sonar服务访问地址，可用域名或ip)
- Email prefix (发送邮件时的主题前缀)
- From address
- From name
- Secure connection

**smtp安全协议**
- SMTP host
- SMTP password
- SMTP port

配置完成后测试发送

![send_test](/send_test.png)

**配置邮件提醒**

在 我的账号-提醒 下设置邮件提醒，也可针对特定项目设置提醒，发送邮件。

![sonar_mail01](/sonar_mail01.png)
![sonar_mail02](/sonar_mail02.png)

至此sonarqube服务端安装配置全部已完成。


**SonarQube客户端(必装)**
> 配置好sonar的服务端之后，接下来就要使用sonar检测我们的代码了，sonar主要是借助客户端检测工具来检测代码，所以要使用sonar必须要在我们本地配置好客户端检测工具
客户端可以通过IDE插件、Sonar-Scanner插件、Ant插件和Maven插件方式进行扫描分析，此处使用的是Sonar-Scanner,sonar的命令行分析端软件还有Sonar-Runner,和Scanner使用差不多


**此处我们使用sonar-scanner**

`注意：这里客户端后续代码检查脚本会调用此客户端执行代码检查`

```shell
wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip
unzip  sonar-scanner-cli-3.2.0.1227-linux.zip
mv sonar-scanner-3.2.0.1227-linux/ /usr/local/sonar-scanner
export SONAR_RUNNER_HOME=/usr/local/sonar-scanner
export PATH=$SONAR_RUNNER_HOME/bin:$PATH
```


### SOAR部署文档
> opendevops平台所用插件SOAR部署文档， 部分文档会因为版本迭代不可用，此文档只作为参考文档，谢谢。


**简介**

>SOAR(SQL Optimizer And Rewriter)是一个对SQL进行优化和改写的自动化工具。 由小米人工智能与云平台的数据库团队开发与维护。SOAR 主要由语法解析器、集成环境、优化建议、重写逻辑、工具集五大模块组成，相比业内其他优秀产品有自己的优势。

**功能特点**

- 跨平台支持（支持Linux, Mac环境，Windows环境理论上也支持，不过未全面测试）
- 支持基于启发式算法的语句优化
- 支持复杂查询的多列索引优化（UPDATE, INSERT, DELETE, SELECT）
- 支持EXPLAIN信息丰富解读
- 支持SQL指纹、压缩和美化
- 支持同一张表多条ALTER请求合并
- 支持自定义规则的SQL改写


**下载二进制安装包**
```
wget https://github.com/XiaoMi/soar/releases/download/0.9.0/soar.linux-amd64 -O soar
chmod a+x soar
cp soar /usr/bin/
```

**安装验证**

回到soar的下载目录执行
```
echo 'select * from film' | ./soar
```
**回显如下**
```
# Query: 687D590364E29465

★ ★ ★ ☆ ☆ 75分

``sql

SELECT  
  * 
FROM  
  film
``

##  最外层SELECT未指定WHERE条件

* **Item:**  CLA.001

* **Severity:**  L4

* **Content:**  SELECT语句没有WHERE子句，可能检查比预期更多的行(全表扫描)。对于SELECT COUNT(\*)类型的请求如果不要求精度，建议使用SHOW TABLE STATUS或EXPLAIN替代。

##  不建议使用SELECT * 类型查询

* **Item:**  COL.001

* **Severity:**  L1

* **Content:**  当表结构变更时，使用\*通配符选择所有列将导致查询的含义和行为会发生更改，可能导致查询返回更多的数据。

```



### Inception部署文档
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



### DNS Bind部署文档

>opendevops平台所用组件[域名管理](https://github.com/opendevops-cn/codo-dns)Bind部署文档， 部分文档会因为版本迭代不可用，此文档只作为参考文档，谢谢。

**安装配置**
```
yum install -y bind bind-chroot bind-utils
```

- 如果安装了bind-chroot（其中chroot是 change root 的缩写），BIND会被封装到一个伪根目录内，配置文件的位置变为：/var/named/chroot/etc/named.conf 　　
- BIND服务主配置文件/var/named/chroot/var/named/　　　　
- zone文件chroot是通过相关文件封装在一个伪根目录内，已达到安全防护的目的，一旦程序被攻破，将只能访问伪根目录内的内容，而不是真实的根目录

- BIND安装好之后不会有预制的配置文件，但是在BIND的文档文件夹内（/usr/share/doc/bind-9.9.4），BIND为我们提供了配置文件模板，我们可以直接拷贝过来：
```
# cp -r /usr/share/doc/bind-9.9.4/sample/etc/* /var/named/chroot/etc/
# cp -r /usr/share/doc/bind-9.9.4/sample/var/* /var/named/chroot/var/
```
- 配置BIND服务的主配置文件（/var/named/chroot/etc/named.conf，并加入zone参数
```
options {
        listen-on port 53       { 127.0.0.1; };
        listen-on-v6 port 53 { ::1; };
        allow-query     { any; };
        directory "/var/named";
        recursion yes;
        };

zone "ss.com"  {
        type master;
        file "ss.com.zone";
};
```
- 新建ss.com.zone文件 如下
```
# vim /var/named/chroot/var/named/ss.com.zone
$TTL 86400
$ORIGIN ss.com.
@  IN SOA  ss.com. admin.ss.com. (
                    20190426; serial #更新序列号
                    1D  ; refresh #更新时间
                    1H  ; retry #重试延时
                    1W  ; expire #失效时间
                    3H  ; minimum #无效解析记录的缓存时间
)
    IN  NS  ns1.ss.com.

ns1 3600 IN   A   192.168.99.99
www 3600 IN   A   172.20.66.110
ftp 3600 IN   A  10.128.105.250
```
- 禁用bind默认方式启动，改用bind-chroot方式启动。命令如下：
```
# /usr/libexec/setup-named-chroot.sh /var/named/chroot on
# systemctl stop named
# systemctl disable named
# systemctl start named-chroot
# systemctl enable named-chroot
```
- 检查语法
```
# named-checkzone ss.com /var/named/ss.com.zone
zone ss.com/IN: loaded serial 20190426
OK
# named-checkconf
```
- 查看是否启动，命令：
```
ps -ef|grep named
```
- 测试DNS服务，命令如下：
```
### 编辑dns解析文件 并写入你的DNS服务器地址
vim /etc/resolv.conf 
nameserver 172.16.0.111
dig ftp.ss.com
```

**参考文档**

[参考文档1](https://blog.csdn.net/bbwangj/article/details/82079405)

[参考文档2](https://blog.51cto.com/liqingbiao/2093064)

[参考文档3](https://blog.csdn.net/bpingchang/article/details/38377053)
