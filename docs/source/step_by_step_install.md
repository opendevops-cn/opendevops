### 一步步安装方式

> 这部分文档可以帮助你一步步安装部署[CoDo(CloudOpenDevOps)](http://www.opendevops.cn/)云管理平台
由于项目是模块化的，如果你不想使用某个模块可以选择不用安装（但是必须项是一定要安装的哦！）

`提示：此文档里面直接用到shell和docker方便大家安装，因此需要有一定的运维基础，否则理解起来会稍有吃力，
But, 也没问题，你可以加入我们的CoDo社区交流群呀，大家一起进步呀～～！`

#### 初始化环境变量(必须)
> 请根据自己环境修改以下变量地址，后续平台里面调用需要使用到, 你可以在/opt下创建一个codo目录，后续操作都在此执行

`mkdir -p /opt/codo/ && cd /opt/codo/`

```shell
### 请自行修改相关配置,然后直接贴到终端上即可，注意：此环境变量是临时生效，关闭终端就没了。
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

#### 安装Python3(必须)
> 建议使用Python36,若你的系统里面已经存在Python36可以跳过此步骤。

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

#### 安装Docker-compose(必须)
> 若已安装docker-compose可跳过
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

#### 安装MySQL(必须)
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
echo  "mysql -h 127.0.0.1 -uroot -p${MYSQL_PASSWORD}"
### 确认可以正常链接mysql
```

#### 安装Redis(必须)
```shell
#将以下shell脚本复制粘贴到一个文件，执行即可

function init_redis()
{
    echo "Start init redis"
    ### 开启AOF
    sed -i 's#appendonly no$#appendonly yes#g' /etc/redis.conf
    ### 操作系统决定
    sed -i 's#appendfsync .*$$#appendfsync everysec$#g' /etc/redis.conf
    ### 修改绑定IP
    sed -i 's/^bind 127.0.0.1$/#bind 127.0.0.1/g' /etc/redis.conf
    ### 是否以守护进程方式启动
    sed -i 's#daemonize no$#daemonize yes#g' /etc/redis.conf
    ### 当时间间隔超过60秒，或存储超过1000条记录时，进行持久化
    sed -i 's#^save 60 .*$#save 60 1000#g' /etc/redis.conf
    ### 快照压缩
    sed -i 's#rdbcompression no$#rdbcompression yes#g' /etc/redis.conf
    ### 添加密码
    sed -i "s#.*requirepass .*#requirepass ${REDIS_PASSWORD}#g" /etc/redis.conf
    echo "Start init redis end, must restart redis !!!"
}

[ -f /usr/bin/redis-server ] && echo "redis already exists" && init_redis && exit 0
echo "Start install redis server "
yum -y install redis-3.2.*

init_redis
systemctl restart redis
systemctl status redis

if [ $? == 0 ]; then
        echo "install successful"
else
        echo "install error" && exit -2
fi
```


#### 安装RabbitMQ(必须)
```shell
yum install  -y rabbitmq-server
rabbitmq-plugins enable rabbitmq_management
rabbitmq-server -detached
rabbitmqctl add_user ${MQ_USER} ${MQ_PASSWORD}
rabbitmqctl set_user_tags ${MQ_USER} administrator
rabbitmqctl  set_permissions  -p  '/'  ${MQ_USER} '.' '.' '.'
systemctl restart rabbitmq-server
systemctl status rabbitmq-server
systemctl enable rabbitmq-server
```

#### 安装DNS（必须）
> 部署内部DNS dnsmasq 主要用于内部通信。
```shell
yum install dnsmasq -y

cat > /etc/resolv.conf  <<EOF
listen-address=127.0.0.1,172.16.0.20   #本机地址、DNS地址
strict-order
bind-interfaces
clear-on-reload
no-hosts
addn-hosts=/etc/dnsmasqhosts           #本地解析规则文件路径
all-servers
server=119.29.29.29                    #配置上行的真正的dns服务器地址，毕竟你只是个本地代理
EOF

## 配置本地解析规则，这才是我们的真实目的。新建配置文件 例如当前项目的解析 echo  "127.0.0.1 mg.opendevops.cn" >> /etc/dnsmasqhosts
vi /etc/dnsmasqhosts
10.2.2.236 demo.opendevops.cn   //示例
10.2.2.236 gw.opendevops.cn     //示例

## 重启
/bin/systemctl restart dnsmasq.service
## 加入开机自启
/bin/systemctl enable dnsmasq.service

##测试
可以找一台机器，DNS改成你这台机器的DNS地址，然后解析你的`/etc/dnsmasqhosts`域名看是否可以内部解析

```


#### 安装codo-admin(必须)
>`codo-admin`是基于tornado框架 restful风格的API 实现后台管理,[codo详细参考](https://github.com/ss1917/do_mg),搭配使用admin-front前端(iView+ vue)组成的一套后台用户 权限以及系统管理的解决方案（提供登录，注册 密码修改 鉴权 用户管理 角色管理 权限管理 前端组件管理 前端路由管理 通知服务API 系统基础信息接口）

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
docker build . -t do_mg_image
```
**Docker启动**

`此处要保证 变量正确`
```shell
cat >docker-compose.yml <<EOF
codoadmin:
  restart: unless-stopped
  image: do_mg_image
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

#### 安装codo(必须)
> 项目前端代码

**安装Node**
> shell脚本内容，复制内容到.sh文件执行即可

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

**获取代码，修改配置**
```shell
cd /opt/codo/ && git clone https://github.com/opendevops-cn/codo.git && cd codo


vim src/config/index.js
### 修改配置 baseUrl pro 为你的后端地址, 默认已修改好，例如
baseUrl: {
    dev: '',
    pro: '/api/'
  },
npm install --ignore-script
npm run build
mkdir -p /var/www/codo && rm -rf /var/www/codo/*
\cp -arp dist/* /var/www/codo/

### 后续访问使用API网关中的vhosts，节省资源，这里不单独安装配置nginx
```



#### 安装API网关(必须)
> 由于此项目是模块化、微服务化，因此需要在借助API网关，需要在API网关注册，此步骤是必须的。

**安装openresty**

```shell
yum update
yum install yum-utils -y
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum install openresty -y
yum install openresty-resty -y
```

**部署网关**
```shell
cd /opt/codo/ && git clone https://github.com/ss1917/api-gateway.git
\cp -arp api-gateway/* /usr/local/openresty/nginx/
```

**修改配置**
> 主要修改`nginx.conf`配置信息和`config.lua`配置，具体参考API网关块：[API网关修改配置](https://github.com/ss1917/api-gateway/blob/master/README.md#%E4%BA%8C-%E4%BF%AE%E6%94%B9%E9%85%8D%E7%BD%AE)

接下来配置：

    因为我把前端静态文件也使用 网关进行代理 所以配置文件如下

```nginx
# 全局nginx配置
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
    resolver 10.2.2.236;                        # 内部DNS地址，上面dnsmasq地址

}
```

```shell
#前端vhosts
mkdir -p /usr/local/openresty/nginx/conf/conf.d/
# /usr/local/openresty/nginx/conf/conf.d/demo.conf
server {
        listen       80;
        server_name demo.opendevops.cn;
        access_log /var/log/nginx/f_access.log;
        error_log  /var/log/nginx/f_error.log;
        root /var/www/codo;

        location / {
                    root /var/www/codo;
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
#网关vhosts
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

**API网关启动**
```shell
#OpenResty 是一个基于 Nginx 与 Lua 的高性能 Web 平台，使用的也是80端口，若不能启动请检查你的80端口是否被占用了
systemctl start openresty
systemctl enable openresty

```


#### 安装任务系统(必须)
> CoDo系统中核心模块，部署参考文档：[codo-cron](https://github.com/opendevops-cn/codo-task)
- 默认端口：8020
- 启动成功后请在API网关进注册，注册后才可以使用此服务，[参考API网关注册](https://github.com/ss1917/api-gateway/blob/master/README.md#%E4%B8%89%E4%BD%BF%E7%94%A8%E9%85%8D%E7%BD%AE%E6%B3%A8%E5%86%8Capi)




#### 安装定时任务(可选)
> CoDo系统中定时任务模块，需要用到此功能请安装，部署参考文档：[codo-cron](https://github.com/opendevops-cn/codo-cron)
- 默认端口：9900
- 启动成功后请在API网关进注册，注册后才可以使用此服务，[参考API网关注册](https://github.com/ss1917/api-gateway/blob/master/README.md#%E4%B8%89%E4%BD%BF%E7%94%A8%E9%85%8D%E7%BD%AE%E6%B3%A8%E5%86%8Capi)



#### 安装CMDB(可选)
> CoDo系统中CMDB资产管理模块，需要用到此功能请安装，部署参考文档：[codo-cron](https://github.com/opendevops-cn/codo-cmdb)
- 默认端口：8002
- 启动成功后请在API网关进注册，注册后才可以使用此服务，[参考API网关注册](https://github.com/ss1917/api-gateway/blob/master/README.md#%E4%B8%89%E4%BD%BF%E7%94%A8%E9%85%8D%E7%BD%AE%E6%B3%A8%E5%86%8Capi)


#### 安装K8S(可选)
> CoDo系统中K8S发布管理系统，需要用到此功能请安装，部署参考文档：[codo-cron](https://github.com/opendevops-cn/codo-k8s)
- 默认端口：8002
- 启动成功后请在API网关进注册，注册后才可以使用此服务，[参考API网关注册](https://github.com/ss1917/api-gateway/blob/master/README.md#%E4%B8%89%E4%BD%BF%E7%94%A8%E9%85%8D%E7%BD%AE%E6%B3%A8%E5%86%8Capi)



#### 示例：API网关注册

```
rewrite_conf = {
    [gw_domain_name] = {
        rewrite_urls = {
            {
                uri = "/cmdb",
                rewrite_upstream = "cmdb.opendevops.cn:8002"
            },
            {
                uri = "/k8s",
                rewrite_upstream = "k8s.opendevops.cn:8001"
            },
            {
                uri = "/task",
                rewrite_upstream = "task.opendevops.cn:8020"
            },
            {
                uri = "/cron",
                rewrite_upstream = "10.2.2.236:9900"
            },
            {
                uri = "/mg",
                rewrite_upstream = "mg.opendevops.cn:8010"
            },
            {
                uri = "/accounts",
                rewrite_upstream = "mg.opendevops.cn:8010"
            },
        }
    }
}
```



> PS: 此文档我们正在努力更新中，若有疑问你也可以加入我们的社区谈论群，欢迎加入讨论，让我们共同进步！