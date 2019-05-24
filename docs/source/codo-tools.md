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

修改`settings.py` 配置

```shell

#导入环境变量文件，最开始准备的环境变量文件
source /opt/codo/env.sh

sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py 

#mysql配置信息
##我们项目支持取env环境变量，但是还是建议修改下。
DEFAULT_DB_DBNAME='codo_tools'
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" settings.py

#redis配置
sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" settings.py

```


**修改Dockerfile （可选）**

可以修改Dockerfile  为下列内容 跳过安装公共依赖

```
FROM ss1917/codo_base:beta0.3

#
RUN pip3 install --upgrade pip
RUN pip3 install -U git+https://github.com/ss1917/ops_sdk.git

# 复制代码
RUN mkdir -p /var/www/
ADD . /var/www/codo-tools/

# 安装pip依赖
RUN pip3 install -r /var/www/codo-tools/doc/requirements.txt

# 日志
VOLUME /var/log/

# 准备文件
COPY doc/nginx_ops.conf /etc/nginx/conf.d/default.conf
COPY doc/supervisor_ops.conf  /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
```


**编译，启动**

```shell
#编译镜像
docker build . -t codo_tools
#启动
docker-compose up -d
```


**创建数据库**

```
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD}
create database `codo_tools` default character set utf8mb4 collate utf8mb4_unicode_ci;
```


**初始化表结构**

```
docker exec -ti  codo-tools_codo_tools_1  /usr/local/bin/python3 /var/www/codo-tools/db_sync.py 
```

**测试codo-tools**

```shell
### 01.日志
tailf /var/log/supervisor/tools.log  #服务日志，确认没有报错
tailf /var/log/supervisor/cron_jobs.log  #定时提醒日志
```

