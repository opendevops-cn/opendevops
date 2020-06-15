

################Mysql 容器启动时候的变量#########################
MYSQL_ROOT_PASSWORD="m9uSFL7duAVXfeAwGUSGroot"

######################################################


################RabbitMQ 容器启动时候的变量#####################
RABBITMQ_DEFAULT_USER="ss"
RABBITMQ_DEFAULT_PASS="5Q2ajBHRT2lFJjnvaU0g"
#####################################################


############### codo-mg 服务使用变量 #############
secret_key="8b888a62-3edb-4920-b446-697a472b4001"
#################################################

############### Api-gatewat 服务专用变量##########
#### 管理后端地址
mg_domain="codo-admin"

### 定时任务地址,目前只启动一个进程，不用域名，直接IP即可
cron_domain="codo-cron"

### 任务系统地址
task_domain="codo-task"

### CMDB系统地址
cmdb_domain="codo-cmdb"

### 运维工具地址
tools_domain="codo-tools"

### 域名管理地址
dns_domain="codo-dns"

### 配置中心域名
kerrigan_domain="codo-kerrigan"

### 前端地址,也就是你的访问地址
front_domain="codo-frontend"

### api网关地址
api_gw_url="codo-gateway"

### k8s管理服务域名
k8s_domain="codo-k8s"

###################################################



#######################所有服务共用变量####################
#本机的IP地址
LOCALHOST_IP="127.0.0.1"

#设置你的MYSQL密码
MYSQL_PASSWORD="${MYSQL_ROOT_PASSWORD}"

### 设置你的redis密码,需要和docker-compose中的密码一致
REDIS_PASSWORD="cWCVKJ7ZHUK12mVbivUf"

### 应用连接RabbitMQ需要的用户密码信息
MQ_USER=${RABBITMQ_DEFAULT_USER}
MQ_PASSWORD=${RABBITMQ_DEFAULT_PASS}

# 这里codo-admin和gw网关都会用到，一定要修改。可生成随意字符
token_secret="pXFb4i%*834gfdh963df718iodGq4dsafsdadg7yI6ImF1999aaG7"

#codo-admin用到的cookie和token，可留默认
cookie_secret="nJ2oZis0V/xlArY2rzpIE6ioC9/KlqR2fd59sD=UXZJ=3OeROB"

##如果要进行读写分离，Master-slave主从请自行建立，一般情况下都是只用一个数据库就可以了
# 写数据库
DEFAULT_DB_DBHOST="codo-mysql"
DEFAULT_DB_DBPORT='3306'
DEFAULT_DB_DBUSER='root'
DEFAULT_DB_DBPWD=${MYSQL_PASSWORD}
#DEFAULT_DB_DBNAME=${mysql_database}

# 读数据库
READONLY_DB_DBHOST='codo-mysql'
READONLY_DB_DBPORT='3306'
READONLY_DB_DBUSER='root'
READONLY_DB_DBPWD=${MYSQL_PASSWORD}
#READONLY_DB_DBNAME=${mysql_database}

# 消息队列
DEFAULT_MQ_ADDR='codo-rabbitmq'
DEFAULT_MQ_USER=${MQ_USER}
DEFAULT_MQ_PWD=${MQ_PASSWORD}

# 缓存
DEFAULT_REDIS_HOST='codo-redis'
DEFAULT_REDIS_PORT=6379
DEFAULT_REDIS_PASSWORD=${REDIS_PASSWORD}
#########################################################
