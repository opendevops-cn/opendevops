#usage() {
#    echo "请按如下格式执行"
#    echo "USAGE: bash $0 函数名1#函数名2"
#    echo "USAGE: bash $0 epel#ulimits#ssh"
#    exit 1
#}
#

function epel(){
	yum install epel-release -y >/dev/null 2>&1
	sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/epel.repo
	sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/epel.repo
	sed -i '6s/enabled=0/enabled=1/g' /etc/yum.repos.d/epel.repo
	sed -i '7s/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/epel.repo
	yum clean all >/dev/null 2>&1
	#阿里云机器用aliyun epel
	#echo "[EPEL 配置] ==> OK"
}

function ulimits(){
cat > /etc/security/limits.conf <<EOF
* soft noproc 65536
* hard noproc 65536
* soft nofile 65536
* hard nofile 65536
EOF
# centos 7.3 还是 7.4开始， 这个文件有一部分soft 和 nproc 内容，登陆后会被覆盖，/etc/security/limits.conf 不会生效
echo > /etc/security/limits.d/20-nproc.conf 

ulimit -n 65536
ulimit -u 65536


#echo "[ulimits 配置] ==> OK"


}


# 系统默认没有 /etc/init.d/sshd 需要使用 systemctl restart  sshd
function ssh(){
	[ -f /etc/ssh/sshd_config ]  && sed -ir '13 iUseDNS no\nGSSAPIAuthentication no' /etc/ssh/sshd_config && systemctl restart  sshd >/dev/null 2>&1
#echo "[SSH 优化] ==> OK"
}

# 修改内核参数，增加缓存区，减少等待时间
# 可以接收更大的包，增加对轻量ddos抗性
function kernel(){
cat > /etc/sysctl.conf <<EOF
fs.file-max = 65536
net.core.netdev_max_backlog = 32768
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.somaxconn = 32768
net.core.wmem_default = 8388608
net.core.wmem_max = 16777216
net.ipv4.conf.all.arp_ignore = 0
net.ipv4.conf.lo.arp_announce = 0
net.ipv4.conf.lo.arp_ignore = 0
net.ipv4.ip_local_port_range = 5000 65000
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_syn_backlog = 65536
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
EOF
sysctl -p >/dev/null 2>&1
#echo "[内核 优化] ==> OK"
}

# 增加操作系统记录数量
function history(){
	if ! grep "HISTTIMEFORMAT" /etc/profile >/dev/null 2>&1
	then echo '
	UserIP=$(who -u am i | cut -d"("  -f 2 | sed -e "s/[()]//g")
	export HISTTIMEFORMAT="[%F %T] [`whoami`] [${UserIP}] " ' >> /etc/profile;
	fi
	sed -i "s/HISTSIZE=1000/HISTSIZE=999999999/" /etc/profile
#echo "[history 优化] ==> OK"
}

# 这个稍后我再试一试，我是倾向不要关闭selinux，而是使用系统权限完善来控制软件运行。
# 稍后测试一下看看
function security(){
	> /etc/issue
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
	sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
	setenforce 0 >/dev/null 2>&1
	#systemctl stop firewalld.service
	#systemctl disable firewalld.service
	yum install -y openssl openssh bash >/dev/null 2>&1
	#echo "[安全配置] ==> OK"
}

function other(){
	yum groupinstall Development tools -y >/dev/null 2>&1
	yum install -y vim wget lrzsz telnet traceroute iotop tree >/dev/null 2>&1
	yum install -y ncftp axel git zlib-devel openssl-devel unzip xz libxslt-devel libxml2-devel libcurl-devel >/dev/null 2>&1
	#echo "[安装常用工具] ==> OK"
	echo "export HOME=/root" >> /etc/profile
	source /etc/profile
	useradd -M -s /sbin/nologin nginx >/dev/null 2>&1
	mkdir -p /root/ops_scripts /data1/www
	mkdir -p /opt/codo/
}

export -f epel
export -f ulimits
export -f ssh
export -f kernel
export -f history
export -f security
export -f other

##格式必须是: bash script 函数名1#函数2
## 例如: bash system_init_v1.sh epel#ulimits#ssh
#echo $1 | awk -F "#" '{for(i=1;i<=NF;++i) system($i)}'
epel
ulimits
ssh
kernel
history
security
other
#echo '[Success]System Init OK'