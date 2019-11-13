### 资产管理



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

- 修改`settings.py`配置信息
```bash
#导入环境变量文件，最开始准备的环境变量文件
source /opt/codo/env.sh

#修改配置
#后端数据库名称,建议不要修改，初始化data.sql已经指定了数据库名字，若需改请一块修改
CMDB_DB_DBNAME='codo_cmdb' 

#任务系统的域名
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py

#mysql配置
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${CMDB_DB_DBNAME}')#g" settings.py

#只读MySQL配置
sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" settings.py
sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" settings.py
sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" settings.py
sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" settings.py
sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${CMDB_DB_DBNAME}')#g" settings.py

#redis配置
sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" settings.py

#这里如果配置codo-task的数据库地址，则将数据同步到作业配置

TASK_DB_DBNAME='codo_task' 
sed -i "s#CODO_TASK_DB_HOST = .*#CODO_TASK_DB_HOST = os.getenv('CODO_TASK_DB_HOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#CODO_TASK_DB_PORT = .*#CODO_TASK_DB_PORT = os.getenv('CODO_TASK_DB_PORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#CODO_TASK_DB_USER = .*#CODO_TASK_DB_USER = os.getenv('CODO_TASK_DB_USER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#CODO_TASK_DB_PWD = .*#CODO_TASK_DB_PWD = os.getenv('CODO_TASK_DB_PWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#CODO_TASK_DB_DBNAME = .*#CODO_TASK_DB_DBNAME = os.getenv('CODO_TASK_DB_DBNAME', '${TASK_DB_DBNAME}')#g" settings.py

```



- AWS事件和WebTerminnal配置

> 首先将webterminal部署上去

```shell
docker pull webterminal/webterminallte
docker run -itd -p 8080:80 webterminal/webterminallte
```  

`修改settings.py文件`

```shell

# Aws Events 事件邮件通知人
AWS_EVENT_TO_EMAIL = '1111@qq.com,2222@gmail.com'

#Web Terminal 地址，请填写你部署的webterminal地址
#注意这里是填写你上面docker run的机器外网IP
WEB_TERMINAL = 'http://1.1.1.1:8080'

```


**修改Dockerfile**

使用自动构建的镜像，默认使用最新版本，这一步的目的是把修改后的配置覆盖进去

```shell
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/codo-cmdb

#修改应用配置
ADD settings.py /var/www/codo-cmdb/

#修改nginx配置和守护配置
#COPY doc/nginx_ops.conf /etc/nginx/conf.d/default.conf
#COPY doc/supervisor_ops.conf  /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
EOF

```


**打包镜像**

```
docker build . -t codo_cmdb  
```

**启动Docker**

```
docker-compose up -d
```



**创建数据库**

```
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} -e 'create database `codo_cmdb` default character set utf8mb4 collate utf8mb4_unicode_ci;'
```

**初始化表结构**

```
docker exec -ti codo-cmdb_codo_cmdb_1 /usr/local/bin/python3 /var/www/codo-cmdb/db_sync.py
```

**重启**

```
docker-compose  restart 
```

**日志文件**

- 服务日志：`/var/log/supervisor/cmdb.log`  #主程序日志
- 定时日志：`/var/log/supervisor/cmdb_cron.log` #一些后端守护自动运行的日志
```
tailf /var/log/supervisor/cmdb.log
tailf /var/log/supervisor/cmdb_cron.log 
```

**资产管理系统部署完成**
