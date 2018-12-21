### 一步步安装方式

> 这部分文档可以帮助你一步步安装部署CoDo(CloudOpenDevOps)云管理平台

`提示：此文档里面直接用到shell和docker方便大家安装，因此需要有一定的运维基础，否则理解起来会稍有吃力。`

#### 初始化环境变量
> 请根据自己环境修改以下变量地址，后续平台里面调用需要使用到。

```shell
### 请自行修改相关配置
export mysql_database="shenshuo"
export MYSQL_PASSWORD="m9uSFL7duAVXfeAwGUSG"
export REDIS_PASSWORD="cWCVKJ7ZHUK12mVbivUf"
export MQ_USER="ss"
export MQ_PASSWORD="5Q2ajBHRT2lFJjnvaU0g"
### 管理后端地址
export mg_domain="mg.opendevops.cn"
### 定时任务地址
export cron_domain="cron.opendevops.cn"
### 任务系统地址
export task_domain="task.opendevops.cn"
### 前端地址
export front_domain="demo.opendevops.cn"
### api网关地址
export api_gw_url="http://gw.opendevops.cn/"
```

#### 安装Python3

```shell
[ -f /usr/local/bin/python3 ] && echo "Python3 already exists" && exit -1
yum groupinstall Development tools -y
yum -y install zlib-devel
yum install -y python36-devel-3.6.3-7.el7.x86_64 openssl-devel libxslt-devel libxml2-devel libcurl-devel
cd /usr/local/src/
wget -q -c https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
tar xf  Python-3.6.4.tar.xz >/dev/null 2>&1 && cd Python-3.6.4
./configure >/dev/null 2>&1
make >/dev/null 2>&1 && make install >/dev/null 2>&1
if [ $? == 0 ];then
    echo "[安装python3] ==> OK"
else
    echo "[安装python3] ==> Faild"
    exit -1
fi
```

#### 安装Docker-compose
```shell
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge
yum install -y docker-ce
###启动
/bin/systemctl start docker.service
### 开机自启
/bin/systemctl enable docker.service
#安装docker-compose编排工具
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
pip3 install docker-compose
```

#### 安装MySQL
> 一般来说 一个MySQL实例即可，如果有需求可以自行搭建主从，每个服务都可以有自己的数据库

```shell
cat >docker-compose.yml <<EOF
mysql:
  restart: unless-stopped
  image: mysql:5.7
  volumes:
    - /data/mysql:/var/lib/mysql
    - /data/mysql_conf:/etc/mysql/conf.d
  ports:
    - "3306:3306"
  environment:
    - MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD}
EOF

#启动mysql容器（在docker-compose.yml同级目录）
docker-compose up -d
### 安装MySQL客户端测试一下
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum -y install Percona-Server-client-56
echo  "mysql -h 127.0.0.1 -u root -p ${MYSQL_PASSWORD}"
```

#### 安装 RabbitMQ
```shell
yum install  -y rabbitmq-server
rabbitmq-plugins enable rabbitmq_management
rabbitmqctl add_user ${MQ_USER} ${MQ_PASSWORD}
rabbitmqctl set_user_tags ${MQ_USER} administrator
rabbitmqctl  set_permissions  -p  '/'  ${MQ_USER} '.' '.' '.'
systemctl restart rabbitmq-server
systemctl enable rabbitmq-server
```

#### 安装部署do_mg
>`do_mg`是基于tornado框架 restful风格的API 实现后台管理,[do_mg详细参考](https://github.com/ss1917/do_mg),搭配使用admin-front前端(iView+ vue)组成的一套后台用户 权限以及系统管理的解决方案（提供登录，注册 密码修改 鉴权 用户管理 角色管理 权限管理 前端组件管理 前端路由管理 通知服务API 系统基础信息接口）

**mysql数据初始化**
```shell
mysql -h 127.0.0.1 -u root -p ${MYSQL_PASSWORD} -e "create database ${mysql_database} default character set utf8mb4 collate utf8mb4_unicode_ci;"
mysql -h 127.0.0.1 -u root -p ${MYSQL_PASSWORD} < doc/data.sql
```
**修改相关配置**
```shell
### 进程数量
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
docker build . -t do_mg_image
```
**Docker启动**

`此处要保证 变量正确`
```shell
cat >docker-compose.yml <<EOF
do_mg:
  restart: unless-stopped
  image: do_mg_image
  volumes:
    - /var/log/supervisor/:/var/log/supervisor/
    - /var/www/do_mg/:/var/www/do_mg/
    - /sys/fs/cgroup:/sys/fs/cgroup
  ports:
    - "8010:80"
  environment:
    - DOMAIN_NAME=${DOMAIN_NAME}
    - PROJECT_PORT=${PROJECT_PORT}
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

**测试mg**
```shell
### 日志
tailf  /var/log/supervisor/mg.log
### are you ok
```

#### 前端部署

**Node安装**

```shell
[ -f /usr/local/bin/node ] && echo "Node already exists" && exit -1
cd /usr/local/src && rm -rf node-v10.14.2-linux-x64.tar.xz
wget https://nodejs.org/dist/v10.14.2/node-v10.14.2-linux-x64.tar.xz
tar xf node-v10.14.2-linux-x64.tar.xz -C  /usr/local/ >/dev/null 2>&1
rm -rf /usr/local/bin/node
rm -rf /usr/local/bin/npm
rm -rf /usr/bin/pm2
ln -s /usr/local/node-v10.14.2-linux-x64/bin/node /usr/local/bin/node
ln -s /usr/local/node-v10.14.2-linux-x64/bin/node /usr/bin/node
ln -s /usr/local/node-v10.14.2-linux-x64/bin/npm  /usr/local/bin/npm
ln -s /usr/local/node-v10.14.2-linux-x64/bin/npm  /usr/bin/npm
/usr/local/bin/node -v
/usr/local/bin/npm -v
sudo npm i -g pm2 >/dev/null 2>&1
ln -s /usr/local/node-v10.14.2-linux-x64/bin/pm2 /usr/bin/
```

**安装编译**
```shell
git clone https://github.com/ss1917/admin-front.git
cd admin-front
### 修改配置 baseUrl pro 为你的后端地址 例如
baseUrl: {
    dev: '',
    pro: '/api/'
  },
vim src/config/index.js
npm install --ignore-script
npm run build
mkdir -p /var/www/admin-front && rm -rf /var/www/admin-front/*
\cp -arp dist/* /var/www/admin-front
```

**安装nginx**
`使用nginx代理，或者使用网关, 推荐使用网关代理节约资源`

```shell
[ -f /etc/nginx/nginx.conf ] && echo "nginx already exists" && exit -1
cd /usr/local/src
wget -q -c http://nginx.org/packages/centos/7/x86_64/RPMS/nginx-1.14.2-1.el7_4.ngx.x86_64.rpm
yum install -y nginx-1.14.2-1.el7_4.ngx.x86_64.rpm >/dev/null 2>&1
cat >/etc/nginx/nginx.conf<<EOF
user  nginx;
worker_processes auto;
worker_rlimit_nofile 51200;
pid        /var/run/nginx.pid;
error_log  /var/log/nginx/error.log  warn;
events {
    use epoll;
    worker_connections 51200;
}
stream{
    include  /etc/nginx/sshconf/*.conf ;
}
http {
    include       mime.types;
    default_type  text/html;
    log_format main  '$host | $server_addr | $http_x_forwarded_for | $remote_addr | $remote_user | $time_local | $request | $status | $body_bytes_sent '
                        '| $http_referer | $http_user_agent | $upstream_addr | $upstream_status | $upstream_response_time | $request_time';

    client_max_body_size            64m;
    client_header_buffer_size       32k;
    #client_body_buffer_size         64m;
    map_hash_bucket_size            64;
    types_hash_bucket_size          64;
    variables_hash_bucket_size      128;
    server_names_hash_bucket_size   128;
    server_name_in_redirect         off;
    sendfile    on;
    tcp_nopush  on;
    tcp_nodelay on;
    server_tokens       off;
    keepalive_timeout   15;
    client_body_timeout 3600;
    client_header_timeout 3600;

    gzip on;
    gzip_min_length     1k;
    gzip_buffers        4 16k;
    gzip_http_version   1.0;
    gzip_comp_level     2;
    gzip_types      text/plain application/x-javascript text/css application/xml;
    gzip_vary           on;
    ssi on;
    ssi_silent_errors on;
    ssi_types text/shtml;
    charset  utf-8;

    include /etc/nginx/conf.d/*.conf;
}
EOF
[ -f /etc/nginx/conf.d/default.conf ] && mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default-`date +%F`

cat >/etc/nginx/conf.d/demo.conf<<\EOF
server {
        listen      80;
        server_name demo.opendevops.cn;
        access_log /var/log/nginx/ops-demo_access.log;
        error_log  /var/log/nginx/ops-demo_error.log;

        location / {
                    root /var/www/admin-front;
                    index index.html index.htm;
                    try_files $uri $uri/ /index.html;
                    }

        location /api {
                add_header 'Access-Control-Allow-Origin' '*';
                proxy_pass http://gw.shinezone.net.cn;
        }
        location ~ /(.svn|.git|admin|manage|.sh|.bash)$ {
            return 403;
        }
    }
EOF
mkdir /var/www/admin-front/ -p
systemctl enable nginx >/dev/null 2>&1
systemctl start nginx
```

#### API网关部署

**安装openresty**

```shell
yum update
yum install yum-utils
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum install openresty
yum install openresty-resty
```

**部署网关**
```shell

git clone https://github.com/ss1917/api-gateway.git
\cp -arp api-gateway/* /usr/local/openresty/nginx/
```

**修改配置**
参考[API网关](https://github.com/ss1917/api-gateway/blob/master/README.md)

因为 我把前端静态文件也使用 网关进行代理 所以配置文件如下

```nginx
#  /usr/local/openresty/nginx/conf/nginx.conf
user root;
worker_processes auto;
worker_rlimit_nofile 51200;
error_log logs/error.log;
events {
    use epoll;
    worker_connections 51024;
}
http {
    #设置默认lua搜索路径
    lua_package_path '$prefix/lua/?.lua;/blah/?.lua;;';
    lua_code_cache off;         #线上环境设置为on, off时可以热加载lua文件
    lua_shared_dict user_info 1m;
    lua_shared_dict my_limit_conn_store 100m;   #100M可以放1.6M个键值对
    include             mime.types;

    client_header_buffer_size 64k;
    large_client_header_buffers 4 64k;
    proxy_redirect off;
    proxy_buffering off;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Scheme $scheme;

    init_by_lua_file lua/init_by_lua.lua;       #nginx启动时就会执行
    #include /etc/nginx/conf.d/*.conf;
    include ./conf.d/*.conf;                    #lua生成upstream
    resolver 10.2.2.236;                        # 内部DNS

}
```

```shell

# /usr/local/openresty/nginx/conf/conf.d/demo.conf
server {
        listen       80;
        server_name demo.opendevops.cn;
        access_log /var/log/nginx/f_access.log;
        error_log  /var/log/nginx/f_error.log;
        root /var/www/admin-front;

        location / {
                    root /var/www/admin-front;
                    index index.html index.htm;
                    try_files $uri $uri/ /index.html;
                    }

        location /api {
                add_header 'Access-Control-Allow-Origin' '*';
                proxy_pass http://gw.opendevops.cn;
        }

        location ~ /(.svn|.git|admin|manage|.sh|.bash)$ {
            return 403;
        }
}

```

```shell
# /usr/local/openresty/nginx/conf/conf.d/gw.conf
    server {
        listen 80;
        server_name  gw.opendevops.cn;
        lua_need_request_body on;           # 开启获取body数据记录日志

        location / {
            access_by_lua_file lua/access_check.lua;
            set $my_upstream $my_upstream;
            proxy_pass http://$my_upstream;

            add_header Access-Control-Allow-Methods *;
            add_header Access-Control-Max-Age 3600;
            add_header Access-Control-Allow-Credentials true;
            add_header Access-Control-Allow-Origin $http_origin;
            add_header Access-Control-Allow-Headers $http_access_control_request_headers;
            if ($request_method = OPTIONS){
                return 204;}

        }
    }
```

#### 任务系统

**[获取代码](hhttps://github.com/opendevops-cn/codo-task)**

```shell
git clone https://github.com/opendevops-cn/codo-task
```

**修改配置**
对settings 里面的配置文件进行修改

编译镜像
```shell

docker build . -t task_scheduler_image
```
**docker启动**
> 保证变量正确

```s
cat >docker-compose.yml <<EOF
task_scheduler:
  restart: unless-stopped
  image: task_scheduler_image
  volumes:
    - /var/log/supervisor/:/var/log/supervisor/
    - /var/www/task_scheduler:/var/www/task_scheduler/
    - /root/ops_scripts:/root/ops_scripts
    - /sys/fs/cgroup:/sys/fs/cgroup
  ports:
    - "8020:80"
  environment:
EOF
docker-compose up -d
```

#### 定时任务

**获取代码**
```
git clone https://github.com/opendevops-cn/codo-cron
初始化数据库 doc/data.sql
修改settings 配置 主要是MySQL数据库和redis 配置
执行 docker build . -t do_cron_image
docker-compose up -d
注意，此任务只能开一个进程，多个会导致重复执行
```
