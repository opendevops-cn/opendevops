### 运维工具

>CODO运维工具支持：告警管理、项目管理、事件管理、加密解密、随机密码、提醒管理等

**获取代码**

```shell
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-tools.git && cd codo-tools
```
**修改相关配置**

修改`settings.py` 和`doc/nginx_ops.conf`配置

> 注意：cookie_secret和token_secret，这里默认是已经生成好的，可不用修改，若自行生成复杂token,key 也请更改env.sh文件

```shell

#导入环境变量文件，最开始准备的环境变量文件
source env.sh
#修改管理后端域名
sed -i  "s#server_name .*#server_name ${tools_domain};#g" doc/nginx_ops.conf   
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py 
sed -i "s#token_secret = .*#token_secret = '${token_secret}'#g" settings.py   


#mysql配置信息
##我们项目支持取env环境变量，但是还是建议修改下。
DEFAULT_DB_DBNAME='codo_tools'
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" settings.py

#redis配置
sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" settings.py

#删除没必要的目录映射，这里调试的时候给目录映射出来了，后续会直接给这条映射直接删除掉。
name=/var/www
sed -i 's#'$name'#EXCLUSIVE#;/EXCLUSIVE/d' docker-compose.yaml

#阿里大鱼和Email配置会从【系统管理】-【系统配置】里面获取，这里可以不配置

```

**导入数据**

```shell
#初始化SQL
wget https://raw.githubusercontent.com/opendevops-cn/opendevops/master/sql/codo_tools-beta0.2.sql
#创建数据库
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD}
create database `codo_tools` default character set utf8mb4 collate utf8mb4_unicode_ci;
#导入数据
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} codo_tools < codo_tools-beta0.2.sql
#确认
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} codo_tools -e  "show tables;"

```

**编译镜像，启动**

```shell
#bulid 镜像
docker build . -t codo_tools
#启动
docker-compose up -d
```

**测试codo-tools**

```shell
### 01.日志
tailf /var/log/supervisor/tools.log  #服务日志，确认没有报错
tailf /var/log/supervisor/cron_jobs.log  #定时提醒日志
```

