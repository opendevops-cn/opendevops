### 环境准备

**初始化环境变量**

> 请根据自己环境修改以下变量地址，后续平台里面调用需要使用到。

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

**安装Python3**
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

**安装Docker-compose**
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

**安装MySQL**
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

**安装Redis**
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


**安装RabbitMQ**
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

**安装DNS**
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


