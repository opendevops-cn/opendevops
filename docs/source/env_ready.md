### 环境准备

> 部署安装之前，你应该了解下每个模块的用途，[传送门](http://docs.opendevops.cn/zh/latest/introduction.html)

**部署视频**
> 近期有部分同学反应说部署太麻烦了，为什么不做成一个Docker，其实我们这里单项目已经是Docker部署了，为了更好的让用户更快的了解我们的平台，我们准备了部署视频，[视频入口](https://www.bilibili.com/video/av53446517?from=search&seid=16003251072301252333)


**注意**

- 国内Github速度慢问题
- Docker默认镜像源下载慢问题

**建议配置**

- 系统： CentOS7+
- CPU：  2Core+
- 内存：  4G+
- 磁盘：  >=50+





**准备基础环境**

> 基础环境需要用到以下服务，我们也提供了简单的[初始化脚本](https://raw.githubusercontent.com/opendevops-cn/opendevops/master/scripts/system_init_v1.sh)

- 建议版本
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



创建项目目录

```
$ mkdir -p /opt/codo/ && cd /opt/codo/
```

**环境变量**

> 以下内容贴入到env.sh文件，刚开始接触这里可能会稍微有点难理解，后面文档将会说明每个环境变量的用途，主要修改域名/地址和密码信息 `source env.sh`



```shell


echo -e "\033[31m token_secret一定要做修改，防止网站被攻击!!!!!!! \033[0m"

#本机的IP地址
export LOCALHOST_IP="10.10.10.12"

#设置你的MYSQL密码
export MYSQL_PASSWORD="m9uSFL7duAVXfeAwGUSG"

### 设置你的redis密码
export REDIS_PASSWORD="cWCVKJ7ZHUK12mVbivUf"

### RabbitMQ用户密码信息
export MQ_USER="ss"
export MQ_PASSWORD="5Q2ajBHRT2lFJjnvaU0g"

##这部分是模块化部署，微服务，每个服务都有一个单独的域名
### 管理后端地址
export mg_domain="mg.opendevops.cn"

### 定时任务地址,目前只启动一个进程，ip 
export cron_domain="10.10.10.12"

### 任务系统地址
export task_domain="task.opendevops.cn"

### CMDB系统地址
export cmdb_domain="cmdb2.opendevops.cn"

### 运维工具地址
export tools_domain="tools.opendevops.cn"


### 域名管理地址
export dns_domain="dns.opendevops.cn"


### 配置中心域名
export kerrigan_domain="kerrigan.opendevops.cn"

### 前端地址,也就是你的访问地址
export front_domain="demo.opendevops.cn"

### api网关地址
export api_gw_url="gw.opendevops.cn"


#codo-admin用到的cookie和token，可留默认
export cookie_secret="nJ2oZis0V/xlArY2rzpIE6ioC9/KlqR2fd59sD=UXZJ=3OeROB"
# 这里codo-admin和gw网关都会用到，一定要修改。可生成随意字符
export token_secret="pXFb4i%*834gfdh96(3df&%18iodGq4ODQyMzc4lz7yI6ImF1dG"

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

```shell
$ source env.sh  #最后一定不要忘记source
```





**安装Python3**

> 建议使用Python36,若你的系统里面已经存在Python36可以跳过此步骤。

```shell
echo -e "\033[32m [INFO]: Start install python3 \033[0m"
yum groupinstall Development tools -y
yum -y install zlib-devel
yum install -y python36-devel-3.6.3-7.el7.x86_64 openssl-devel libxslt-devel libxml2-devel libcurl-devel
cd /usr/local/src/
wget -q -c https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
tar xf  Python-3.6.4.tar.xz >/dev/null 2>&1 && cd Python-3.6.4
./configure >/dev/null 2>&1
make >/dev/null 2>&1 && make install >/dev/null 2>&1
if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: python3 install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: python3 install faild \033[0m"
    exit -1
fi
```

**安装Docker-compose**
> 若已安装docker-compose可跳过
```shell
echo -e "\033[32m [INFO]: Start install docker,docker-compose \033[0m"
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
if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: docker-compose install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: docker-compose install faild \033[0m"
    exit -2
fi
```

**安装MySQL**

> 一般来说 一个MySQL实例即可，如果有需求可以自行搭建主从，每个服务都可以有自己的数据库
>
> 我们这里示例是用Docker部署的MySQL，你也可以使用你自己的MySQL

```shell
echo -e "\033[32m [INFO]: Start install mysql5.7 \033[0m"
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
docker-compose up -d   #启动
if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: mysql install success. \033[0m"
    echo -e "\033[32m [INFO]: 没有mysql客户端的同学自己安装一下子哈, yum install mysql -y. \033[0m"
    echo -e "\033[32m [INFO]: mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} \033[0m"
else
    echo -e "\033[31m [ERROR]: mysql57 install faild \033[0m"
    exit -3
fi
```

**安装Redis**
```shell
echo -e "\033[32m [INFO]: Start install redis3.2 \033[0m"
yum -y install redis-3.2.*

echo "[INFO]: start init redis"
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
systemctl start redis
systemctl status redis
systemctl enable redis

if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: redis install success. \033[0m"
    echo -e "\033[32m [INFO]: redis-cli -h 127.0.0.1 -p 6379 -a ${REDIS_PASSWORD}"
else
    echo -e "\033[31m [ERROR]: redis install faild \033[0m"
    exit -4
fi
```


**安装RabbitMQ**

`注意安装完MQ后不要修改主机名，否则MQ可能会崩掉`
```shell
echo -e "\033[32m [INFO]: Start install rabbitmq \033[0m"
# echo $LOCALHOST_IP opendevops >> /etc/hosts
# echo opendevops > /etc/hostname
# export HOSTNAME=opendevops
yum install  -y rabbitmq-server
rabbitmq-plugins enable rabbitmq_management
systemctl start rabbitmq-server
rabbitmqctl add_user ${MQ_USER} ${MQ_PASSWORD}
rabbitmqctl set_user_tags ${MQ_USER} administrator
rabbitmqctl  set_permissions  -p  '/'  ${MQ_USER} '.' '.' '.'
systemctl restart rabbitmq-server
systemctl enable rabbitmq-server
systemctl status rabbitmq-server

# rabbitmq-server -detached
status=`systemctl status rabbitmq-server | grep "running" | wc -l`
if [ $status == 1 ];then
    echo -e "\033[32m [INFO]: rabbitmq install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: rabbitmq install faild \033[0m"
    exit -5
fi
```

**安装DNS**
> 部署内部DNS dnsmasq 主要用于内部通信，API网关要用到。
`注意：
   刚装完DNS可以先不用改本机的DNS，有一部分人反应Docker Build时候会报连不上mirrors，装不了依赖。
   部署到API网关的时候，需要将本机DNS改成自己，不然没办法访问以上mg.cron,cmdb等内网域名
echo "nameserver $LOCALHOST_IP" > /etc/resolv.conf `

```shell
echo -e "\033[32m [INFO]: Start install dnsmasq \033[0m"
#install dnsmasq
yum install dnsmasq -y

# 设置上游DNS，毕竟你的Dns只是个代理
cat >/etc/resolv.dnsmasq <<EOF
nameserver 114.114.114.114
nameserver 8.8.8.8
EOF

#设置host解析
cat >/etc/dnsmasqhosts <<EOF
$LOCALHOST_IP $front_domain
$LOCALHOST_IP $mg_domain
$LOCALHOST_IP $cron_domain
$LOCALHOST_IP $task_domain
$LOCALHOST_IP $api_gw_url
$LOCALHOST_IP $cmdb_domain
$LOCALHOST_IP $kerrigan_domain
$LOCALHOST_IP $tools_domain
$LOCALHOST_IP $dns_domain
EOF

#添加配置
#注意：
   # 刚装完DNS可以先不用改本机的DNS，有一部分人反应Docker Build时候会报连不上mirrors，装不了依赖。
   # 部署到API网关的时候，需要将本机DNS改成自己，不然没办法访问以上mg.cron,cmdb等内网域名
#echo "nameserver $LOCALHOST_IP" > /etc/resolv.conf   
echo "resolv-file=/etc/resolv.dnsmasq" >> /etc/dnsmasq.conf
echo "addn-hosts=/etc/dnsmasqhosts" >> /etc/dnsmasq.conf

## 启动
/bin/systemctl start dnsmasq.service
systemctl status dnsmasq
/bin/systemctl enable dnsmasq.service

if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: dnsmasq install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: dnsmasq install faild \033[0m"
    exit -6
fi
```



**CODO BASE镜像**

> 我们模块都是个人独立开发的，当时代码编写的时候是直接基于CentOS7来进行编写的Dockerfile，便于测试，需要的同学切记手动去修改下FROM就可以了。

- 为什么加上这一步?
  - 有部分用户反应说我们微服务里面每个Dockerfile都去重复安装了Python3
  - 这里我准备了Python3的 Base Dockerfile文件，使用人员可先制作一个codo_base的docker images
  - 如需部署模块慢的同学可以修改每个模块下的Dockerfile文件，`FROM codo_base`, 将Python之前的RUN去掉就可以了

BASE Dockerfile文件

```dockerfile
FROM centos:7
# 设置编码
ENV LANG en_US.UTF-8
# 同步时间
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo "216.176.179.218  mirrorlist.centos.org" >> /etc/hosts
# 1. 安装基本依赖
RUN yum update -y && yum install epel-release -y && yum update -y && yum install wget unzip epel-release nginx  xz gcc automake zlib-devel openssl-devel supervisor  groupinstall development  libxslt-devel libxml2-devel libcurl-devel git -y
#WORKDIR /var/www/

# 2. 准备python
RUN wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tar.xz
RUN xz -d Python-3.6.6.tar.xz && tar xvf Python-3.6.6.tar && cd Python-3.6.6 && ./configure && make && make install

# 3. 安装yum依赖
#pass
```

贴入Dockerfile文件，执行`docker build . -t codo_base`，需要的同学`注意：手动去修改下各模块下Dockerfile`即可
