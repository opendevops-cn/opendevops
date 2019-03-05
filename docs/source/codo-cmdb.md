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

**确认数据库信息**
初始化数据库：codo_cmdb, 请登陆确认是否有初始化数据，没有请手动导入data.sql数据
```
mysql -h 127.0.0.1 -u root -p${MYSQL_PASSWORD}  #登陆确认
```

**修改配置**
```
CMDB_DB_DBNAME='codo_cmdb'  #后端数据库名称,建议不要修改，初始化data.sql已经指定了数据库名字，若需改请一块修改
sed -i  "s#server_name .*#server_name ${cmdb_domain};#g" docs/nginx_cmdb.conf  #CMDB域名
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
```

**编译，启动**
```
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


02. 接口状态
cmdb_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://${cmdb_domain}:8002/v1/cmdb/`
if [ $cmdb_status == 200 ];then
    echo -e "\033[32m [INFO]: codo(CMDB) install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: codo(CMDB) install faild \033[0m"
    exit -10
fi
```






