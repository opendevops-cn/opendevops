# 单机部署

操作系统：CentOS Linux release 7.7.1908 （阿里云） （单机部署）（无证书）

### 下载 etcd 二进制文件

[release](https://github.com/coreos/etcd/releases) 查找自己需要的版本。

```bash
# 修改你需要的版本
ETCD_VERSION='3.4.14'
# 创建目录
mkdir -p /data/etcd/{data,wal}
# 下载
cd /data/etcd/
wget https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
# 解压
tar xvf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
# 复制到/usr/local/bin/下，默认已经有可执行权限了，无需在使用chmod +x。
mv etcd-v${VER}-linux-amd64/etcd* /usr/local/bin/
```

### 使用Systemd管理服务

```bash
# 设置变量
NODE_NAME='etcd-single'
NODE_IP='172.25.1.93'
ETCD_DATA_DIR='/data/etcd/data'
ETCD_WAL_DIR='/data/etcd/wal'

# 创建Systemd Unit管理文件
cat >  /etc/systemd/system/etcd.service <<EOF
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target
Documentation=https://github.com/coreos

[Service]
Type=notify
WorkingDirectory=${ETCD_DATA_DIR}
ExecStart=/usr/local/bin/etcd \\
  --data-dir=${ETCD_DATA_DIR} \\
  --wal-dir=${ETCD_WAL_DIR} \\
  --name=${NODE_NAME} \\
  --listen-peer-urls=http://${NODE_IP}:2380 \\
  --initial-advertise-peer-urls=http://${NODE_IP}:2380 \\
  --listen-client-urls=http://${NODE_IP}:2379,http://127.0.0.1:2379 \\
  --advertise-client-urls=http://${NODE_IP}:2379 \\
  --auto-compaction-mode=periodic \\
  --auto-compaction-retention=1 \\
  --max-request-bytes=33554432 \\
  --quota-backend-bytes=6442450944 \\
  --heartbeat-interval=250 \\
  --election-timeout=2000
Restart=on-failure
RestartSec=5
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF
```

### 启动服务

```bash
systemctl enable etcd
systemctl start etcd
systemctl status etcd
```

### 验证ETCD服务状态

```bash
# 验证IP
etcdctl --endpoints=http://${NODE_IP}:2379 endpoint health
输出结果：
http://172.25.1.93:2379 is healthy: successfully committed proposal: took = 1.632444ms

# 验证本地
etcdctl --endpoints=http://127.0.0.1:2379 endpoint health
输出结果：
127.0.0.1:2379 is healthy: successfully committed proposal: took = 1.716469ms
```