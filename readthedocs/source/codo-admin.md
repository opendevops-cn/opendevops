### 管理后端

`codo-admin`是基于tornado框架 restful风格的API 实现后台管理,[codo详细参考](https://github.com/opendevops-cn/codo-admin),搭配使用`codo`前端(iView+ vue)组成的一套后台用户 权限以及系统管理的解决方案（提供登录，注册 密码修改 鉴权 用户管理 角色管理 权限管理 前端组件管理 前端路由管理 通知服务API 系统基础信息接口）

**获取代码**

```shell
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-admin.git && cd codo-admin
```
**修改相关配置**

修改`settings.py`配置

> 注意：这里的`cookie_secret`和`token_secret`必须和你的env.sh里面的保持一致，后续网关也要用到这个。若不保持一直登陆后校验不通过回被自动踢回，会导致页面一直不停的刷新

`注意：这里的token_secret必须要和你的网关保持一致，这个值是从env.sh拿来的，一定要做修改，防止网站被攻击，如果secret包含正则符号会导致sed失败，请仔细检查
`

```shell

#导入环境变量文件，最开始准备的环境变量文件
source /opt/codo/env.sh

sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py  
sed -i "s#token_secret = .*#token_secret = '${token_secret}'#g" settings.py     


#mysql配置信息
##我们项目支持取env环境变量，但是还是建议修改下。
DEFAULT_DB_DBNAME='codo_admin'
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


#redis配置
sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" settings.py

```

**修改Dockerfile**

使用自动构建的镜像，默认使用最新版本，这一步的目的是把修改后的配置覆盖进去

```shell
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/codo-admin

ADD settings.py /var/www/codo-admin/

# COPY doc/nginx_ops.conf /etc/nginx/conf.d/default.conf
# COPY doc/supervisor_ops.conf  /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
EOF

```


**编译，启动**

```shell
#bulid 镜像
docker build . -t do_mg_image
#启动
docker-compose up -d
```



**创建数据库**

```shell
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} -e 'create database codo_admin default character set utf8mb4 collate utf8mb4_unicode_ci;'
```



**初始化表结构**

```
 docker exec -ti codo-admin_do_mg_1  /usr/local/bin/python3 /var/www/codo-admin/db_sync.py
```



**导入数据**

主要是菜单，组件，权限列表，内置的用户等

```
#导入数据
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} codo_admin < ./doc/codo_admin_beta0.3.sql
```

**重启**

```
docker-compose  restart 
```


**测试codo-admin**

```shell
### 01.日志
tailf  /var/log/supervisor/mg.log  #确认没有报错
```

**codo-admin 部署完毕**
