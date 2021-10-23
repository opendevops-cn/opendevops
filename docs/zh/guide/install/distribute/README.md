# 分布式部署

::: tip

部署视频参考：

视频会在业余时间持续录制，更多视频可以参考Up主空间：https://space.bilibili.com/388245257/

- [部署安装教程](https://www.bilibili.com/video/BV1BL4y1a7TU/)
- [快速了解视频](https://www.bilibili.com/video/BV1rp4y1v7fa/)
- [二次开发教程](https://www.bilibili.com/video/BV1Sy4y137md/)

:::


## 环境准备

**建议配置**

- 系统：  CentOS7+
- CPU：   4Core+
- 内存：  8G+
- 磁盘：  50G+



**基础环境**
- 版本约束
  - Python3.6
  - Redis3.2
  - MySQl5.7
  - RabbitMQ
  - Docker
  - Docker-compose



**优化系统**

注意：

- 如果你的系统是新的，我们建议你先优化下系统，同样我们也提供了[优化系统脚本](https://github.com/opendevops-cn/opendevops/tree/master/scripts/system_init_v1.sh)
- 以下基础环境中，若你的系统中已经存在可跳过，直接配置，建议使用我们推荐的版本


**环境变量**
>创建项目目录

```
$ mkdir -p /opt/codo/ && cd /opt/codo/
```

> 以下内容贴入到`vim /opt/codo/env.sh`文件，主要修改配置地址和密码信息

```shell

echo -e "\033[31m 注意：token_secret一定要做修改，防止网站被攻击!!!!!!! \033[0m"
echo -e "\033[32m 注意：token_secret一定要做修改，防止网站被攻击!!!!!!! \033[0m"
echo -e "\033[33m 注意：token_secret一定要做修改，防止网站被攻击!!!!!!! \033[0m"

#部署的IP地址
export LOCALHOST_IP="10.10.10.12"

#设置你的MYSQL密码
export MYSQL_PASSWORD="m9uSFL7duAVXfeAwGUSG"

### 设置你的redis密码
export REDIS_PASSWORD="cWCVKJ7ZHUK12mVbivUf"

### RabbitMQ用户密码信息
export MQ_USER="ss"
export MQ_PASSWORD="5Q2ajBHRT2lFJjnvaU0g"


#codo-admin用到的cookie和token
export cookie_secret="nJ2oZis0V/xlArY2rzpIE6ioC9/KlqR2fd59sD=UXZJ=3OeROB"
# 这里codo-admin和gw网关都会用到，一定要修改。可生成随意字符
export token_secret="pXFb4i%*834gfdh963df718iodGq4dsafsdadg7yI6ImF1999aaG7"


##如果要进行读写分离，Master-slave主从请自行建立，一般情况下都是只用一个数据库就可以了
# 写数据库
export DEFAULT_DB_DBHOST="10.10.10.12"
export DEFAULT_DB_DBPORT='3306'
export DEFAULT_DB_DBUSER='root'
export DEFAULT_DB_DBPWD=${MYSQL_PASSWORD}
#export DEFAULT_DB_DBNAME=${mysql_database}

# 读数据库
export READONLY_DB_DBHOST='10.10.10.12'
export READONLY_DB_DBPORT='3306'
export READONLY_DB_DBUSER='root'
export READONLY_DB_DBPWD=${MYSQL_PASSWORD}
#export READONLY_DB_DBNAME=${mysql_database}

# 消息队列
export DEFAULT_MQ_ADDR='10.10.10.12'
export DEFAULT_MQ_USER=${MQ_USER}
export DEFAULT_MQ_PWD=${MQ_PASSWORD}

# 缓存
export DEFAULT_REDIS_HOST='10.10.10.12'
export DEFAULT_REDIS_PORT=6379
export DEFAULT_REDIS_PASSWORD=${REDIS_PASSWORD}

```

==**最后一定不要忘记source**：==  `source /opt/codo/env.sh` 



**关闭SELINUX**

- 若已关闭请跳过
```shell

#临时关闭
$ setenforce 0

#或修改配置文件关闭,需要重启

$ vi /etc/selinux/config  

将SELINUX=enforcing改为SELINUX=disabled 
设置后需要重启才能生效  

```

**清空防火墙规则**

`注意，不要关闭防火墙，Docker需要用到NAT`

```shell
#只清空filter链即可
$ iptables -F

```



**安装Python3**

> 建议使用Python36,若你的系统里面已经存在Python36可以跳过此步骤。

```shell
echo -e "\033[32m [INFO]: Start install python3 \033[0m"
yum update -y
yum groupinstall Development tools -y
yum -y install zlib-devel
yum install -y openssl-devel libxslt-devel libxml2-devel libcurl-devel
yum install python3 -y 
```


**安装docker**  

> 若已安装可跳过

```shell
echo -e "\033[32m [INFO]: Start install docker,docker-compose \033[0m"
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge
yum install -y docker-ce
#启动和开机自启
/bin/systemctl start docker.service

/bin/systemctl enable docker.service
```

**安装docker-compose编排工具**
```
#curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py 如果没有pip3 请安装
pip3 install docker-compose
```

**安装MySQL**

> 一般来说一个MySQL实例即可，如果有需求可以自行搭建主从，微服务每个服务都可以有自己的数据库
>
> 我们这里示例是用Docker部署的MySQL，如果你要用已有的数据库请修改`/opt/codo/env.sh`

```shell
source /opt/codo/env.sh
mkdir -p /opt/codo/codo-mysql&& cd /opt/codo/codo-mysql
cat >docker-compose.yml <<EOF
mysql:
  restart: unless-stopped
  image: registry.cn-shanghai.aliyuncs.com/ss1917/mysql:5.7
  volumes:
    - /data/mysql:/var/lib/mysql
    - /data/mysql_conf:/etc/mysql/conf.d
  ports:
    - "3306:3306"
  environment:
    - MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD}
EOF

#启动 
docker-compose up -d
# 安装MySQL客户端
yum install mysql -y  

if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: mysql install success. \033[0m"
    echo -e "\033[32m [INFO]: 最好提高下MySQL的最大链接数. \033[0m"
    echo -e "\033[32m [INFO]: mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} \033[0m"
else
    echo -e "\033[31m [ERROR]: mysql57 install faild \033[0m"
    exit -3
fi
```

- 测试 `mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD}`

**安装Redis**

- 创建 docker-compose.yml

```
source /opt/codo/env.sh
mkdir -p /opt/codo/codo-redis && cd /opt/codo/codo-redis
cat >docker-compose.yml <<EOF
redis:
    image: registry.cn-shanghai.aliyuncs.com/ss1917/redis:4
    ports:
      - 6379:6379
    restart: unless-stopped
    command: redis-server --requirepass ${REDIS_PASSWORD}
EOF

#启动
docker-compose up -d
```
- 没有cli的同学，请`yum install redis -y` 
- 测试 `redis-cli -h 127.0.0.1 -p 6379 -a ${REDIS_PASSWORD}`


**安装RabbitMQ**

- 创建 docker-compose.yml

```shell
source /opt/codo/env.sh
mkdir -p /opt/codo/codo-mq && cd /opt/codo/codo-mq 
cat >docker-compose.yml <<EOF
rabbitmq:
    restart: unless-stopped
    image: registry.cn-shanghai.aliyuncs.com/ss1917/rabbitmq:3-management
    environment:
      - RABBITMQ_DEFAULT_USER=${MQ_USER}
      - RABBITMQ_DEFAULT_PASS=${MQ_PASSWORD}
    ports:
      - "15672:15672"
      - "5672:5672"
EOF

#启动
docker-compose up -d
```


**安装DNS**

- 注意，这里如果你内部有自己DNS，你也可以选择使用你自己的

> 部署内部DNS dnsmasq 用于服务间内部通信，API网关需要配置，切记

```shell
echo -e "\033[32m [INFO]: Start install dnsmasq \033[0m"
yum install dnsmasq -y

# 设置上游DNS，毕竟你的Dns只是个代理
cat >/etc/resolv.dnsmasq <<EOF
nameserver 114.114.114.114
nameserver 8.8.8.8
EOF

# 设置host解析
echo -e "\033[32m [INFO]: 如果你是单机部署，那么你就将你的本机IP+模块域名解析即可，如果你是分布式部署的，那么每个模块对应的机器IP一定不要搞错，这个很重要，后面网关也要依赖此DNS去解析你的域名，帮你做服务转发的，切记！！！！
 \033[0m"
cat >/etc/dnsmasqhosts <<EOF
$LOCALHOST_IP demo-init.opendevops.cn
$LOCALHOST_IP mg.opendevops.cn
$LOCALHOST_IP task.opendevops.cn
$LOCALHOST_IP gw.opendevops.cn
$LOCALHOST_IP cmdb2.opendevops.cn
$LOCALHOST_IP kerrigan.opendevops.cn
$LOCALHOST_IP tools.opendevops.cn
$LOCALHOST_IP cron.opendevops.cn
$LOCALHOST_IP dns.opendevops.cn
EOF

# 添加配置
echo -e "\033[32m [INFO]: 刚装完DNS可以先不用改本机的DNS，有一部分人反应Docker Build时候会报连不上mirrors，装不了依赖。部署到API网关的时候，需要将本机DNS改成自己，不然没办法访问以上mg，cron，cmdb等内网域名
\033[0m"

# 注意下一步是覆盖你本机的DNS，建议把你的DNS地址加在/etc/resolv.dnsmasq 里面 
cp -rp /etc/resolv.conf /etc/resolv.conf-`date +%F`
# echo "nameserver $LOCALHOST_IP" > /etc/resolv.conf  
sed "1i\nameserver ${LOCALHOST_IP}" /etc/resolv.conf -i 
###注意注意， 这里修改完后，请你一定要确定你nameserver ${LOCALHOST_IP} 内部DNS在第一条、第一条、第一条，放在下面是不能正常解析的.

echo "resolv-file=/etc/resolv.dnsmasq" >> /etc/dnsmasq.conf
echo "addn-hosts=/etc/dnsmasqhosts" >> /etc/dnsmasq.conf

## 启动
/bin/systemctl enable dnsmasq.service
/bin/systemctl start dnsmasq.service
systemctl status dnsmasq
if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: dnsmasq install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: dnsmasq install faild \033[0m"
    exit -6
fi
```

**基础依赖部署完毕**


## 项目前端

> 更新后的项目前端将不再让用户下载静态资源包，使用自动构建的方式，默认保持最新前端

```
[ ! -d /opt/codo/codo/ ] && mkdir -p /opt/codo/codo/ && cd /opt/codo/codo/
```

**一、修改域名**

下列为默认域名，如果要修改访问入口地址请修改`server_name`对应的`demo-init.opendevops.cn`，确保能DNS解析到此域名，或者自己绑定hosts来测试一下

```
cat >codo_frontend.conf <<\EOF
server {
        listen       80;
        server_name demo-init.opendevops.cn;
        access_log /var/log/nginx/codo-access.log;
        error_log  /var/log/nginx/codo-error.log;

        location / {
                    root /var/www/codo;
                    index index.html index.htm;
                    try_files $uri $uri/ /index.html;
        }
        location /api {
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

                add_header 'Access-Control-Allow-Origin' '*';
                proxy_pass http://gw.opendevops.cn:8888;
        }

        location ~ /(.svn|.git|admin|manage|.sh|.bash)$ {
            return 403;
        }
}
EOF

```

**创建Dockerfile**

```shell
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/codo

#修改nginx配置
#ADD nginx.conf /etc/nginx/nginx.conf
ADD codo_frontend.conf /etc/nginx/conf.d/codo_frontend.conf

EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
EOF

```

**创建 docker-compose.yml**

```shell
cat >docker-compose.yml <<EOF
codo:
  restart: unless-stopped
  image: codo_image
  volumes:
    - /var/log/nginx/:/var/log/nginx/
    - /sys/fs/cgroup:/sys/fs/cgroup
  ports:
    - "80:80"
    - "443:443"
EOF

```

**三、编译，启动**

```shell
docker build . -t codo_image
docker-compose up -d
```


**四、测试**

```
curl  0.0.0.0:80
tailf  /var/log/nginx/codo-access.log
```

## 管理后端

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



## 资产管理



**下载代码**

```shell
echo -e "\033[32m [INFO]: codo_cmdb(资产管理) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-cmdb.git
cd codo-cmdb
```



**修改配置**

- 修改`settings.py`配置信息
```bash
#导入环境变量文件，最开始准备的环境变量文件
source /opt/codo/env.sh

#修改配置
#后端数据库名称,建议不要修改，初始化data.sql已经指定了数据库名字，若需改请一块修改
CMDB_DB_DBNAME='codo_cmdb' 

#任务系统的域名
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py

#mysql配置
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${CMDB_DB_DBNAME}')#g" settings.py

#只读MySQL配置
sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" settings.py
sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" settings.py
sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" settings.py
sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" settings.py
sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${CMDB_DB_DBNAME}')#g" settings.py

#redis配置
sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" settings.py

#这里如果配置codo-task的数据库地址，则将数据同步到作业配置

TASK_DB_DBNAME='codo_task' 
sed -i "s#CODO_TASK_DB_HOST = .*#CODO_TASK_DB_HOST = os.getenv('CODO_TASK_DB_HOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#CODO_TASK_DB_PORT = .*#CODO_TASK_DB_PORT = os.getenv('CODO_TASK_DB_PORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#CODO_TASK_DB_USER = .*#CODO_TASK_DB_USER = os.getenv('CODO_TASK_DB_USER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#CODO_TASK_DB_PWD = .*#CODO_TASK_DB_PWD = os.getenv('CODO_TASK_DB_PWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#CODO_TASK_DB_DBNAME = .*#CODO_TASK_DB_DBNAME = os.getenv('CODO_TASK_DB_DBNAME', '${TASK_DB_DBNAME}')#g" settings.py

```



- AWS事件和WebTerminnal配置

> 首先将webterminal部署上去

```shell
docker pull webterminal/webterminallte
docker run -itd -p 8080:80 webterminal/webterminallte
```  

`修改settings.py文件`

```shell

# Aws Events 事件邮件通知人
AWS_EVENT_TO_EMAIL = '1111@qq.com,2222@gmail.com'

#Web Terminal 地址，请填写你部署的webterminal地址
#注意这里是填写你上面docker run的机器外网IP
WEB_TERMINAL = 'http://1.1.1.1:8080'

```


**修改Dockerfile**

使用自动构建的镜像，默认使用最新版本，这一步的目的是把修改后的配置覆盖进去

```shell
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/codo-cmdb

#修改应用配置
ADD settings.py /var/www/codo-cmdb/

#修改nginx配置和守护配置
#COPY doc/nginx_ops.conf /etc/nginx/conf.d/default.conf
#COPY doc/supervisor_ops.conf  /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
EOF

```


**打包镜像**

```
docker build . -t codo_cmdb  
```

**启动Docker**

```
docker-compose up -d
```



**创建数据库**

```
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} -e 'create database `codo_cmdb` default character set utf8mb4 collate utf8mb4_unicode_ci;'
```

**初始化表结构**

```
docker exec -ti codo-cmdb_codo_cmdb_1 /usr/local/bin/python3 /var/www/codo-cmdb/db_sync.py
```

**重启**

```
docker-compose  restart 
```

**日志文件**

- 服务日志：`/var/log/supervisor/cmdb.log`  #主程序日志
- 定时日志：`/var/log/supervisor/cmdb_cron.log` #一些后端守护自动运行的日志
```
tailf /var/log/supervisor/cmdb.log
tailf /var/log/supervisor/cmdb_cron.log 
```

**资产管理系统部署完成**


## 定时任务

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


## 任务系统

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

## 运维工具

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


**修改Dockerfile**

使用自动构建的镜像，默认使用最新版本，这一步的目的是把修改后的配置覆盖进去

```shell
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/codo-tools

#修改应用配置
ADD settings.py /var/www/codo-tools/

#修改nginx配置和守护配置
#COPY doc/nginx_ops.conf /etc/nginx/conf.d/default.conf
#COPY doc/supervisor_ops.conf  /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
EOF

```


**编译镜像**

```shell
docker build . -t codo_tools
```

**启动**
```
docker-compose up -d
```


**创建数据库**

```
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} -e 'create database `codo_tools` default character set utf8mb4 collate utf8mb4_unicode_ci;'
```


**初始化表结构**

```
docker exec -ti  codo-tools_codo_tools_1  /usr/local/bin/python3 /var/www/codo-tools/db_sync.py 
```

**重启**

```
docker-compose  restart 
```


**测试codo-tools**

```shell
### 01.日志
tailf /var/log/supervisor/tools.log  #服务日志，确认没有报错
tailf /var/log/supervisor/cron_jobs.log  #定时提醒日志
```

**运维工具系统部署完成**

## 配置中心

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


## 域名管理

> CODO域名管理模块，管理BIND 支持智能解析，多域名，多主。

**下载代码**
```shell
echo -e "\033[32m [INFO]: codo_dns(域名管理) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-dns.git
cd codo-dns
```



**修改配置**
> 同样，这里codo-dns也支持取env环境变量，建议还是修改下默认配置

```shell
#导入环境变量文件，最开始准备的环境变量文件
source /opt/codo/env.sh
#后端数据库名称
CRON_DB_DBNAME='codo_dns' 

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
FROM registry.cn-shanghai.aliyuncs.com/ss1917/codo-dns

#修改应用配置
ADD settings.py /var/www/codo-dns/

#修改nginx配置和守护配置
#COPY doc/nginx_ops.conf /etc/nginx/conf.d/default.conf
#COPY doc/supervisor_ops.conf  /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
EOF

```


**编译，启动**

```
#编译镜像
docker build . -t codo_dns_image
#启动
docker-compose up -d
```



**创建数据库**

```
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} -e 'create database `codo_dns` default character set utf8mb4 collate utf8mb4_unicode_ci;'
```



**初始化表结构**

```
docker exec -ti codo-dns_codo-dns_1  /usr/local/bin/python3 /var/www/codo-dns/db_sync.py
```



**重启**

```
docker-compose  restart 
```


**测试**

> 日志文件位置统一：/var/log/supervisor/

```
01. 查看日志
tailf /var/log/supervisor/codo_dns.log   #确认没报错
```

**域名管理部署完成**

## API网关（部署容易出问题的地方）

::: tip
重点部分，请仔细阅读
由于此项目是模块化、微服务化，因此需要在借助API网关，需要在API网关注册，此步骤是必须的。
:::



**注意事项**

开始之前，你需要确认以下2个事情

- DNS服务是否正常，域名能否正常解析
- 微服务的模块部署是否正常，进行检测

**检查DNS思路**

```shell
1. 确保你的dnsmasql服务是启动的，服务没有报错
2. 确保/etc/dnsmasqhosts文件有解析的IP
3. 确保你网关的这台机器/etc/resolv.conf DNS执行你刚部署的dnsmasq服务IP
4. 确保你网关所在的机器都能正常ping通所有的服务，比如：ping cmdb2.opendevops.cn
5. 确保你的防火墙规则是清空的`iptables -F`
6. 确保你的SELINUX是关闭的`setenforce 0`
```

**服务健康检测**

```
# 进行所有服务进行检测，返回200则正常
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://mg.opendevops.cn:8010/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://task.opendevops.cn:8020/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://cmdb2.opendevops.cn:8050/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://kerrigan.opendevops.cn:8030/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://cron.opendevops.cn:9900/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://tools.opendevops.cn:8040/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://dns.opendevops.cn:8060/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://0.0.0.0:80
```


**下载网关**
```shell
cd /opt/codo/ && git clone https://github.com/ss1917/api-gateway.git && cd /opt/codo/api-gateway
```

**修改配置**
> 主要修改`nginx.conf`配置信息和`config.lua`配置，具体参考API网关块：[API网关修改配置](https://github.com/ss1917/api-gateway/blob/master/README.md#%E4%BA%8C-%E4%BF%AE%E6%94%B9%E9%85%8D%E7%BD%AE)


**全局nginx配置**   

这里主要修改resolver 内部DNS服务器地址`conf/nginx.conf` ==一定要修改==

```nginx
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
    lua_code_cache on;      #线上环境设置为on, off时可以热加载lua文件
    lua_shared_dict user_info 1m;
    lua_shared_dict my_limit_conn_store 100m;   #100M可以放1.6M个键值对
    include             mime.types;    #代理静态文件

    client_header_buffer_size 64k;
    large_client_header_buffers 4 64k;

    init_by_lua_file lua/init_by_lua.lua;       # nginx启动时就会执行
    include ./conf.d/*.conf;                    # lua生成upstream
    resolver 10.10.10.12;                       # 内部DNS服务器地址 一定要修改 对应起来
}
```


**网关配置** `conf/conf.d/gw.conf`
```nginx
server {
    listen 80;
    server_name gw.opendevops.cn;
    lua_need_request_body on;           # 开启获取body数据记录日志

    location / {
        ### ws 支持
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        ### 获取真实IP
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        access_by_lua_file lua/access_check.lua;
        set $my_upstream $my_upstream;
        proxy_pass http://$my_upstream;

        ### 跨域
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


**注册API网关**

请仔细阅读下面需要修改配置的地方`vim lua/configs.lua` ==这个配置基本上都要修改，请务必仔细==


```lua
json = require("cjson")


-- redis配置，一定要修改，并且和codo-admin保持一致，admin会把权限写进去提供网关使用
redis_config = {
    host = '10.10.10.12',
    port = 6379,
    auth_pwd = 'cWCVKJ7ZHUK12mVbivUf',
    db = 8,
    alive_time = 3600 * 24 * 7,
    channel = 'gw'
}


-- 注意：这里的token_secret必须要和codo-admin里面的token_secret保持一致
token_secret = "pXFb4i%*834gfdh96(3df&%18iodGq4ODQyMzc4lz7yI6ImF1dG"
logs_file = '/var/log/gw.log'

--刷新权限到redis接口
rewrite_cache_url = 'http://mg.opendevops.cn:8010/v2/accounts/verify/'

-- 注意：rewrite_cache_token要和codo-admin里面的secret_key = '8b888a62-3edb-4920-b446-697a472b4001'保持一致
rewrite_cache_token = '8b888a62-3edb-4920-b446-697a472b4001'  


--并发限流配置
limit_conf = {
    rate = 10, --限制ip每分钟只能调用n*60次接口
    burst = 10, --桶容量,用于平滑处理,最大接收请求次数
}

--upstream匹配规则,API网关域名
gw_domain_name = 'gw.opendevops.cn' 

--下面的转发一定要修改，根据自己实际数据修改
rewrite_conf = {
    [gw_domain_name] = {
        rewrite_urls = {
            {
                uri = "/dns",
                rewrite_upstream = "dns.opendevops.cn:8060"
            },
            {
                uri = "/cmdb2",
                rewrite_upstream = "cmdb2.opendevops.cn:8050"
            },
            {
                uri = "/tools",
                rewrite_upstream = "tools.opendevops.cn:8040"
            },
            {
                uri = "/kerrigan",
                rewrite_upstream = "kerrigan.opendevops.cn:8030"
            },
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
                rewrite_upstream = "cron.opendevops.cn:9900"
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

**修改Dockerfile**

使用自动构建的镜像，默认使用最新版本，这一步的目的是把修改后的配置覆盖进去

```
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/api-gateway

#修改配置
ADD . /usr/local/openresty/nginx/

EXPOSE 80
CMD ["/usr/bin/openresty", "-g", "daemon off;"]
EOF

```

**编译，启动**

```
#编译镜像
docker build . -t gateway_image
#启动
docker-compose up -d
```

启动后地址为`http://gw.opendevops.cn:8888`，这里是和前端的地址有对应，请勿修改

```
#测试一下
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://gw.opendevops.cn:8888/api/accounts/are_you_ok/
```

> 提醒:openresty服务器DNS必须指向--->最起初部署的DNS服务器地址,另外若你本机ping以上随便一个域名都不通的话，那你要确认下你本机DNS指向你最初部署了DNS服务器了？ 修改vim /etc/resolv.conf



**访问**

`注意： demo-init.opendevops.cn 建议修改成自己的域名，也可以绑定hosts来测试一下`  可以再部署前端的时候修改

- 地址：demo-init.opendevops.cn
- 用户：admin
- 密码：admin@opendevops

**日志路径**

> 若这里访问有报错，请看下日志，一般都是配置错误。
- 日志路径：所有模块日志统一`/var/log/supervisor/`


**特别感谢**  

感谢大佬 `shenyingzhi` 提供测试环境，特此致谢