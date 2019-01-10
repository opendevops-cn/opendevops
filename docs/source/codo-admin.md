### 管理后端

`codo-admin`是基于tornado框架 restful风格的API 实现后台管理,[codo详细参考](https://github.com/opendevops-cn/codo-admin),搭配使用`codo`前端(iView+ vue)组成的一套后台用户 权限以及系统管理的解决方案（提供登录，注册 密码修改 鉴权 用户管理 角色管理 权限管理 前端组件管理 前端路由管理 通知服务API 系统基础信息接口）

**获取代码**
```shell
git clone https://github.com/opendevops-cn/codo-admin.git
cd codo-admim
```
**mysql数据初始化**
```shell
mysql -h 127.0.0.1 -u root -p${MYSQL_PASSWORD} -e "create database ${mysql_database} default character set utf8mb4 collate utf8mb4_unicode_ci;"
mysql -h 127.0.0.1 -u root -p${MYSQL_PASSWORD} < doc/data.sql
```
**修改相关配置**
```shell
### 进程数量,配置文件自行修改
vi doc/supervisor_ops.conf
### nginx域名配置 doc/nginx_ops.conf
sed -i "s#\tserver_name .*#\tserver_name ${mg_domain};#g" doc/nginx_ops.conf
### 一定修改 配置文件中的  cookie_secret token_secret  请自行生成复杂的密钥串
export cookie_secret="nJ2oZis0V/xlArY2rzpIE6ioC9/KlqR2fd59sD=UXZJ=3OeROB"
export token_secret="1txIq2QUkeFsZizt3vEpVzUQNFS2@DpEQwbbw8k0YJt0biFScH"

sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py
sed -i "s#token_secret = .*#token_secret = '${token_secret}'#g" settings.py

```
**项目变量（选填）， 如果想从变量中获取配置请修改**
```shell
# 写数据库
export DEFAULT_DB_DBHOST="10.2.2.236"
export DEFAULT_DB_DBPORT='3306'
export DEFAULT_DB_DBUSER='root'
export DEFAULT_DB_DBPWD=${MYSQL_PASSWORD}
export DEFAULT_DB_DBNAME=${mysql_database}
# 读数据库
export READONLY_DB_DBHOST='10.2.2.236'
export READONLY_DB_DBPORT='3306'
export READONLY_DB_DBUSER='root'
export READONLY_DB_DBPWD=${MYSQL_PASSWORD}
export READONLY_DB_DBNAME=${mysql_database}
# 消息队列
export DEFAULT_MQ_ADDR='10.2.2.236'
export DEFAULT_MQ_USER=${MQ_USER}
export DEFAULT_MQ_PWD=${MQ_PASSWORD}
# 缓存
export DEFAULT_REDIS_HOST='10.2.2.236'
export DEFAULT_REDIS_PORT=6379
export DEFAULT_REDIS_PASSWORD=${REDIS_PASSWORD}
```

**编译镜像**
```shell
docker build . -t codo-admin
```
**Docker启动**

`此处要保证 变量正确`
```shell
cat >docker-compose.yml <<EOF
codoadmin:
  restart: unless-stopped
  image: codo-admin
  volumes:
    - /var/log/supervisor/:/var/log/supervisor/
    - /sys/fs/cgroup:/sys/fs/cgroup
  ports:
    - "8010:80"
  environment:
    - DEFAULT_DB_DBHOST=${DEFAULT_DB_DBHOST}
    - DEFAULT_DB_DBPORT=${DEFAULT_DB_DBPORT}
    - DEFAULT_DB_DBUSER=${DEFAULT_DB_DBUSER}
    - DEFAULT_DB_DBPWD=${DEFAULT_DB_DBPWD}
    - DEFAULT_DB_DBNAME=${DEFAULT_DB_DBNAME}
    - READONLY_DB_DBHOST=${READONLY_DB_DBHOST}
    - READONLY_DB_DBPORT=${READONLY_DB_DBPORT}
    - READONLY_DB_DBUSER=${READONLY_DB_DBUSER}
    - READONLY_DB_DBPWD=${READONLY_DB_DBPWD}
    - READONLY_DB_DBNAME=${READONLY_DB_DBNAME}
    - DEFAULT_MQ_ADDR=${DEFAULT_MQ_ADDR}
    - DEFAULT_MQ_USER=${DEFAULT_MQ_USER}
    - DEFAULT_MQ_PWD=${DEFAULT_MQ_PWD}
    - DEFAULT_REDIS_HOST=${DEFAULT_REDIS_HOST}
    - DEFAULT_REDIS_PORT=${DEFAULT_REDIS_PORT}
    - DEFAULT_REDIS_PASSWORD=${DEFAULT_REDIS_PASSWORD}
  hostname: OPS-NW-mg-exec01
EOF
docker-compose up -d
```

**测试codo-admin**
```shell
### 日志
tailf  /var/log/supervisor/mg.log
### are you ok
```

