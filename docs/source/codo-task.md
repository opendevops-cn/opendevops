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

**确认数据库信息**
初始化数据库：codo_task, 请登陆确认是否有初始化数据，没有请手动导入data.sql数据
```
mysql -h 127.0.0.1 -u root -p${MYSQL_PASSWORD}  #登陆确认
```

**修改配置**
> 同样，这里codo-task也支持取env环境变量，建议还是修改下默认配置


```
#修改配置
TASK_DB_DBNAME='codo_task'   #后端数据库名称,建议不要修改，初始化data.sql已经指定了数据库名字，若需改请一块修改

sed -i  "s#server_name .*#server_name ${task_domain};#g" doc/nginx_ops.conf  #任务系统的域名
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py
sed -i "s#token_secret = .*#token_secret = '${token_secret}'#g" settings.py
#mysql配置
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
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

#删除没必要的目录映射
#这是测试用到的，先删除掉
name=/var/www
sed -i 's#'$name'#EXCLUSIVE#;/EXCLUSIVE/d' docker-compose.yml
name_test=/var/www/task_scheduler/db_sync.py
sed -i 's#'$name_test'#EXCLUSIVE02#;/EXCLUSIVE02/d' Dockerfile
```

**编译，启动**
```shell
#编译镜像
docker build . -t task_scheduler_image
#启动
docker-compose up -d
```
**测试**
> 日志文件位置统一：/var/log/supervisor/

```
01. 查看日志
tailf /var/log/supervisor/task_scheduler.log  #确认没报错
tailf /var/log/supervisor/exec_task.log   #执行任务的日志

02. AreYouOK接口
task_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://$task_domain:8020/are_you_ok/`

if [ $task_status == 200 ];then
    echo -e "\033[32m [INFO]: codo(任务系统) install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: codo(任务系统) install faild \033[0m"
    exit -9
fi
```

