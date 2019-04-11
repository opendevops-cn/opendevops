#! /bin/bash
# install rabbitmq
# By OpenDevOps  

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