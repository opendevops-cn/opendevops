
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
* soft noproc 20480
* hard noproc 20480
root soft nofile 65535
root hard nofile 65535
* soft nofile 65535
* hard nofile 65535
EOF
ulimit -n 65535
ulimit -u 20480
#echo "[ulimits 配置] ==> OK"
}

function ssh(){
	[ -f /etc/ssh/sshd_config ]  && sed -ir '13 iUseDNS no\nGSSAPIAuthentication no' /etc/ssh/sshd_config && /etc/init.d/sshd restart >/dev/null 2>&1
#echo "[SSH 优化] ==> OK"
}

function kernel(){
cat > /etc/sysctl.conf <<EOF
fs.file-max = 65535
net.ipv4.tcp_max_tw_buckets = 1000000
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.ip_local_port_range = 5000 65000
net.ipv4.tcp_mem = 786432 1048576 1572864
net.core.wmem_max = 873200
net.core.rmem_max = 873200
net.ipv4.tcp_wmem = 8192 436600 873200
net.ipv4.tcp_rmem = 32768 436600 873200
net.core.somaxconn = 10240
net.core.netdev_max_backlog = 20480
net.ipv4.tcp_max_syn_backlog = 20480
net.ipv4.tcp_retries2 = 5
net.ipv4.conf.lo.arp_ignore = 0
net.ipv4.conf.lo.arp_announce = 0
net.ipv4.conf.all.arp_ignore = 0
EOF
sysctl -p >/dev/null 2>&1
#echo "[内核 优化] ==> OK"
}

function history(){
	if ! grep "HISTTIMEFORMAT" /etc/profile >/dev/null 2>&1
	then echo '
	UserIP=$(who -u am i | cut -d"("  -f 2 | sed -e "s/[()]//g")
	export HISTTIMEFORMAT="[%F %T] [`whoami`] [${UserIP}] " ' >> /etc/profile;
	fi
#echo "[history 优化] ==> OK"
}

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
	mkdir /data1
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