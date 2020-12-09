# 单机部署

::: tip
完全抽象出来的本地部署方式，不理解Docker的同学可以使用本文的进行参考，线上我建议你分布式部署，分布式部署是Docker、Docker、Docker！！！
:::

## 环境准备

> 本地部署方式,采用pm2进行守护，这是针对一些不想玩Docker的同学准备的，如果你想容器你就分布式部署aaaaa!!!!! 
> 另外这里没写域名管理是怎么部署的， 如果需要参考分部署部署！！！！

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
  - node.js

**优化系统**

注意：

- 如果你的系统是新的，我们建议你先优化下系统，同样我们也提供了[优化系统脚本](https://github.com/opendevops-cn/opendevops/tree/master/scripts/system_init_v1.sh)
- 以下基础环境中，若你的系统中已经存在可跳过，直接配置，建议使用我们推荐的版本

`Tips: 内部域名不要修改，不要修改，不要修改，都是内部通信！！！！！！！！！ 不会真的有人不听劝？？？？ ？？？？`

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
export DEFAULT_DB_DBUSER='codo'
export DEFAULT_DB_DBPWD=${MYSQL_PASSWORD}
#export DEFAULT_DB_DBNAME=${mysql_database}

# 读数据库
export READONLY_DB_DBHOST='10.10.10.12'
export READONLY_DB_DBPORT='3306'
export READONLY_DB_DBUSER='codo'
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



**安装MySQL**

> 一般来说一个MySQL实例即可，如果有需求可以自行搭建主从，微服务每个服务都可以有自己的数据库

- 必须使用MySQL 5.7,我这个安装下来应该是mysql5.6
所以需要你改一下安装好的mysql配置文件


```shell
source /opt/codo/env.sh  #变量文件
yum install -y wget
wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
rpm -ivh mysql-community-release-el6-5.noarch.rpm
```


```shell
cat >/etc/yum.repos.d/mysql-community.repo <<EOF
[mysql-connectors-community]
name=MySQL Connectors Community
baseurl=http://repo.mysql.com/yum/mysql-connectors-community/el/6/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

[mysql-tools-community]
name=MySQL Tools Community
baseurl=http://repo.mysql.com/yum/mysql-tools-community/el/6/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

# Enable to use MySQL 5.5
[mysql55-community]
name=MySQL 5.5 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.5-community/el/6/$basearch/
enabled=0
gpgcheck=1
gpgkey=file:/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

# Enable to use MySQL 5.6
[mysql56-community]
name=MySQL 5.6 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.6-community/el/6/$basearch/
enabled=0
gpgcheck=1
gpgkey=file:/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

# Note: MySQL 5.7 is currently in development. For use at your own risk.
# Please read with sub pages: https://dev.mysql.com/doc/relnotes/mysql/5.7/en/
[mysql57-community-dmr]
name=MySQL 5.7 Community Server Development Milestone Release
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
EOF

```

```shell
yum install mysql-community-server -y
chkconfig mysqld on
service mysqld start
echo "info: start mysql grant user."
mysql -e "CREATE USER \"codo\"@\"localhost\"  IDENTIFIED BY  \"${MYSQL_PASSWORD}\";CREATE USER \"codo\"@\"%\"  IDENTIFIED BY  \"${MYSQL_PASSWORD}\"" 
mysql -e " GRANT ALL PRIVILEGES ON *.* TO \"codo\"@\"localhost\" IDENTIFIED BY \"${MYSQL_PASSWORD}\";GRANT ALL PRIVILEGES ON *.* TO \"codo\"@\"%\" IDENTIFIED BY \"${MYSQL_PASSWORD}\";GRANT ALL PRIVILEGES ON *.* TO \"codo\"@\"${HOSTNAME}\" IDENTIFIED BY  \"${MYSQL_PASSWORD}\"; " 2>&1
```
- 测试 `mysql -h127.0.0.1 -ucodo -p${MYSQL_PASSWORD}`

**安装Redis**

- 若有请跳过

```shell
yum install redis -y
source /opt/codo/env.sh  #变量文件
echo "requirepass ${REDIS_PASSWORD}" >> /etc/redis.conf
sed -i "s/^daemonize.*$/daemonize yes/g" /etc/redis.conf
#bind 127.0.0.1 如果是开启的请关闭掉
systemctl start redis
systemctl status redis
```
- 测试 `redis-cli -h 127.0.0.1 -p 6379 -a ${REDIS_PASSWORD}`


**安装RabbitMQ**

- 创建 docker-compose.yml

```shell
echo -e "\033[32m [INFO]: Start install rabbitmq \033[0m"
source /opt/codo/env.sh  #变量文件
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

- 注意，这里如果你内部有自己DNS，你也可以选择使用你自己的, 若没有请继续安装

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
source /opt/codo/env.sh  #变量文件
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

cat /etc/dnsmasqhosts #检查下

# 添加配置

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


**安装node环境**

```shell

#Q: 小伙伴们一定质疑我为什么python使用pm2进行守护,这玩意不是用node的嘛？
#A: supervisor用时间长了，就想尝试下pm2, emmmmmm.....
[ -f /usr/local/bin/node ] && echo "Node already exists" && exit -1
cd /usr/local/src && rm -rf node-v8.11.3-linux-x64.tar.xz
wget -q -c https://nodejs.org/dist/v8.11.3/node-v8.11.3-linux-x64.tar.xz
tar xf node-v8.11.3-linux-x64.tar.xz -C  /usr/local/ >/dev/null 2>&1
rm -rf /usr/local/bin/node
rm -rf /usr/local/bin/npm
ln -s /usr/local/node-v8.11.3-linux-x64/bin/node /usr/local/bin/node
ln -s /usr/local/node-v8.11.3-linux-x64/bin/node /usr/bin/node
ln -s /usr/local/node-v8.11.3-linux-x64/bin/npm  /usr/local/bin/npm
ln -s /usr/local/node-v8.11.3-linux-x64/bin/npm  /usr/bin/npm
/usr/local/bin/node -v
/usr/local/bin/npm -v
sudo npm i -g pm2 >/dev/null 2>&1
ln -s /usr/local/node-v8.11.3-linux-x64/bin/pm2 /usr/bin/

```

**安装websdk**
- websdk是自己实现的一套运维平台开发工具包，集成了很多方法在里面，此步骤是必要的

```shell
#前提环境是有python3 + pip3
pip3 install -U git+https://github.com/ss1917/ops_sdk.git
```


**以上，基础依赖部署完毕**



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

**生成配置**

> 本地部署方式采用pm2守护

```shell
cd /opt/codo/codo-admin/
cat >pm2.json<<EOF
{
  "apps": [{
    "name": "codo-admin-9800",
    "script": "python3 startup.py --service=mg --port=9800",
    "cwd": "/opt/codo/codo-admin/",
    "max_memory_restart": "150M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/admin.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },
{
    "name": "codo-admin-9801",
    "script": "python3 startup.py --service=mg --port=9801",
    "cwd": "/opt/codo/codo-admin/",
    "max_memory_restart": "150M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/admin.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },
{
    "name": "codo-admin-9802",
    "script": "python3 startup.py --service=mg --port=9802" ,
    "cwd": "/opt/codo/codo-admin/",
    "max_memory_restart": "150M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/admin.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },
{
    "name": "codo-admin-sub_log",
    "script": "python3 startup.py --service=sub_log --port=9803" ,
    "cwd": "/opt/codo/codo-admin/",
    "max_memory_restart": "150M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/admin_sub_log.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },

]}
EOF

```


**安装依赖**

```shell
pip3 install -r doc/requirements.txt
```

**创建数据库**

```shell
mysql -h127.0.0.1 -u${DEFAULT_DB_DBUSER} -p${MYSQL_PASSWORD} -e 'create database codo_admin default character set utf8mb4 collate utf8mb4_unicode_ci;'
```

**初始化表结构**

```
python3 db_sync.py
```



**导入数据**

主要是菜单，组件，权限列表，内置的用户等

```
#导入数据
mysql -h127.0.0.1 -u${DEFAULT_DB_DBUSER} -p${MYSQL_PASSWORD} codo_admin < ./doc/codo_admin_beta0.3.sql
```

**启动**

```
pm2 start pm2.json
```


**测试codo-admin**

```shell
#01.日志
tailf /var/log/supervisor/admin.log #确认没有报错
#02. 状态
pm2 list ; pm2 logs
```

**codo-admin 部署完毕**



## 资产管理

**获取代码**

```shell
echo -e "\033[32m [INFO]: codo_cmdb(资产管理) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-cmdb.git
cd codo-cmdb
```
**修改相关配置**

修改`settings.py`配置

```shell
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


#AWS事件和WebTerminnal配置
docker pull webterminal/webterminallte
docker run -itd -p 8080:80 webterminal/webterminallte
# Aws Events 事件邮件通知人
AWS_EVENT_TO_EMAIL = '1111@qq.com,2222@gmail.com'

#Web Terminal 地址，请填写你部署的webterminal地址
#注意这里是填写你上面docker run的机器外网IP
WEB_TERMINAL = 'http://1.1.1.1:8080'
```

**生成配置**

> 本地部署方式采用pm2守护

```shell
cat >pm2.json<<EOF
{
  "apps": [{
    "name": "codo-cmdb-9000",
    "script": "python3 startup.py --service=cmdb --port=9000",
    "cwd": "/opt/codo/codo-cmdb/",
    "max_memory_restart": "500M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/cmdb.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },
{
    "name": "codo-cmdb-9001",
    "script": "python3 startup.py --service=cmdb --port=9001",
    "cwd": "/opt/codo/codo-cmdb/",
    "max_memory_restart": "500M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/cmdb.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },
  {
    "name": "codo-cmdb-9002",
    "script": "python3 startup.py --service=cmdb --port=9002",
    "cwd": "/opt/codo/codo-cmdb/",
    "max_memory_restart": "500M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/cmdb.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },
  {
    "name": "codo-cmdb-cron",
    "script": "python3 startup.py --service=cmdb_cron",
    "cwd": "/opt/codo/codo-cmdb/",
    "max_memory_restart": "500M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/cmdb_cron.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },

]}
EOF

```


**安装依赖**

```shell
pip3 install -r doc/requirements.txt
```

**创建数据库**

```shell
mysql -h127.0.0.1 -u${DEFAULT_DB_DBUSER} -p${MYSQL_PASSWORD} -e 'create database codo_cmdb default character set utf8mb4 collate utf8mb4_unicode_ci;'
```

**初始化表结构**

```
python3 db_sync.py
```


**启动**

```
pm2 start pm2.json
```


**测试codo-cmdb**

```shell
#01.日志
tailf /var/log/supervisor/cmdb.log #确认没有报错
#02. 状态
pm2 list ; pm2 logs
```

**codo-cmdb 部署完毕**




## 任务系统
CODO任务系统，负责整个系统中任务调度，此功能是必须要安装的

**获取代码**

```shell
echo -e "\033[32m [INFO]: codo-task(任务系统) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-task.git
cd codo-task
```
**修改相关配置**

修改`settings.py`配置

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

**生成配置**

> 本地部署方式采用pm2守护，任务系统分别有执行任务和任务主服务程序，这里是单独分开的

- 注意：执行任务可使用`pm2 scale codo-task-exec_task +1 `进行横向扩展，开启的进程越多，则支持的并发任务则越多


```shell
#主服务程序
cat >pm2.json<<EOF
{
  "apps": [
    {
      "name": "codo-task-api-8900",
      "script": "python3 startup.py --service=task_api --port=8900",
      "cwd": "/opt/codo/codo-task/",
      "max_memory_restart": "150M",
      "log_date_format": "YYYY-MM-DD HH:mm Z",
      "log_file": "/var/log/supervisor/task.log",
      "autorestart": true,
      "node_args": [],
      "args": [],
      "env": {
      }
    },
    {
      "name": "codo-task-api-8901",
      "script": "python3 startup.py --service=task_api --port=8901",
      "cwd": "/opt/codo/codo-task/",
      "max_memory_restart": "150M",
      "log_date_format": "YYYY-MM-DD HH:mm Z",
      "log_file": "/var/log/supervisor/task.log",
      "autorestart": true,
      "node_args": [],
      "args": [],
      "env": {
      }
    },
    {
      "name": "codo-task-api-8902",
      "script": "python3 startup.py --service=task_api --port=8902",
      "cwd": "/opt/codo/codo-task/",
      "max_memory_restart": "150M",
      "log_date_format": "YYYY-MM-DD HH:mm Z",
      "log_file": "/var/log/supervisor/task.log",
      "autorestart": true,
      "node_args": [],
      "args": [],
      "env": {
      }
    },
    {
      "name": "codo-task-api-8903",
      "script": "python3 startup.py --service=task_api --port=8903",
      "cwd": "/opt/codo/codo-task/",
      "max_memory_restart": "150M",
      "log_date_format": "YYYY-MM-DD HH:mm Z",
      "log_file": "/var/log/supervisor/task.log",
      "autorestart": true,
      "node_args": [],
      "args": [],
      "env": {
      }
    },
    {
      "name": "codo-task-other-9600",
      "script": "python3 startup.py --service=other --port=9600",
      "cwd": "/opt/codo/codo-task/",
      "max_memory_restart": "150M",
      "log_date_format": "YYYY-MM-DD HH:mm Z",
      "log_file": "/var/log/supervisor/task_other.log",
      "autorestart": true,
      "node_args": [],
      "args": [],
      "env": {
      }
    },
    {
      "name": "codo-task-other-9601",
      "script": "python3 startup.py --service=other --port=9601",
      "cwd": "/opt/codo/codo-task/",
      "max_memory_restart": "150M",
      "log_date_format": "YYYY-MM-DD HH:mm Z",
      "log_file": "/var/log/supervisor/task_other.log",
      "autorestart": true,
      "node_args": [],
      "args": [],
      "env": {
      }
    },
    {
      "name": "codo-task-log-record",
      "script": "python3 startup.py --service=log_record --port=9608",
      "cwd": "/opt/codo/codo-task/",
      "max_memory_restart": "150M",
      "log_date_format": "YYYY-MM-DD HH:mm Z",
      "log_file": "/var/log/supervisor/task_log_record.log",
      "autorestart": true,
      "node_args": [],
      "args": [],
      "env": {
      }
    },
    {
      "name": "codo-task-cron",
      "script": "python3 startup.py --service=cron_app --port=9609",
      "cwd": "/opt/codo/codo-task/",
      "max_memory_restart": "150M",
      "log_date_format": "YYYY-MM-DD HH:mm Z",
      "log_file": "/var/log/supervisor/task_cron.log",
      "autorestart": true,
      "node_args": [],
      "args": [],
      "env": {
      }
    }
  ]
}

EOF

```
```shell
#exec_task进程
cat >exec_task.config.js<<EOF
module.exports = {
  apps : [{
    name: 'codo-task-exec_task',
    script: 'python3 startup.py --service=exec_task',
    // Options reference: https://pm2.io/doc/en/runtime/reference/ecosystem-file/
    args: '',
    instances: 15, // 启动15个进程,进程数=任务数
    autorestart: true,
    watch: false,
    max_memory_restart: '200M',
    log_date_format  : "YYYY-MM-DD HH:mm Z",
    log_file   : "/var/log/supervisor/exec_task.log",
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production'
    }
  }],
};

EOF

```


**安装依赖**

```shell
pip3 install -r doc/requirements.txt
```

**创建数据库**

```shell
mysql -h127.0.0.1 -u${DEFAULT_DB_DBUSER} -p${MYSQL_PASSWORD} -e 'create database codo_task default character set utf8mb4 collate utf8mb4_unicode_ci;'
```

**初始化表结构**

```
python3 db_sync.py
```


**启动**

```
pm2 start pm2.json
pm2 start exec_task.config.js
```


**测试codo-task**

```shell
#01.日志
tailf /var/log/supervisor/task.log #确认没有报错
tailf /var/log/supervisor/exec_task.log
tailf /var/log/supervisor/task_cron.log
#02. 状态
pm2 list ; pm2 logs
```

**codo-task 部署完毕**



## 定时任务
CODO项目定时任务模块，定时任务完全兼容crontab，支持到秒级

**获取代码**

```shell
echo -e "\033[32m [INFO]: codo_cron(定时任务) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-cron.git
cd codo-cron
```
**修改相关配置**

修改`settings.py`配置

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

**生成配置**

> 本地部署方式采用pm2守护

```shell
cat >pm2.json<<EOF
{
  "apps": [{
    "name": "codo-cron-9900",
    "script": "python3 startup.py --service=cron --port=9900",
    "cwd": "/opt/codo/codo-cron/",
    "max_memory_restart": "500M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/cron.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  }]
}
EOF
```


**安装依赖**

```shell
pip3 install -r doc/requirements.txt
```

**创建数据库**

```shell
mysql -h127.0.0.1 -u${DEFAULT_DB_DBUSER} -p${MYSQL_PASSWORD} -e 'create database codo_cron default character set utf8mb4 collate utf8mb4_unicode_ci;'
```

**初始化表结构**

```
python3 db_sync.py
```


**启动**

```
pm2 start pm2.json
```


**测试**

```shell
#01.日志
tailf /var/log/supervisor/cron.log #确认没有报错
#02. 状态
pm2 list ; pm2 logs
```

**codo-cron部署完毕**




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

**生成配置**

> 本地部署方式采用pm2守护

```shell
cat >pm2.json<<EOF
{
  "apps": [{
    "name": "codo-kerrigan-9100",
    "script": "python3 startup.py --service=kerrigan --port=9100",
    "cwd": "/opt/codo/kerrigan/",
    "max_memory_restart": "150M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/kerrigan.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },
{
    "name": "codo-kerrigan-9101",
    "script": "python3 startup.py --service=kerrigan --port=9101",
    "cwd": "/opt/codo/kerrigan/",
    "max_memory_restart": "500M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/kerrigan.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },
]}

EOF
```


**安装依赖**

```shell
pip3 install -r doc/requirements.txt
```

**创建数据库**

```shell
mysql -h127.0.0.1 -u${DEFAULT_DB_DBUSER} -p${MYSQL_PASSWORD} -e 'create database codo_kerrigan default character set utf8mb4 collate utf8mb4_unicode_ci;'
```

**初始化表结构**

```
python3 db_sync.py
```


**启动**

```
pm2 start pm2.json
```


**测试**

```shell
#01.日志
tailf /var/log/supervisor/kerrigan.log #确认没有报错
#02. 状态
pm2 list ; pm2 logs
```

**codo-kerrigan部署完成**




## 运维工具


**获取代码**

```shell
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-tools.git && cd codo-tools
```
**修改相关配置**

修改`settings.py`配置

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

**生成配置**

> 本地部署方式采用pm2守护

```shell
cat >pm2.json<<EOF
{
  "apps": [{
    "name": "codo-tools-9200",
    "script": "python3 startup.py --service=tools --port=9200",
    "cwd": "/opt/codo/codo-tools/",
    "max_memory_restart": "150M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/tools.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },
{
    "name": "codo-tools-9201",
    "script": "python3 startup.py --service=tools --port=9201",
    "cwd": "/opt/codo/codo-tools/",
    "max_memory_restart": "150M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/tools.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },
{
    "name": "codo-tools-cron",
    "script": "python3 startup.py --service=tools --port=9202" ,
    "cwd": "/opt/codo/codo-tools/",
    "max_memory_restart": "150M",
    "log_date_format"  : "YYYY-MM-DD HH:mm Z",
    "log_file"   : "/var/log/supervisor/tools_cron.log",
    "autorestart": true,
    "node_args": [],
    "args": [],
    "env": {
    }
  },

]}
EOF
```


**安装依赖**

```shell
pip3 install -r doc/requirements.txt
```

**创建数据库**

```shell
mysql -h127.0.0.1 -u${DEFAULT_DB_DBUSER} -p${MYSQL_PASSWORD} -e 'create database codo_tools default character set utf8mb4 collate utf8mb4_unicode_ci;'
```

**初始化表结构**

```
python3 db_sync.py
```


**启动**

```
pm2 start pm2.json
```


**测试**

```shell
#01.日志
tailf /var/log/supervisor/tools.log #确认没有报错
#02. 状态
pm2 list ; pm2 logs
```

**codo-tools部署完成**

## API网关
API网关系统,是基于openresty + Lua开发的一套API网关系统

**安装openresty**
```shell
# yum部署
yum update  #如果系统老建议update下
yum install yum-utils -y
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum install openresty -y
yum install openresty-resty -y
cd /opt/codo/ && git clone https://github.com/ss1917/api-gateway.git
\cp -arp api-gateway/* /usr/local/openresty/nginx/

```

**目录结构**
- 以下文件都是比较重要的，这个文件是手动自己创建的！
```
/usr/local/openresty/nginx/
├── conf
│   ├── conf.d
│   │   ├── admin.conf  //管理后台admin
│   │   ├── cmdb.conf   //资产管理
│   │   ├── demo.conf   //用户访问入口
│   │   ├── gw.conf    // 网关配置文件
│   │   ├── kerrigan.conf  //配置中心
│   │   ├── task.conf     //任务系统
│   │   └── tools.conf    //运维工具
├── lua
│   ├── configs.lua    //网关配置转发

```

**配置nginx**

- 这里主要修改resolver 内部DNS服务器地址

```
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
    lua_code_cache on;		#线上环境设置为on, off时可以热加载lua文件
    lua_shared_dict user_info 1m;
    lua_shared_dict my_limit_conn_store 100m;   #100M可以放1.6M个键值对
    include             mime.types;    #代理静态文件

    client_header_buffer_size 64k;
    large_client_header_buffers 4 64k;
    
    gzip on;
    gzip_min_length 1k;
    gzip_comp_level 2;
    gzip_types text/plain application/x-javascript text/css application/xml text/javascript;
    gzip_vary on;
    gzip_buffers 4 16k;
    gzip_http_version 1.1;

    init_by_lua_file lua/init_by_lua.lua;       # nginx启动时就会执行
    include ./conf.d/*.conf;                    # lua生成upstream
    resolver 10.10.10.12 ipv6=off;                      # 内部DNS
}

```

**配置vhosts**
以下内容是上面提到的所有vhost域名配置，这里面的配置都是和之前部署服务启动的端口一一对应起来的，若要修改，请也记得修改此处

`PATH: /usr/local/openresty/nginx/conf/conf.d`  

`admin.conf`
```
upstream  codo-admin{
    server  127.0.0.1:9800; 
    server  127.0.0.1:9801;
    server  127.0.0.1:9802;
}


server
{
        listen 80;
        server_name  mg.opendevops.cn;
        access_log /var/log/nginx/codo-admin_access.log;
        error_log  /var/log/nginx/codo-admin_error.log;
        location / {
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Scheme $scheme;
                proxy_set_header  Cookie $http_cookie;
                proxy_pass http://codo-admin;
        }
}

```

`cmdb.conf`
```
upstream  codo-cmdb{
    server  127.0.0.1:9000;
    server  127.0.0.1:9001;
    server  127.0.0.1:9002;
}


server
{
        listen 80;
        server_name  cmdb2.opendevops.cn;
        access_log /var/log/nginx/codo-cmdb_access.log;
        error_log  /var/log/nginx/codo-cmdb_error.log;
        location / {
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Scheme $scheme;
                proxy_set_header  Cookie $http_cookie;
                proxy_pass http://codo-cmdb;
        }
}
```

`kerrigan.conf`

```
upstream  codo-kerrigan{
    server  127.0.0.1:9100;
    server  127.0.0.1:9101;
}


server
{
        listen 80;
        server_name  kerrigan.opendevops.cn;
        access_log /var/log/nginx/codo-kerrigan_access.log;
        error_log  /var/log/nginx/codo-kerrigan_error.log;
        location / {
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Scheme $scheme;
                proxy_set_header  Cookie $http_cookie;
                proxy_pass http://codo-kerrigan;
        }
}

```

`task.conf`

```
upstream  codo-task{
    server  127.0.0.1:8900;
    server  127.0.0.1:8901;
    server  127.0.0.1:8902;
    server  127.0.0.1:8903;
}

upstream  task-other{
    server  127.0.0.1:9600;
    server  127.0.0.1:9601;
    server  127.0.0.1:9602;
}

server {
        listen 80;
        server_name task.opendevops.cn;
        location / {
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Scheme $scheme;
                proxy_pass http://codo-task;

        }
        location /ws/ {
                ### ws 支持
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";

                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Scheme $scheme;
                proxy_pass http://task-other;
        }
        location /other/ {
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Scheme $scheme;
                proxy_pass http://task-other;
        }
}

```

`tools.conf`

```
upstream  codo-tools{
    server  127.0.0.1:9200;
    server  127.0.0.1:9201;
}


server
{
        listen 80;
        server_name  tools.opendevops.cn;
        access_log /var/log/nginx/codo-tools_access.log;
        error_log  /var/log/nginx/codo-tools_error.log;
        location / {
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Scheme $scheme;
                proxy_set_header  Cookie $http_cookie;
                proxy_pass http://codo-tools;
        }
}
```

`cron.conf`

```
upstream  codo-cron{
    server  127.0.0.1:9900;
}


server
{
        listen 80;
        server_name  cron.opendevops.cn;
        access_log /var/log/nginx/codo-cron_access.log;
        error_log  /var/log/nginx/codo-cron_error.log;
        location / {
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Scheme $scheme;
                proxy_set_header  Cookie $http_cookie;
                proxy_pass http://codo-cron;
        }
}
```


`gw.conf`

```
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

`demo.conf`
- 前端访问入口,里面内容不需要更改，后面会将网站静态文件放到`/var/www/codo`

```
server {
        listen      80;
        server_name demo-init.opendevops.cn;
        access_log /var/log/nginx/codo-access.log;
        error_log  /var/log/nginx/codo-error.log;

        location / {
                    root /var/www/codo;
                    index index.html index.htm;
                    try_files $uri $uri/ /index.html;
                    expires 7d;
                    }

        location /api/ {
                proxy_redirect off;
                proxy_read_timeout 600;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

		add_header 'Access-Control-Allow-Origin' '*';
                proxy_pass http://gw.opendevops.cn;
        }
        location ~ /(.svn|.git|admin|manage|.sh|.bash)$ {
            return 403;
        }
    }
server {
      listen 80 default;
      server_name _;
      return 403;
}

```


**注册API网关**

> 请仔细阅读下面需要修改配置的地方`vim /usr/local/openresty/nginx/lua/configs.lua` 这个配置基本上都要修改，请务必仔细

```lua
json = require("cjson")


redis_config = {
    host = '10.10.10.12',
    port = 6379,
    auth_pwd = 'you_redis_passwd',
    db = 8,
    alive_time = 3600 * 24 * 7,
    channel = 'gw'
}

-- 注意：这里的token_secret必须要和codo-admin里面的token_secret保持一致
token_secret = "pXFb4i%*834gfdh963df718iodGq4dsafsdadg7yI6ImF1999aaG7"
logs_file = '/var/log/gw.log'

--刷新权限到redis接口
rewrite_cache_url = 'http://mg.opendevops.cn/v2/accounts/verify/'
-- 注意：rewrite_cache_token要和codo-admin里面的secret_key配置保持一致
rewrite_cache_token = '8b888a62-3edb-4920-b446-697a472b4001'

--并发限流配置
limit_conf = {
    rate = 10, --限制ip每分钟只能调用n*60次接口
    burst = 10, --桶容量,用于平滑处理,最大接收请求次数
}

--upstream匹配规则
gw_domain_name = 'gw.opendevops.cn'
-- 不用再担心域名对应的接口了，建议内部的域名无需更改，只改简单的即可了，反正都是内部通信
rewrite_conf = {
    [gw_domain_name] = {
        rewrite_urls = {
            {
                uri = "/cmdb2",
                rewrite_upstream = "cmdb2.opendevops.cn"
            },
            {
                uri = "/tools",
                rewrite_upstream = "tools.opendevops.cn"
            },
            {
                uri = "/kerrigan",
                rewrite_upstream = "kerrigan.opendevops.cn"
            },
            {
                uri = "/task",
                rewrite_upstream = "task.opendevops.cn"
            },
            {
                uri = "/cron",
                rewrite_upstream = "cron.opendevops.cn"
            },
            {
                uri = "/mg",
                rewrite_upstream = "mg.opendevops.cn"
            },
            {
                uri = "/accounts",
                rewrite_upstream = "mg.opendevops.cn"
            },
        }
    }
}
```



**测试启动**
```shell
#access/error log path
mkdir -p /var/log/nginx/

#测试
$ openresty -t
nginx: the configuration file /usr/local/openresty/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/openresty/nginx/conf/nginx.conf test is successful

#启动
systemctl start openresty
systemctl status openresty

```

## 项目前端

**生成最新的前端**
```shell
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi

#下载前端代码、进到项目目录执行build
[ ! -d /opt/codo/codo ] && mkdir -p /opt/codo/ &&  cd /opt/codo &&  git clone https://github.com/opendevops-cn/codo.git  &&  cd codo

#build 最新的前端文件
#这里很多人慢的话都是因为网络不好，建议换成淘宝的源试试！
npm config set registry https://registry.npmjs.org/ \
&& npm cache clean --force \
&& npm install --ignore-script \
&& npm run build

#网站目录
mkdir -p /var/www/codo
\cp -rp dist/* /var/www/codo/

#API文档(如果你需要)
cd /opt/codo/codo
\cp -r swagger-ui/ /var/www/codo/

```

**配置代理**

- 将静态文件代理出来，我这里使用API网关的openresty进行统一代理所有nginx域名

`/usr/local/openresty/nginx/conf/conf.d/demo.conf` 已配置

### 访问

- 地址：demo-init.opendevops.cn
- 用户：admin
- 密码：admin@opendevops

### 日志路径

- 若这里访问有报错，请看下日志，一般都是配置错误。
- 日志路径：所有模块日志统一/var/log/supervisor/
- 也可以`pm2 logs -f xxxx`

### 健康检查

```shell
# 进行所有服务进行检测，返回200则正常
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://mg.opendevops.cn/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://task.opendevops.cn/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://cmdb2.opendevops.cn/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://kerrigan.opendevops.cn/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://cron.opendevops.cn/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://tools.opendevops.cn/are_you_ok/
.....
```



### 问题记录

```
Q: openresty -t
nginx: [emerg] host not found in upstream "gw.opendevops.cn" in /usr/local/openresty/nginx/conf/./conf.d/demo.conf:23
nginx: configuration file /usr/local/openresty/nginx/conf/nginx.conf test failed

A: 这里一般都是dns解析不到，如果你是用了内部自己的DNS 请确保都已经添加了解析
如果你是按照文档部署的本地DNS，请确保你`cat /etc/resolv.conf`中的`nameserver xxxx`为你自己的IP


Q: 部署完后直接IP访问403
A：因为是用的nginx vhosts 需要进行解析域名的。
- 临时测试方法：
如果你是Windows，修改`C:\Windows\System32\drivers\etc\hosts`Hosts记录访问测试
如果你是Mac用户，直接sudo vim /etc/hosts  绑定解析即可
```
