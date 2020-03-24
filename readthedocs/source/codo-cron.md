### 定时任务

> CODO项目定时任务模块，定时任务完全兼容crontab，支持到秒级

备注：
  
  Docker部署需要将你的脚本目录单独挂载出来，若不理解的同学参考：[codo-cron本地部署方式](https://bbs.opendevops.cn/topic/65/codo-cron-%E6%9C%AC%E5%9C%B0%E9%83%A8%E7%BD%B2%E6%96%B9%E5%BC%8F)



**下载代码**
```shell
echo -e "\033[32m [INFO]: codo_cron(定时任务) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-cron.git
cd codo-cron
```



**修改配置**
> 同样，这里codo-cron也支持取env环境变量，建议还是修改下默认配置

```shell
#导入环境变量文件，最开始准备的环境变量文件
source /opt/codo/env.sh
#后端数据库名称,建议不要修改，初始化data.sql已经指定了数据库名字，若需改请一块修改
CRON_DB_DBNAME='codo_cron' 

sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py

#mysql配置
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${CRON_DB_DBNAME}')#g" settings.py

#只读MySQL配置
sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" settings.py
sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" settings.py
sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" settings.py
sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" settings.py
sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${CRON_DB_DBNAME}')#g" settings.py

```


**修改Dockerfile**

使用自动构建的镜像，默认使用最新版本，这一步的目的是把修改后的配置覆盖进去

```shell
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/codo-cron

#修改应用配置
ADD settings.py /var/www/codo-cron/

EXPOSE 80
CMD ["/usr/bin/supervisord"]
EOF

```


**编译，启动**

```
#编译镜像
docker build . -t codo_cron_image
#启动
docker-compose up -d
```



**创建数据库**

```
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} -e 'create database `codo_cron` default character set utf8mb4 collate utf8mb4_unicode_ci;'
```



**初始化表结构**

```
docker exec -ti codo-cron_codo_cron_1  /usr/local/bin/python3 /var/www/codo-cron/db_sync.py
```

**重启**

```
docker-compose  restart 
```

**测试**

> 日志文件位置统一：/var/log/supervisor/

```
01. 查看日志
tailf /var/log/supervisor/cron.log   #确认没报错
```

**定时任务系统部署完成**