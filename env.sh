##h环境变量文件

#本机的IP地址
export LOCALHOST_IP="172.16.1.201"

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
export cron_domain="172.16.1.201"

### 任务系统地址
export task_domain="task.opendevops.cn"

### CMDB系统地址
export cmdb_domain="cmdb.opendevops.cn"

### 运维工具地址
export tools_domain="tools.opendevops.cn"


### 配置中心域名
export kerrigan_domain="kerrigan.opendevops.cn"

### 前端地址,也就是你的访问地址
export front_domain="demo.opendevops.cn"

### api网关地址
export api_gw_url="gw.opendevops.cn"


#codo-admin用到的cookie和token，可留默认
export cookie_secret="nJ2oZis0V/xlArY2rzpIE6ioC9/KlqR2fd59sD=UXZJ=3OeROB"
export token_secret="1txIq2QUkeFsZizt3vEpVzUQNFS2@DpEQwbbw8k0YJt0biFScH"

##如果要进行读写分离，Master-slave主从请自行建立，一般情况下都是只用一个数据库就可以了
# 写数据库
export DEFAULT_DB_DBHOST="172.16.1.201"
export DEFAULT_DB_DBPORT='3306'
export DEFAULT_DB_DBUSER='root'
export DEFAULT_DB_DBPWD=${MYSQL_PASSWORD}
#export DEFAULT_DB_DBNAME=${mysql_database}

# 读数据库
export READONLY_DB_DBHOST='172.16.1.201'
export READONLY_DB_DBPORT='3306'
export READONLY_DB_DBUSER='root'
export READONLY_DB_DBPWD=${MYSQL_PASSWORD}
#export READONLY_DB_DBNAME=${mysql_database}

# 消息队列
export DEFAULT_MQ_ADDR='172.16.1.201'
export DEFAULT_MQ_USER=${MQ_USER}
export DEFAULT_MQ_PWD=${MQ_PASSWORD}

# 缓存
export DEFAULT_REDIS_HOST='172.16.1.201'
export DEFAULT_REDIS_PORT=6379
export DEFAULT_REDIS_PASSWORD=${REDIS_PASSWORD}
