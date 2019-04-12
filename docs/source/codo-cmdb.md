### 资产管理

> CODO项目资产管理模块，CMDB、日志审计、授权、Web Terminal等

**下载代码**
```shell
echo -e "\033[32m [INFO]: codo_cmdb(资产管理) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-cmdb.git
cd codo-cmdb
```



**修改配置**

```shell
#导入环境变量文件，最开始准备的环境变量文件
source env.sh

#后端数据库名称,建议不要修改，初始化data.sql已经指定了数据库名字，若需改请一块修改
CMDB_DB_DBNAME='codo_cmdb'  

#CMDB域名
sed -i  "s#server_name .*#server_name ${cmdb_domain};#g" docs/nginx_cmdb.conf 

cat > cmdb-example.conf <<EOF
[base]
ip = 0.0.0.0
port = 8000
debug = True

[db]
host = ${READONLY_DB_DBHOST}
port = ${DEFAULT_DB_DBPORT}
dbname = ${CMDB_DB_DBNAME}
username = ${DEFAULT_DB_DBUSER}
password = ${DEFAULT_DB_DBPWD}

[storage]
api_url = http://${api_gw_url}/mg/v2/sysconfig/settings/STORAGE/

[ssh]
public_key = /root/.ssh/id_rsa.pub
EOF

#这是测试用到的，先删除掉
name=/var/www
sed -i 's#'$name'#EXCLUSIVE#;/EXCLUSIVE/d' docker-compose.yml

#建议: 操作完确认下这几个文件，看配置是否修改了，别因为环境变量没获取到配置没更改成功。
```



**导入数据**

```shell
#初始化SQL
wget https://raw.githubusercontent.com/opendevops-cn/opendevops/master/sql/codo_cmdb-beta0.2.sql
#创建数据库
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD}
create database `codo_cmdb` default character set utf8mb4 collate utf8mb4_unicode_ci;
#导入数据
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} codo_cmdb < codo_cmdb-beta0.2.sql
#确认
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} codo_cmdb -e  "show tables;"
```



**编译，启动**

```shell
#编译镜像
docker build . -t cmdb

#启动
docker-compose up -d
```



**测试**

> 日志文件位置统一：/var/log/supervisor/

```
01. 查看日志
tailf /var/log/supervisor/cmdb.log   #确认没报错
```






