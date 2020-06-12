function download_settings(){
  echo -e "\033[32m [INFO]: 开始下载个项目的配置文件 \033[0m"
  #下载配置文件
  #管理后端
  if [[ ! -f codo-admin-settings.py ]];then
    curl -o codo-admin-settings.py https://raw.githubusercontent.comn/codo-admin/master/settings.py
  fi
  #任务系统
  if [[ ! -f codo-task-settings.py ]];then
  curl -o codo-task-settings.py https://raw.githubusercontent.comn/codo-task/master/settings.py
  fi
  #资产管理
  if [[ ! -f codo-cmdb-settings.py ]];then
  curl -o codo-cmdb-settings.py https://raw.githubusercontent.comn/codo-cmdb/master/settings.py
  fi

  #定时任务
  if [[ ! -f codo-cron-settings.py ]];then
  curl -o codo-cron-settings.py https://raw.githubusercontent.comn/codo-cron/master/settings.py
  fi

  #配置中心
  if [[ ! -f kerrigan-settings.py ]];then
  curl -o kerrigan-settings.py  https://raw.githubusercontent.comn/kerrigan/master/settings.py
  fi

  #运维工具
  if [[ ! -f codo-tools-settings.py ]];then
  curl -o codo-tools-settings.py https://raw.githubusercontent.comn/codo-tools/master/settings.py
  fi

  #域名管理
  if [[ ! -f codo-dns-settings.py ]];then
  curl -o codo-dns-settings.py https://raw.githubusercontent.comn/codo-dns/master/settings.py
  fi
}


function update_settings(){
  #修改settings配置
  #管理后端-admin
  echo -e "\033[32m [INFO]: 开始修改各项目的配置文件 \033[0m"
  source /opt/codo/env.sh
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-admin-settings.py
  sed -i "s#token_secret = .*#token_secret = '${token_secret}'#g" codo-admin-settings.py
  DEFAULT_DB_DBNAME='codo_admin'
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" codo-admin-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" codo-admin-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" codo-admin-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" codo-admin-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" codo-admin-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" codo-admin-settings.py
  sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" codo-admin-settings.py

  #任务系统-task
  TASK_DB_DBNAME='codo_task'
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-task-settings.py
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${TASK_DB_DBNAME}')#g" codo-task-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" codo-task-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" codo-task-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" codo-task-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" codo-task-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${TASK_DB_DBNAME}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_MQ_ADDR = .*#DEFAULT_MQ_ADDR = os.getenv('DEFAULT_MQ_ADDR', '${DEFAULT_MQ_ADDR}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_MQ_USER = .*#DEFAULT_MQ_USER = os.getenv('DEFAULT_MQ_USER', '${DEFAULT_MQ_USER}')#g" codo-task-settings.py
  sed -i "s#DEFAULT_MQ_PWD = .*#DEFAULT_MQ_PWD = os.getenv('DEFAULT_MQ_PWD', '${DEFAULT_MQ_PWD}')#g" codo-task-settings.py

  #资产管理-cmdb
  CMDB_DB_DBNAME='codo_cmdb'
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${CMDB_DB_DBNAME}')#g" codo-cmdb-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" codo-cmdb-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" codo-cmdb-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" codo-cmdb-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" codo-cmdb-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${CMDB_DB_DBNAME}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" codo-cmdb-settings.py
  sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" codo-cmdb-settings.py
  # 同步TAG树
  sed -i "s#CODO_TASK_DB_HOST = .*#CODO_TASK_DB_HOST = os.getenv('CODO_TASK_DB_HOST', '${DEFAULT_DB_DBHOST}')#g" codo-cmdb-settings.py
  sed -i "s#CODO_TASK_DB_PORT = .*#CODO_TASK_DB_PORT = os.getenv('CODO_TASK_DB_PORT', '${DEFAULT_DB_DBPORT}')#g" codo-cmdb-settings.py
  sed -i "s#CODO_TASK_DB_USER = .*#CODO_TASK_DB_USER = os.getenv('CODO_TASK_DB_USER', '${DEFAULT_DB_DBUSER}')#g" codo-cmdb-settings.py
  sed -i "s#CODO_TASK_DB_PWD = .*#CODO_TASK_DB_PWD = os.getenv('CODO_TASK_DB_PWD', '${DEFAULT_DB_DBPWD}')#g" codo-cmdb-settings.py
  sed -i "s#CODO_TASK_DB_DBNAME = .*#CODO_TASK_DB_DBNAME = os.getenv('CODO_TASK_DB_DBNAME', '${TASK_DB_DBNAME}')#g" codo-cmdb-settings.py

  #定时任务-cron
  CRON_DB_DBNAME='codo_cron'
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-cron-settings.py
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-cron-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-cron-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-cron-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-cron-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${CRON_DB_DBNAME}')#g" codo-cron-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" codo-cron-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" codo-cron-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" codo-cron-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" codo-cron-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${CRON_DB_DBNAME}')#g" codo-cron-settings.py

  #配置中心-kerrigan
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" kerrigan-settings.py
  DEFAULT_DB_DBNAME='codo_kerrigan'
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" kerrigan-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" kerrigan-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" kerrigan-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" kerrigan-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" kerrigan-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" kerrigan-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" kerrigan-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" kerrigan-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" kerrigan-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" kerrigan-settings.py

  #运维工具
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-tools-settings.py
  DEFAULT_DB_DBNAME='codo_tools'
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${DEFAULT_DB_DBNAME}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_REDIS_HOST = .*#DEFAULT_REDIS_HOST = os.getenv('DEFAULT_REDIS_HOST', '${DEFAULT_REDIS_HOST}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_REDIS_PORT = .*#DEFAULT_REDIS_PORT = os.getenv('DEFAULT_REDIS_PORT', '${DEFAULT_REDIS_PORT}')#g" codo-tools-settings.py
  sed -i "s#DEFAULT_REDIS_PASSWORD = .*#DEFAULT_REDIS_PASSWORD = os.getenv('DEFAULT_REDIS_PASSWORD', '${DEFAULT_REDIS_PASSWORD}')#g" codo-tools-settings.py

  #域名管理
  CRON_DB_DBNAME='codo_dns'
  sed -i "s#cookie_secret = .*#cookie_secret = '${cookie_secret}'#g" codo-dns-settings.py
  sed -i "s#DEFAULT_DB_DBHOST = .*#DEFAULT_DB_DBHOST = os.getenv('DEFAULT_DB_DBHOST', '${DEFAULT_DB_DBHOST}')#g" codo-dns-settings.py
  sed -i "s#DEFAULT_DB_DBPORT = .*#DEFAULT_DB_DBPORT = os.getenv('DEFAULT_DB_DBPORT', '${DEFAULT_DB_DBPORT}')#g" codo-dns-settings.py
  sed -i "s#DEFAULT_DB_DBUSER = .*#DEFAULT_DB_DBUSER = os.getenv('DEFAULT_DB_DBUSER', '${DEFAULT_DB_DBUSER}')#g" codo-dns-settings.py
  sed -i "s#DEFAULT_DB_DBPWD = .*#DEFAULT_DB_DBPWD = os.getenv('DEFAULT_DB_DBPWD', '${DEFAULT_DB_DBPWD}')#g" codo-dns-settings.py
  sed -i "s#DEFAULT_DB_DBNAME = .*#DEFAULT_DB_DBNAME = os.getenv('DEFAULT_DB_DBNAME', '${CRON_DB_DBNAME}')#g" codo-dns-settings.py
  sed -i "s#READONLY_DB_DBHOST = .*#READONLY_DB_DBHOST = os.getenv('READONLY_DB_DBHOST', '${READONLY_DB_DBHOST}')#g" codo-dns-settings.py
  sed -i "s#READONLY_DB_DBPORT = .*#READONLY_DB_DBPORT = os.getenv('READONLY_DB_DBPORT', '${READONLY_DB_DBPORT}')#g" codo-dns-settings.py
  sed -i "s#READONLY_DB_DBUSER = .*#READONLY_DB_DBUSER = os.getenv('READONLY_DB_DBUSER', '${READONLY_DB_DBUSER}')#g" codo-dns-settings.py
  sed -i "s#READONLY_DB_DBPWD = .*#READONLY_DB_DBPWD = os.getenv('READONLY_DB_DBPWD', '${READONLY_DB_DBPWD}')#g" codo-dns-settings.py
  sed -i "s#READONLY_DB_DBNAME = .*#READONLY_DB_DBNAME = os.getenv('READONLY_DB_DBNAME', '${CRON_DB_DBNAME}')#g" codo-dns-settings.py

}


function docker_compose_file(){
#docker-compose
echo -e "\033[32m [INFO]: 准备多项目docker-compose文件 \033[0m"
source /opt/codo/env.sh
cd /opt/codo/
sudo tee docker-compose.yml <<-'EOF'
version: '3'
services:
  do_mg:
#for example:
#   build:
#     context: .
#     dockerfile: codo-admin.dockerfile


  task:
    image: registry.cn-shanghai.aliyuncs.comodo-task:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./codo-task-settings.py:/var/www/codo-task/settings.py
      - /opt/ops_scripts:/opt/ops_scripts
    ports:
      - "8020:80"
    restart: unless-stopped
    networks:
      - codo



  cron:
    restart: unless-stopped
    image: registry.cn-shanghai.aliyuncs.comodo-cron:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /opt/ops_scripts:/opt/ops_scripts
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./codo-cron-settings.py:/var/www/codo-cron/settings.py
    ports:
      - "9900:9900"
    networks:
      - codo



  tools:
    restart: unless-stopped
    image: registry.cn-shanghai.aliyuncs.comodo-tools:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./codo-tools-settings.py:/var/www/codo-tools/settings.py
    ports:
      - "8040:80"
    hostname: codo-tools
    networks:
      - codo

  dns:
    restart: unless-stopped
    image: registry.cn-shanghai.aliyuncs.comodo-dns:0.3.0
    volumes:
      - /var/log/supervisor/:/var/log/supervisor/
      - /opt/ops_scripts:/opt/ops_scripts
      - /sys/fs/cgroup:/sys/fs/cgroup
      - ./codo-dns-settings.py:/var/www/codo-dns/settings.py
    ports:
      - "8060:80"
    networks:
      - codo




EOF
}

function docker_compose_up(){
  echo -e "\033[32m [INFO]: docker-compose同时启动多项目 \033[0m"
  source /opt/codo/env.sh
  cd /opt/codo/
  exist_codo_docker_num=`docker ps -a |grep -E "codo-admin|codo-tools|codo-cmdb|codo-dns|codo-task|kerrigan" | wc -l`

  if [[ ${exist_codo_docker_num} -gt 0 ]]; then
    docker-compose down ; docker-compose up -d
  else
    cd /opt/codo/
    docker-compose up -d
    if [ $? -eq 0 ]; then echo -e "\033[32m [INFO]: DockerCompose启动完成. \033[0m"; else echo -e "\033[31m [ERROR]: DockerCompose启动失败 \033[0m" && exit -6; fi
  fi
}



function install_dnsmasq(){
echo -e "\033[32m [INFO]: 部署dnsmasql内部通信服务 \033[0m"
source /opt/codo/env.sh
yum install dnsmasq -y
# 设置上游DNS，毕竟你的Dns只是个代理
sudo tee /etc/resolv.dnsmasq <<-'EOF'
nameserver 114.114.114.114
nameserver 8.8.8.8
EOF

#设置host解析，这里同学注意一下子，如果你是单机部署，那么你就将你的本机IP+模块域名解析即可，
#如果你是分布式部署的，那么每个模块对应的机器IP一定不要搞错，这个很重要，后面网关也要依赖此DNS去解析你的域名，帮你做服务转发的，切记！！！！
sudo tee /etc/dnsmasqhosts <<-EOF
$LOCALHOST_IP $front_domain
$LOCALHOST_IP $mg_domain
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
echo "nameserver $LOCALHOST_IP" > /etc/resolv.conf
echo "resolv-file=/etc/resolv.dnsmasq" >> /etc/dnsmasq.conf
echo "addn-hosts=/etc/dnsmasqhosts" >> /etc/dnsmasq.conf

## 启动
/bin/systemctl start dnsmasq.service
/bin/systemctl enable dnsmasq.service
systemctl status dnsmasq
/bin/systemctl restart dnsmasq.service

if [ $? == 0 ];then
  echo -e "\033[32m [INFO]: dnsmasq install success. \033[0m"
else
  echo -e "\033[31m [ERROR]: dnsmasq install faild \033[0m"
  exit -6
fi
}


function install_codo(){
  #安装前端
  echo -e "\033[32m [INFO]: codo(项目前端) Start install. \033[0m"
  source /opt/codo/env.sh
  CODO_VER="codo-beta-0.3.2"
  if [[ -f ${CODO_VER}.tar.gz ]];then
    rm -rf /var/www/codo-*
    if ! which wget &>/dev/null; then yum install -y wget >/dev/null 2>&1;fi
    [ ! -d /var/www ] && mkdir -p /var/www
    cd /var/www && wget https://github.comn/codo/releases/download/${CODO_VER}/${CODO_VER}.tar.gz
    tar zxf ${CODO_VER}.tar.gz
    if [ $? == 0 ];then
        echo -e "\033[32m [INFO]: codo(项目前端) install success. \033[0m"
    else
        echo -e "\033[31m [ERROR]: codo(项目前端) install faild \033[0m"
        exit -8
    fi
  fi
}


function install_api_gw(){
echo -e "\033[32m [INFO]: API网关 Start install. \033[0m"
source /opt/codo/env.sh
#安装openresty
yum install yum-utils -y
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum install openresty -y
yum install openresty-resty -y
cd /opt/codo/ && git clone https://github.com/ss1917/api-gateway.git
cp -arp api-gateway/* /usr/local/openresty/nginx/
sudo tee /usr/local/openresty/nginx/conf/nginx.conf <<-'EOF'
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
    resolver 10.10.10.12;                       # 内部DNS服务器地址
}
EOF


source /opt/codo/env.sh
sed  -i "s#10.10.10.12#$LOCALHOST_IP#g" /usr/local/openresty/nginx/conf/nginx.conf
sudo tee /usr/local/openresty/nginx/conf/conf.d/gw.conf <<-'EOF'
server {
    listen 80;
    server_name gwn;
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
EOF
mkdir -p /usr/local/openresty/nginx/conf/conf.d/
sudo tee /usr/local/openresty/nginx/conf/conf.d/demo.conf <<-'EOF'
server {
        listen       80;
        server_name demon;
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
                proxy_pass http://codo-gateway;
        }

        location ~ /(.svn|.git|admin|manage|.sh|.bash)$ {
            return 403;
        }
}
EOF
source /opt/codo/env.sh
sudo tee lua/configs.lua <<-EOF
json = require("cjson")

--mysql_config = {
--    host = "127.0.0.1",
--    port = 3306,
--    database = "lua",
--    user = "root",
--    password = "",
--    max_packet_size = 1024 * 1024
--}

-- redis配置，一定要修改,并且和codo-admin保持一致
redis_config = {
    host = '${DEFAULT_REDIS_HOST}',
    port = '${DEFAULT_REDIS_PORT}',
    auth_pwd = '${DEFAULT_REDIS_PASSWORD}',
    db = 8,
    alive_time = 3600 * 24 * 7,
    channel = 'gw'
}


-- 注意：这里的token_secret必须要和codo-admin里面的token_secret保持一致
token_secret = '${token_secret}'
logs_file = '/var/log/gw.log'

--刷新权限到redis接口
rewrite_cache_url = 'http://codo-admin/v2/accounts/verify/'
-- 注意：rewrite_cache_token要和codo-admin里面的secret_key = '8b888a62-3edb-4920-b446-697a472b4001'保持一致
rewrite_cache_token = '8b888a62-3edb-4920-b446-697a472b4001'


--并发限流配置
limit_conf = {
    rate = 10, --限制ip每分钟只能调用n*60次接口
    burst = 10, --桶容量,用于平滑处理,最大接收请求次数
}

--upstream匹配规则,API网关域名
gw_domain_name = 'codo-gateway'

--下面的转发一定要修改，根据自己实际数据修改
rewrite_conf = {
    [gw_domain_name] = {
        rewrite_urls = {
            {
                uri = "/dns",
                rewrite_upstream = "codo-dns:8060"
            },
            {
                uri = "/cmdb2",
                rewrite_upstream = "codo-cmdb2:8050"
            },
            {
                uri = "/tools",
                rewrite_upstream = "codo-tools:8040"
            },
            {
                uri = "/kerrigan",
                rewrite_upstream = "codo-kerrigan"
            },
            {
                uri = "/cmdb",
                rewrite_upstream = "codo-cmdb:8002"
            },
            {
                uri = "/k8s",
                rewrite_upstream = "codo-k8s:8001"
            },
            {
                uri = "/task",
                rewrite_upstream = "codo-task:8020"
            },
            {
                uri = "/cron",
                rewrite_upstream = "codo-cron:9900"
            },
            {
                uri = "/mg",
                rewrite_upstream = "codo-admin"
            },
            {
                uri = "/accounts",
                rewrite_upstream = "codo-admin"
            },
        }
    }
}
EOF
mkdir -p /var/log/nginx/ && touch /var/log/nginx/f_access.log
openresty -t   #测试
}

#定义函数结束


#入口逻辑

#创建目录
[ ! -d /opt/codo ] && mkdir -p /opt/codo
cd /opt/codo/

#校验IP
LOCAL_IP=$1
check_ip $LOCAL_IP
[ $? != 0 ] && echo "请输入格式正确的内网IP" && exit -1

# 基础环境python3/docker/docker-compose--> 初始化env--> 下载项目配置--> 修改项目配置--> 创库语句--> 多项目docker-compose--> docker-compose启动多项目--> 初始化多项目数据--> 部署DNS内部通信--> 部署前端--> 部署网关--> 访问

export -f install_python3
export -f install_docker_compose
export -f init_env
export -f download_settings
export -f update_settings
export -f mysql_database_file
export -f docker_compose_file
export -f docker_compose_up
export -f init_mysql
export -f install_dnsmasq
export -f install_codo
export -f install_api_gw


[ -f /var/www/codo/index.html ] && echo -e "\033[33m [Warning]: 项目前端:/var/www/codo/ already exists,Skip installation \033[0m"  || install_codo
install_api_gw
echo -e "\033[32m [INFO]: 你的访问地址：http://demon  \033[0m"
echo -e "\033[32m [INFO]: 你的访问用户：admin  \033[0m"
echo -e "\033[32m [INFO]: 你的访问密码：admin@opendevops  \033[0m"
echo -e "\033[32m [INFO]: 请在你的PC机器上绑定本地Host进行登陆测试  \033[0m"
echo -e "\033[32m [INFO]: 你的MySQL/Redis/MQ等密码请在/opt/codo/env.sh找到  \033[0m"
echo -e "\033[32m [INFO]: 日志目录：/var/log/supervisor/, 详细可查看日志log是否有报错。 \033[0m"

