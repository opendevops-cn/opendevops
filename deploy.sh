#!/usr/bin/env bash
# @Time    : 01/14/2019 4:00 PM
# @Author  : Fred Yang
# @File    : deploy.py
# @Role    : 脚本安装CODO

echo -ne "\\033[0;33m"
cat<<EOT
                                  _oo0oo_
                                 088888880
                                 88" . "88
                                 (| -_- |)
                                  0\\ = /0
                               ___/'---'\\___
                             .' \\\\\\\\|     |// '.
                            / \\\\\\\\|||  :  |||// \\\\
                           /_ ||||| -:- |||||- \\\\
                          |   | \\\\\\\\\\\\  -  /// |   |
                          | \\_|  ''\\---/''  |_/ |
                          \\  .-\\__  '-'  __/-.  /
                        ___'. .'  /--.--\\  '. .'___
                     ."" '<  '.___\\_<|>_/___.' >'  "".
                    | | : '-  \\'.;'\\ _ /';.'/ - ' : | |
                    \\  \\ '_.   \\_ __\\ /__ _/   .-' /  /
                ====='-.____'.___ \\_____/___.-'____.-'=====
                                  '=---='


              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                建议系统                    CentOS7
                建议配置                    2Core4G
                建议磁盘                    >=50G
             PS：请尽量使用纯净的CentOS7系统，我们会在服务器安装
    [python3.6、Node、Openresty、MySQL57、Redis3、Dnsmasq、Docker、RabbitMQ]
注意：一键部署不包含K8S组件模块，前端访问k8s相关会出现404错误，请无视，线上环境建议一步步分布式安装。

EOT
echo -ne "\\033[m"

# 环境变量
env_file='env.sh'
[ ! -f $env_file ] && echo -e "\033[31m [ERROR]: $env_file Not Found! \033[0m"  && exit -404
source ./$env_file

if [ ! -f 'data.sql' ];then
    echo -e "\033[31m [ERROR]: data.sql Not Found, Unable to initialize data! \033[0m"  && exit -404
fi
# 安装基础依赖
echo -e "\033[32m [INFO]: Install the base dependencies, here yum update will be time consuming \033[0m"
yum install epel-release -y >/dev/null 2>&1 && yum install wget unzip epel-release  xz gcc automake zlib-devel openssl-devel supervisor mysql net-tools  groupinstall development  libxslt-devel libxml2-devel libcurl-devel git -y >/dev/null 2>&1


# 安装Python3
function python3(){
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
}

# 安装Docker-compose
function docker_compose(){
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
}


# 安装MYSQL57
function mysql57(){
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
#客户端测试一下子
# yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
# yum -y install Percona-Server-client-56
}

function init_mysql(){
#初始化数据库
cd /opt/codo/opendevops/
source ./env.sh
sleep 3s
mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} < data.sql
if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: init_mysql success. \033[0m"
else
    echo -e "\033[31m [ERROR]: init_mysql faild \033[0m"
    echo "mysql -h127.0.0.1 -uroot -p${MYSQL_PASSWORD} < data.sql"
    exit -500
fi

}


# 安装redis
function redis3(){
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
}


# 安装RabbitMQ
function rabbitmq(){
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
}

# 安装DNS
#部署内部DNS dnsmasq 主要用于内部通信。
function dnsmasq(){
echo -e "\033[32m [INFO]: Start install dnsmasq \033[0m"
#install dnsmasq
yum install dnsmasq -y

# 设置上游DNS
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
echo "nameserver $LOCALHOST_IP" > /etc/resolv.conf   #需要将本机DNS改成自己，不然没办法访问以上mg.cron,cmdb等内网域名
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


}

#安装Node
function node_install(){
echo -e "\033[32m [INFO]: Start install Node \033[0m"
# [ -f /usr/local/bin/node ] && echo "Node already exists" && exit -1
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
if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: Node install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: Node install faild \033[0m"
    exit -7
fi
}

#项目前端
function codo(){
echo -e "\033[32m [INFO]: codo(项目前端) Start install. \033[0m"
codo_version='https://github.com/opendevops-cn/codo/releases/download/codo-beta-0.1.0/codo-beta-0.1.0.tar.gz'
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
[ ! -d /var/www ] && mkdir -p /var/www
cd /var/www && wget $codo_version
tar zxf codo-beta-0.1.0.tar.gz
if [ $? == 0 ];then
    echo -e "\033[32m [INFO]: codo(项目前端) install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: codo(项目前端) install faild \033[0m"
    exit -8
fi
}

#项目后端
function codo_admin(){
echo -e "\033[32m [INFO]: codo-admin(项目后端) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-admin.git
cd codo-admin
#初始化数据
DEFAULT_DB_DBNAME='codo_admin'   #项目后端数据库
 #后端数据库名称
mysql -h 127.0.0.1 -u root -p${MYSQL_PASSWORD} -e "create database ${DEFAULT_DB_DBNAME} default character set utf8mb4 collate utf8mb4_unicode_ci;"
# mysql -h 127.0.0.1 -u root -p${MYSQL_PASSWORD} < doc/data.sql
#修改配置
sed -i  "s#server_name .*#server_name ${mg_domain};#g" doc/nginx_ops.conf
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py
sed -i "s#token_secret = .*#token_secret = '${token_secret}'#g" settings.py
#mysql配置
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" settings.py
#只读MySQL配置
sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" settings.py
sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" settings.py
sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" settings.py
sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" settings.py
sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" settings.py
#redis配置
sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" settings.py
#删除没必要的目录映射
name=/var/www
sed -i 's#'$name'#EXCLUSIVE#;/EXCLUSIVE/d' docker-compose.yml

#bulid 镜像
docker build . -t do_mg_image
#启动
docker-compose up -d
#检查状态
sleep 3s
mg_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://$mg_domain:8010/are_you_ok/`

if [ $mg_status == 200 ];then
    echo -e "\033[32m [INFO]: codo(项目后端) install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: codo(项目后端) install faild \033[0m"
    exit -9
fi
}



#任务系统
function codo_task(){
echo -e "\033[32m [INFO]: codo-task(任务系统) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-task.git
cd codo-task

#修改配置
TASK_DB_DBNAME='codo_task'
 #后端数据库名称
mysql -h 127.0.0.1 -u root -p${MYSQL_PASSWORD} -e "create database ${TASK_DB_DBNAME} default character set utf8mb4 collate utf8mb4_unicode_ci;"


sed -i  "s#server_name .*#server_name ${task_domain};#g" doc/nginx_ops.conf
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py
sed -i "s#token_secret = .*#token_secret = '${token_secret}'#g" settings.py
#mysql配置
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
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

#删除没必要的目录映射
#这是测试用到的，先删除掉
name=/var/www
sed -i 's#'$name'#EXCLUSIVE#;/EXCLUSIVE/d' docker-compose.yml
name_test=/var/www/task_scheduler/db_sync.py
sed -i 's#'$name_test'#EXCLUSIVE02#;/EXCLUSIVE02/d' Dockerfile

#编译镜像
docker build . -t task_scheduler_image
#启动
docker-compose up -d
#检查状态
sleep 3s
task_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://$task_domain:8020/are_you_ok/`

if [ $task_status == 200 ];then
    echo -e "\033[32m [INFO]: codo(任务系统) install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: codo(任务系统) install faild \033[0m"
    exit -9
fi

}



#定时任务
function codo_cron(){
echo -e "\033[32m [INFO]: codo_cron(定时任务) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-cron.git
cd codo-cron

#修改配置
CRON_DB_DBNAME='codo_cron'
 #后端数据库名称
mysql -h 127.0.0.1 -u root -p${MYSQL_PASSWORD} -e "create database ${CRON_DB_DBNAME} default character set utf8mb4 collate utf8mb4_unicode_ci;"

sed -i  "s#server_name .*#server_name ${task_domain};#g" doc/nginx_ops.conf
sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" settings.py
sed -i "s#token_secret = .*#token_secret = '${token_secret}'#g" settings.py
#mysql配置
sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" settings.py
sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" settings.py
sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${CRON_DB_DBNAME}')#g" settings.py
#只读MySQL配置
sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" settings.py
sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" settings.py
sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" settings.py
sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" settings.py
sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${CRON_DB_DBNAME}')#g" settings.py
#redis配置
sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" settings.py
sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" settings.py

#删除没必要的目录映射
#这是测试用到的，先删除掉
name=/var/www
sed -i 's#'$name'#EXCLUSIVE#;/EXCLUSIVE/d' docker-compose.yml
name_test=/var/www/do_cron/db_sync.py
sed -i 's#'$name_test'#EXCLUSIVE02#;/EXCLUSIVE02/d' Dockerfile

#编译镜像
docker build . -t do_cron_image

#启动
docker-compose up -d
sleep 3s
cron_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://$LOCALHOST_IP:9900/are_you_ok/`

if [ $task_status == 200 ];then
    echo -e "\033[32m [INFO]: codo(定时任务) install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: codo(定时任务) install faild \033[0m"
    exit -9
fi

}


#CMDB
function codo_cmdb(){
echo -e "\033[32m [INFO]: codo_cmdb(资产管理) Start install. \033[0m"
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo && git clone https://github.com/opendevops-cn/codo-cmdb.git
cd codo-cmdb

#修改配置
CMDB_DB_DBNAME='codo_cmdb'
 #后端数据库名称
mysql -h 127.0.0.1 -u root -p${MYSQL_PASSWORD} -e "create database ${CMDB_DB_DBNAME} default character set utf8mb4 collate utf8mb4_unicode_ci;"
mysql -h 127.0.0.1 -u root -p${MYSQL_PASSWORD}  $CMDB_DB_DBNAME < docs/cmdb.sql


#修改配置
sed -i  "s#server_name .*#server_name ${cmdb_domain};#g" docs/nginx_cmdb.conf
cat > cmdb-example.conf <<EOF
[base]
ip = 0.0.0.0
port = 8000
debug = True

[db]
host = ${READONLY_DB_DBHOST}
port = ${DEFAULT_DB_DBPORT}
dbname = ${CMDB_DB_DBNAME}
username = ${DEFAULT_DB_DBUSER}
password = ${DEFAULT_DB_DBPWD}

[storage]
api_url = http://${api_gw_url}/mg/v2/sysconfig/settings/STORAGE/

[ssh]
public_key = /root/.ssh/id_rsa.pub
EOF

#这是测试用到的，先删除掉
name=/var/www
sed -i 's#'$name'#EXCLUSIVE#;/EXCLUSIVE/d' docker-compose.yml

#编译镜像
docker build . -t cmdb

#启动
docker-compose up -d

sleep 3s
cmdb_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://${cmdb_domain}:8002/v1/cmdb/`
if [ $cmdb_status == 200 ];then
    echo -e "\033[32m [INFO]: codo(CMDB) install success. \033[0m"
else
    echo -e "\033[31m [ERROR]: codo(CMDB) install faild \033[0m"
    exit -10
fi

}


#API网关
function api_gateway(){
echo -e "\033[32m [INFO]: api_gateway(API网关) Start install. 使用端口：80， 请确保端口没被使用。\033[0m"
yum install yum-utils -y
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum install openresty -y
yum install openresty-resty -y
if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
if ! which git &>/dev/null; then yum install -y git >/dev/null 2>&1;fi
[ ! -d /opt/codo/ ] && mkdir -p /opt/codo
cd /opt/codo/ && git clone https://github.com/ss1917/api-gateway.git
\cp -arp api-gateway/* /usr/local/openresty/nginx/

#修改配置

#修改nginx全局配置
sed -i  "s#resolver .*#resolver ${LOCALHOST_IP};#g" /usr/local/openresty/nginx/conf/nginx.conf
# cat /usr/local/openresty/nginx/conf/nginx.conf
# user root;
# worker_processes auto;
# worker_rlimit_nofile 51200;
# error_log logs/error.log;
# events {
#     use epoll;
#     worker_connections 51024;
# }
# http {
#     #设置默认lua搜索路径
#     lua_package_path '$prefix/lua/?.lua;/blah/?.lua;;';
#     lua_code_cache on;      #线上环境设置为on, off时可以热加载lua文件
#     lua_shared_dict user_info 1m;
#     lua_shared_dict my_limit_conn_store 100m;   #100M可以放1.6M个键值对
#     include             mime.types;    #代理静态文件

#     client_header_buffer_size 64k;
#     large_client_header_buffers 4 64k;

#     init_by_lua_file lua/init_by_lua.lua;       # nginx启动时就会执行
#     include ./conf.d/*.conf;                    # lua生成upstream
#     resolver 10.10.10.12;                       # 内部DNS服务器地址
# }
#网关hosts
sed -i  "s#server_name .*#server_name ${api_gw_url};#g" /usr/local/openresty/nginx/conf/conf.d/gw.conf
# cat  /usr/local/openresty/nginx/conf/conf.d/gw.conf
#     server {
#         listen 80;
#         server_name gw.yanghongfei.me;
#         lua_need_request_body on;           # 开启获取body数据记录日志

#         location / {
#             ### ws 支持
#             proxy_http_version 1.1;
#             proxy_set_header Upgrade $http_upgrade;
#             proxy_set_header Connection "upgrade";

#             ### 获取真实IP
#             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

#             access_by_lua_file lua/access_check.lua;
#             set $my_upstream $my_upstream;
#             proxy_pass http://$my_upstream;

#             ### 跨域
#             add_header Access-Control-Allow-Methods *;
#             add_header Access-Control-Max-Age 3600;
#             add_header Access-Control-Allow-Credentials true;
#             add_header Access-Control-Allow-Origin $http_origin;
#             add_header Access-Control-Allow-Headers $http_access_control_request_headers;
#             if ($request_method = OPTIONS){
#                 return 204;}
#         }
#     }


#demo访问入口配置,前端
[ ! -d /var/log/nginx ] && mkdir -p /var/log/nginx
cat >/usr/local/openresty/nginx/conf/conf.d/demo.conf<<\EOF
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
                ### ws 支持
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
EOF
sed -i  "s#server_name .*#server_name ${front_domain};#g" /usr/local/openresty/nginx/conf/conf.d/demo.conf
sed -i  "s#proxy_pass .*#proxy_pass http://${api_gw_url};#g" /usr/local/openresty/nginx/conf/conf.d/demo.conf

#最后API网关注册配置，只要修改config.lua文件

cat >/usr/local/openresty/nginx/lua/configs.lua<<EOF
json = require("cjson")

--mysql_config = {
--    host = "127.0.0.1",
--    port = 3306,
--    database = "lua",
--    user = "root",
--    password = "",
--    max_packet_size = 1024 * 1024
--}

redis_config = {
    host = '${DEFAULT_REDIS_HOST}',
    --host = '172.16.0.121',
    port = ${DEFAULT_REDIS_PORT},
    auth_pwd = '${DEFAULT_REDIS_PASSWORD}',
    db = 8,
    alive_time = 3600 * 24 * 7,
    channel = 'gw'
}

--mq_conf = {
--  host = '172.16.0.121',
--  port = 5672,
--  username = 'sz',
--  password = '123456',
--  vhost = '/'
--}

token_secret = "${token_secret}"
logs_file = '/var/log/gw.log'

--刷新权限到redis接口
rewrite_cache_url = 'http://${mg_domain}:8010/v2/accounts/verify/'
rewrite_cache_token = '8b888a62-3edb-4920-b446-697a472b4001'

--并发限流配置
limit_conf = {
    rate = 10, --限制ip每分钟只能调用n*60次接口
    burst = 10, --桶容量,用于平滑处理,最大接收请求次数
}

--upstream匹配规则
gw_domain_name = '${api_gw_url}'

rewrite_conf = {
    [gw_domain_name] = {
        rewrite_urls = {
            {
                uri = "/cmdb",
                rewrite_upstream = "${cmdb_domain}:8002"
            },
            {
                uri = "/task",
                rewrite_upstream = "${task_domain}:8020"
            },
            {
                uri = "/cron",
                rewrite_upstream = "${LOCALHOST_IP}:9900"
            },
            {
                uri = "/mg",
                rewrite_upstream = "${mg_domain}:8010"
            },
            {
                uri = "/accounts",
                rewrite_upstream = "${mg_domain}:8010"
            },
        }
    }
}

EOF


#检测是否有报错
openresty -t
systemctl start openresty.service
systemctl status openresty.service
systemctl enable openresty.service
}



export -f python3
export -f docker_compose
export -f mysql57
export -f redis3
export -f rabbitmq
export -f dnsmasq
export -f node_install
export -f codo
export -f codo_admin
export -f codo_task
export -f codo_cron
export -f codo_cmdb
export -f api_gateway


#开始安装
[ -f /usr/local/bin/python3 ] && echo -e "\033[33m [Warning]: Python3 already exists,Skip installation \033[0m"  || python3
[ -f /usr/local/bin/docker-compose ] && echo -e "\033[33m [Warning]: Docker-compose already exists,Skip installation \033[0m"  || docker_compose
check_mysql_active=`netstat -ntlp | grep "3306" | wc -l`
[[ $check_mysql_active != 0 ]] && echo -e "\033[33m [Warning]: MySQL already exists,Skip installation \033[0m" || mysql57
init_mysql
[ -f /usr/bin/redis-server ] && echo -e "\033[33m [Warning]: Redis already exists,Skip installation \033[0m"  || redis3
[ -f /usr/sbin/rabbitmq-server ] && echo -e "\033[33m [Warning]: Rabbitmq already exists,Skip installation \033[0m"  || rabbitmq
[ -f /etc/dnsmasqhosts ] && echo -e "\033[33m [Warning]: Dnsmasq already exists,Skip installation \033[0m"  || dnsmasq
#[ -f /usr/local/bin/node ] && echo -e "\033[33m [Warning]: None already exists,Skip installation \033[0m"  || node_install
[ -d /var/www/codo/ ] && echo -e "\033[33m [Warning]: 项目前端:/var/www/codo/ already exists,Skip installation \033[0m"  || codo
mg_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://$mg_domain:8010/are_you_ok/`
[ $mg_status = 200 ] && echo -e "\033[33m [Warning]: 项目后端 already exists,Skip installation \033[0m" || codo_admin
task_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://$task_domain:8020/are_you_ok/`
[ $task_status = 200 ] && echo -e "\033[33m [Warning]: 任务系统 already exists,Skip installation \033[0m" || codo_task
cron_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://${cron_domain}:9900/are_you_ok/`
[ $cron_status = 200 ] && echo -e "\033[33m [Warning]: 定时任务 already exists,Skip installation \033[0m" || codo_cron
cmdb_status=`curl -I -X GET -m  10 -o /dev/null -s -w %{http_code}  http://${cmdb_domain}:8002/v1/cmdb/`
[ $cmdb_status = 200 ] && echo -e "\033[33m [Warning]: CMDB already exists,Skip installation \033[0m" || codo_cmdb
#openresty也是使用的80端口
#check_port=`netstat -tlpn | grep "\b80\b"`
#[ $check_port ==0 ] &&  echo -e "\033[33m [Warning]:  API网关Server port:80 is already occupied,Skip installation，请确认再次安装 \033[0m"  ||
#安装API网关
api_gateway

echo -e "\033[32m [INFO]: 初始用户：admin  初始密码：admin@opendevops\033[0m"
echo -e "\033[32m [INFO]: 日志目录：/var/log/supervisor/, 详细可查看日志log是否有报错。 \033[0m"
