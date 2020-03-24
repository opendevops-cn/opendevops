
### 任务系统

> CODO任务系统，负责整个系统中任务调度，此功能是必须要安装的

**下载代码**
```shell
echo -e "\033[32m [INFO]: codo-task(任务系统) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-task.git
cd codo-task

```



**修改配置**
> 同样，这里codo-task也支持取env环境变量，建议还是修改下默认配置


```shell
#导入环境变量文件，最开始准备的环境变量文件
source /opt/codo/env.sh

#修改配置
TASK_DB_DBNAME='codo_task' 

#任务系统的域名
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py

#mysql配置
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${TASK_DB_DBNAME}')#g" settings.py

#只读MySQL配置
sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" settings.py
sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" settings.py
sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" settings.py
sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" settings.py
sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${TASK_DB_DBNAME}')#g" settings.py

#redis配置
sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" settings.py

#MQ配置
sed -i "s#DEFAULT_MQ_ADDR = .*#DEFAULT_MQ_ADDR = os.getenv('DEFAULT_MQ_ADDR', '${DEFAULT_MQ_ADDR}')#g" settings.py
sed -i "s#DEFAULT_MQ_USER = .*#DEFAULT_MQ_USER = os.getenv('DEFAULT_MQ_USER', '${DEFAULT_MQ_USER}')#g" settings.py
sed -i "s#DEFAULT_MQ_PWD = .*#DEFAULT_MQ_PWD = os.getenv('DEFAULT_MQ_PWD', '${DEFAULT_MQ_PWD}')#g" settings.py

```

**修改Dockerfile**

使用自动构建的镜像，默认使用最新版本，这一步的目的是把修改后的配置覆盖进去

```shell
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/codo-task

#修改应用配置
ADD settings.py /var/www/codo-task/

#修改nginx配置和守护配置
#COPY doc/nginx_ops.conf /etc/nginx/conf.d/default.conf
#COPY doc/supervisor_ops.conf  /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
EOF

```


**编译，启动**

```shell
#编译镜像
docker build . -t codo_task_image
#启动
docker-compose up -d
```


**创建数据库**

```
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} -e 'create database `codo_task` default character set utf8mb4 collate utf8mb4_unicode_ci;'
```



**初始化表结构**

```
docker exec -ti codo-task_codo_task_1  /usr/local/bin/python3 /var/www/codo-task/db_sync.py
```



**导入数据**

暂无



**重启**

```
docker-compose  restart 
```

**测试**

> 日志文件位置统一：/var/log/supervisor/

```
01. 查看日志
tailf /var/log/supervisor/task_scheduler.log  #确认没报错
tailf /var/log/supervisor/exec_task.log   #执行任务的日志
```

**任务系统部署完成**
