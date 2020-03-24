### 配置中心

**获取代码**

```shell
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/kerrigan.git && cd kerrigan
```

**修改相关配置**

修改`settings.py`配置

```shell

#导入环境变量文件，最开始准备的环境变量文件
source /opt/codo/env.sh
#修改管理后端域名
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py 

#mysql配置信息
##我们项目支持取env环境变量，但是还是建议修改下。
DEFAULT_DB_DBNAME='codo_kerrigan'
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" settings.py

#只读MySQL配置，若是单台也直接写成Master地址即可
sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" settings.py
sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" settings.py
sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" settings.py
sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" settings.py
sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" settings.py

```


**修改Dockerfile**

使用自动构建的镜像，默认使用最新版本，这一步的目的是把修改后的配置覆盖进去

```
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/codo-kerrigan

#修改应用配置
ADD settings.py /var/www/kerrigan/

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
docker build . -t kerrigan_image
#启动
docker-compose up -d
```


**创建数据库**

```
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} -e 'create database `codo_kerrigan` default character set utf8mb4 collate utf8mb4_unicode_ci;'
```


**初始化表结构**

```
docker exec -ti  kerrigan_codo-kerrigan_1  /usr/local/bin/python3 /var/www/kerrigan/db_sync.py 
```

**重启**

```
docker-compose  restart 
```


**测试kerrigan**

```shell
### 01.日志
tailf /var/log/supervisor/kerrigan.log  #确认没有报错
```

**配置中心系统部署完成**
