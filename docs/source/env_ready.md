### 环境准备

> 服务介绍请参考：http://docs.opendevops.cn/zh/latest/introduction.html


**注意**

- 国内Github速度慢问题
- Docker默认镜像源下载慢问题

**建议配置**

- 系统： CentOS7+
- CPU：  2Core+
- 内存：  4G+
- 磁盘：  >=50+


**初始化环境变量**

- 请根据自己环境修改以下变量地址，后续平台里面调用需要使用到。

创建项目目录
```
$ mkdir -p /opt/codo/ && cd /opt/codo/
```


以下贴入到env.sh文件，请修改以下环境变量信息, `source env.sh`

```shell
#本机的IP地址
export LOCALHOST_IP="10.10.10.12"

#设置你的MYSQL密码
export MYSQL_PASSWORD="m9uSFL7duAVXfeAwGUSG"

### 设置你的redis密码
export REDIS_PASSWORD="cWCVKJ7ZHUK12mVbivUf"

### RabbitMQ用户密码信息
export MQ_USER="ss"
export MQ_PASSWORD="5Q2ajBHRT2lFJjnvaU0g"

### 管理后端地址
export mg_domain="mg.opendevops.cn"

### 定时任务地址
export cron_domain="cron.opendevops.cn"

### 任务系统地址
export task_domain="task.opendevops.cn"

### CMDB系统地址
export cmdb_domain="cmdb.opendevops.cn"

### 前端地址
export front_domain="demo.opendevops.cn"

### api网关地址
export api_gw_url="gw.opendevops.cn"

#codo-admin
export cookie_secret="nJ2oZis0V/xlArY2rzpIE6ioC9/KlqR2fd59sD=UXZJ=3OeROB"
export token_secret="1txIq2QUkeFsZizt3vEpVzUQNFS2@DpEQwbbw8k0YJt0biFScH"

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
    echo -e "\033[32m [INFO]: mysql -h 127.0.0.1 -uroot -p${MYSQL_PASSWORD}. \033[0m"
else
    echo -e "\033[31m [ERROR]: mysql57 install faild \033[0m"
    exit -3
fi
```
**导入数据**
```
#安装MySQL客户端测试一下
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum -y install Percona-Server-client-56
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD}  #确认可以正常链接mysql

#初始化SQL文件
wget https://raw.githubusercontent.com/opendevops-cn/opendevops/master/data.sql
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} < data.sql
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
EOF

#添加配置
echo "nameserver $LOCALHOST_IP" > /etc/resolv.conf   #注意：需要将本机DNS改成自己，不然没办法访问以上mg.cron,cmdb等内网域名
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


