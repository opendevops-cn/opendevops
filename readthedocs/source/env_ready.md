### 环境准备

> 部署安装之前，你应该了解下每个模块的用途 > [传送门](http://docs.opendevops.cn/zh/latest/introduction.html)

**部署视频**
> 近期有部分同学反应说部署太麻烦了，为什么不做成一个Docker，其实我们这里单项目已经是Docker部署了，为了更好的让用户更快的了解我们的平台，我们准备了部署视频，[视频入口](https://www.bilibili.com/video/av53446517?from=search&seid=16003251072301252333)


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