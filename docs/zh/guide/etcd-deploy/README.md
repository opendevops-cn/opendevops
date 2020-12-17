# 部署外部 Etcd 集群（集群&单机）

作者：青牛踏雪御苍穹（CoDo老王）

### 准备工作

操作系统：Ubuntu 18.04.3 LTS （本地环境） 集群部署（自签证书）

操作系统：CentOS Linux release 7.7.1908 （阿里云） （单机部署）

自行打通ROOT-SSH免密

配置本地hosts

```
cat /etc/hosts
192.168.1.220 etcd-1
192.168.1.221 etcd-2
192.168.1.222 etcd-3
```

### 集群部署（自签证书）

###  配置环境变量

```
cat > /data/etcd/environment.sh <<EOF
#!/usr/bin/bash
# etcd 版本
export VER='3.4.14'

# ETCD集群各机器 IP 数组
export NODE_IPS=(192.168.1.220 192.168.1.221 192.168.1.222)

# 集群各 IP 对应的主机名数组
export NODE_NAMES=(etcd-1 etcd-2 etcd-3)

# etcd 集群服务地址列表
export ETCD_ENDPOINTS="https://192.168.1.220:2379,https://192.168.1.221:2379,https://192.168.1.222:2379"

# etcd 集群间通信的 IP 和端口
export ETCD_NODES="etcd-1=https://192.168.1.220:2380,etcd-2=https://192.168.1.221:2380,etcd-3=https://192.168.1.222:2380"

# etcd 数据目录
export ETCD_DATA_DIR="/data/etcd/data"

# etcd WAL 目录，建议是 SSD 磁盘分区，或者和 ETCD_DATA_DIR 不同的磁盘分区
export ETCD_WAL_DIR="/data/etcd/wal"
EOF
```

### 下载和分发 etcd 二进制文件

[relase](https://github.com/coreos/etcd/releases) 查找自己需要的版本。

```
# 修改你需要的版本
VER='3.4.14'
mkdir -p /data/etcd/{data,wal,ca}
cd /data/etcd/
wget https://github.com/coreos/etcd/releases/download/v${VER}/etcd-v${VER}-linux-amd64.tar.gz
tar xvf etcd-v${VER}-linux-amd64.tar.gz
```

### 分发二进制文件到各个主机

```
cd /data/etcd/
source /data/etcd/environment.sh
$ for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    scp -r /data/etcd/etcd-v${VER}-linux-amd64/etcd* root@${node_ip}:/usr/local/bin/
    ssh root@${node_ip} "chmod +x /usr/local/bin/etcd*"
  done
```

### 安装 cfssl 工具集

```
# 安装cfssl
cd /data/etcd/
wget https://github.com/cloudflare/cfssl/releases/download/v1.4.1/cfssl_1.4.1_linux_amd64
mv cfssl_1.4.1_linux_amd64 /usr/local/bin/cfssl

# cfssljson
wget https://github.com/cloudflare/cfssl/releases/download/v1.4.1/cfssljson_1.4.1_linux_amd64
mv cfssljson_1.4.1_linux_amd64 /usr/local/bin/cfssljson

# cfssl-certinfo
wget https://github.com/cloudflare/cfssl/releases/download/v1.4.1/cfssl-certinfo_1.4.1_linux_amd64
mv cfssl-certinfo_1.4.1_linux_amd64 /usr/local/bin/cfssl-certinfo

# add permission
chmod +x /usr/local/bin/cfssl*
```

### 创建证书

CA 配置文件用于配置根证书的使用场景 (profile) 和具体参数 (usage，过期时间、服务端认证、客户端认证、加密等)：


```
cd /data/etcd/ca/
$ cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "etcd-cluster": {
        "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ],
        "expiry": "876000h"
      }
    }
  }
}
EOF
```

创建证书签名请求文件

$ cat > ca-csr.json <<EOF
{
  "CN": "kubernetes-ca",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "etcd",
      "OU": "opsnull"
    }
  ],
  "ca": {
    "expiry": "876000h"
 }
}
EOF

- `signing`：表示该证书可用于签名其它证书（生成的 `ca.pem` 证书中 `CA=TRUE`）；
- `server auth`：表示 client 可以用该该证书对 server 提供的证书进行验证；
- `client auth`：表示 server 可以用该该证书对 client 提供的证书进行验证；
- `"expiry": "876000h"`：证书有效期设置为 100 年；

### 创建证书签名请求文件

```json
$ cat > ca-csr.json <<EOF
{
  "CN": "kubernetes-ca",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "etcd",
      "OU": "opsnull"
    }
  ],
  "ca": {
    "expiry": "876000h"
 }
}
EOF
```

- `CN：Common Name`：etcd 从证书中提取该字段作为请求的**用户名 (User Name)**，浏览器使用该字段验证网站是否合法；
- `O：Organization`：etcd 从证书中提取该字段作为请求用户所属的**组 (Group)**； kube-apiserver 将提取的 `User、Group` 作为 `RBAC` 授权的用户标识；

### 生成证书文件和私钥

```
$ cd /data/etcd/ca/
$ cfssl gencert -initca ca-csr.json | cfssljson -bare ca
输出如下：
2020/12/17 09:54:25 [INFO] generating a new CA key and certificate from CSR
2020/12/17 09:54:25 [INFO] generate received request
2020/12/17 09:54:25 [INFO] received CSR
2020/12/17 09:54:25 [INFO] generating key: rsa-2048
2020/12/17 09:54:26 [INFO] encoded CSR
2020/12/17 09:54:26 [INFO] signed certificate with serial number 437386317969465523284385845194090172491501571515
$ ls ca*
输出如下：
ca-config.json  ca.csr  ca-csr.json  ca-key.pem  ca.pem
```

### 分发证书文件

```
$ source /data/etcd/environment.sh
$ for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "mkdir -p /etc/etcd/cert"
    scp ca*.pem ca-config.json root@${node_ip}:/etc/etcd/cert
  done
输出如下：
>>> 192.168.1.220
ca-key.pem                                                                                            100% 1679     1.2MB/s   00:00
ca.pem                                                                                                100% 1326     1.2MB/s   00:00
ca-config.json                                                                                        100%  293   221.9KB/s   00:00
>>> 192.168.1.221
ca-key.pem                                                                                            100% 1679     1.1MB/s   00:00
ca.pem                                                                                                100% 1326     1.2MB/s   00:00
ca-config.json                                                                                        100%  293   180.2KB/s   00:00
>>> 192.168.1.222
ca-key.pem                                                                                            100% 1679   973.5KB/s   00:00
ca.pem                                                                                                100% 1326   972.0KB/s   00:00
ca-config.json  
```

注意：

1. 不同证书 csr 文件的 CN、C、ST、L、O、OU 组合必须不同，否则可能出现 PEER'S CERTIFICATE HAS AN INVALID SIGNATURE 错误；
2. 后续创建证书的 csr 文件时，CN 都不相同（C、ST、L、O、OU 相同），以达到区分的目的；

etcd-csr证书签名

- `hosts`：指定授权使用该证书的 etcd 节点 IP 列表，**需要将 etcd 集群所有节点 IP 都列在其中**

```
#
$ cd /data/etcd/ca/
$ cat > /data/etcd/ca/etcd-csr.json <<EOF
{
  "CN": "etcd",
  "hosts": [
    "127.0.0.1",
    "192.168.1.220",
    "192.168.1.221",
    "192.168.1.222"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "etcd",
      "OU": "opsnull"
    }
  ]
}
EOF
```

生成证书和私钥：

```
$ cfssl gencert -ca=/data/etcd/ca/ca.pem \
    -ca-key=/data/etcd/ca/ca-key.pem \
    -config=/data/etcd/ca/ca-config.json \
    -profile=etcd-cluster /data/etcd/ca/etcd-csr.json | cfssljson -bare etcd
输出如下：
2020/12/17 10:03:52 [INFO] generate received request
2020/12/17 10:03:52 [INFO] received CSR
2020/12/17 10:03:52 [INFO] generating key: rsa-2048
2020/12/17 10:03:53 [INFO] encoded CSR
2020/12/17 10:03:53 [INFO] signed certificate with serial number 290666497635689555552442344139619956527112356386    
```

### 分发证书

```
$ cd /data/etcd/
$ source /data/etcd/environment.sh
$ for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    scp etcd*.pem root@${node_ip}:/etc/etcd/cert/
  done
```

### 创建 etcd 的 systemd unit 模板文件

模板不需要做任何改动，所有需要替换的地方后续都会替换掉：

```
source /data/etcd/environment.sh
cat > etcd.service.template <<EOF
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
  --name=##NODE_NAME## \\
  --cert-file=/etc/etcd/cert/etcd.pem \\
  --key-file=/etc/etcd/cert/etcd-key.pem \\
  --trusted-ca-file=/etc/etcd/cert/ca.pem \\
  --peer-cert-file=/etc/etcd/cert/etcd.pem \\
  --peer-key-file=/etc/etcd/cert/etcd-key.pem \\
  --peer-trusted-ca-file=/etc/etcd/cert/ca.pem \\
  --peer-client-cert-auth \\
  --client-cert-auth \\
  --listen-peer-urls=https://##NODE_IP##:2380 \\
  --initial-advertise-peer-urls=https://##NODE_IP##:2380 \\
  --listen-client-urls=https://##NODE_IP##:2379,http://127.0.0.1:2379 \\
  --advertise-client-urls=https://##NODE_IP##:2379 \\
  --initial-cluster-token=etcd-cluster-0 \\
  --initial-cluster=${ETCD_NODES} \\
  --initial-cluster-state=new \\
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

参数说明：

- `WorkingDirectory`、`--data-dir`：指定工作目录和数据目录为 `${ETCD_DATA_DIR}`，需在启动服务前创建这个目录；
- `--wal-dir`：指定 wal 目录，为了提高性能，一般使用 SSD 或者和 `--data-dir` 不同的磁盘；
- `--name`：指定节点名称，当 `--initial-cluster-state` 值为 new 时，`--name` 的参数值必须位于 `--initial-cluster` 列表中；
- `--cert-file、--key-file`：etcd server 与 client 通信时使用的证书和私钥；
- `--trusted-ca-file`：签名 client 证书的 CA 证书，用于验证 client 证书；
- `--peer-cert-file`、`--peer-key-file`：etcd 与 peer 通信使用的证书和私钥；
- `--peer-trusted-ca-file`：签名 peer 证书的 CA 证书，用于验证 peer 证书；

### 创建和分发 etcd systemd unit 文件

替换模板文件中的变量，为各节点创建 systemd unit 文件：

```
$ source /data/etcd/environment.sh
$ for (( i=0; i < 3; i++ ))
  do
    sed -e "s/##NODE_NAME##/${NODE_NAMES[i]}/" -e "s/##NODE_IP##/${NODE_IPS[i]}/" etcd.service.template > etcd-${NODE_IPS[i]}.service 
  done
$ ls *.service
```

- NODE_NAMES 和 NODE_IPS 为相同长度的 bash 数组，分别为节点名称和对应的 IP；

分发生成的 systemd unit 文件：

```
$ source /data/etcd/environment.sh
$ for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    scp etcd-${node_ip}.service root@${node_ip}:/etc/systemd/system/etcd.service
  done
```

### 启动服务测试


```
$ source /data/etcd/environment.sh
$ for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "mkdir -p ${ETCD_DATA_DIR} ${ETCD_WAL_DIR}"
    ssh root@${node_ip} "systemctl daemon-reload && systemctl enable etcd && systemctl restart etcd " &
  done
 输出结果：
 >>> 192.168.1.220
[1] 2411
>>> 192.168.1.221
[2] 2517
>>> 192.168.1.222
[3] 2722 
```

- 命令首先创建 etcd 数据目录和工作目录
- etcd 进程首次启动时会等待其它节点的 etcd 加入集群，命令 `systemctl start etcd` 会卡住一段时间，为正常现象

### 检查启动结果

```bash
$ source /data/etcd/environment.sh
$ for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "systemctl status etcd|grep Active"
  done

输出结果：
>>> 192.168.1.220
   Active: active (running) since Thu 2020-12-17 10:15:02 UTC; 31s ago
>>> 192.168.1.221
   Active: active (running) since Thu 2020-12-17 10:15:02 UTC; 36s ago
>>> 192.168.1.222
   Active: active (running) since Thu 2020-12-17 10:15:02 UTC; 40s ago  
```


### 验证服务状态

部署完 etcd 集群后，在任一 `etcd` 节点上执行如下命令：

```
$ source /data/etcd/environment.sh
$ for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    /usr/local/bin/etcdctl \
    --endpoints=https://${node_ip}:2379 \
    --cacert=/etc/etcd/cert/ca.pem \
    --cert=/etc/etcd/cert/etcd.pem \
    --key=/etc/etcd/cert/etcd-key.pem endpoint health
  done
输出结果：
>>> 192.168.1.220
https://192.168.1.220:2379 is healthy: successfully committed proposal: took = 144.666078ms
>>> 192.168.1.221
https://192.168.1.221:2379 is healthy: successfully committed proposal: took = 50.699405ms
>>> 192.168.1.222
https://192.168.1.222:2379 is healthy: successfully committed proposal: took = 47.478054ms  
```

#### 单机部署（无证书）

### 下载 etcd 二进制文件

[relase](https://github.com/coreos/etcd/releases) 查找自己需要的版本。

```
# 修改你需要的版本
VER='3.4.14'
mkdir -p /data/etcd/{data,wal,ca}
cd /data/etcd/
wget https://github.com/coreos/etcd/releases/download/v${VER}/etcd-v${VER}-linux-amd64.tar.gz
tar xvf etcd-v${VER}-linux-amd64.tar.gz
mv scp etcd-v${VER}-linux-amd64/etcd* /usr/local/bin/
chmox +x /usr/local/bin/etcd*
```

### 使用systemd管理服务

```
# 创建目录
mkdir /data/etcd/

# 设置变量
NODE_NAME='etcd-single'
NODE_IP='172.25.1.93'
ETCD_DATA_DIR=’/data/etcd/data‘
ETCD_WAL_DIR='/data/etcd/wal'

# 创建systemd管理文件
cat > etcd.service <<EOF
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

```
systemctl enable etcd
systemctl start etcd
systemctl status etcd
```

### 验证集群是否正常

```
# 验证IP
etcdctl --endpoints=http://172.25.1.93:2379 endpoint health
output...
http://172.25.1.93:2379 is healthy: successfully committed proposal: took = 1.632444ms

# 验证本地
etcdctl --endpoints=http://127.0.0.1:2379 endpoint health
outpu...
127.0.0.1:2379 is healthy: successfully committed proposal: took = 1.716469ms
```