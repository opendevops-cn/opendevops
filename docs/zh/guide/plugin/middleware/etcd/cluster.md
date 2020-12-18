# 集群部署

- `作者：青牛踏雪御苍穹（CoDo老王)`
- 部署 ETCD 集群（自签证书）

### 准备工作

操作系统：Ubuntu 18.04.3 LTS （本地环境） 集群部署（自签证书）

自行打通服务器之间的SSH免密，或者自己输入密码来完成复制操作。

###  配置环境变量

```bash
ETCD_DIR='${ETCD_DIR}'
mkddir ${ETCD_DIR}
cat > ${ETCD_DIR}/environment.sh <<EOF
#!/usr/bin/bash
# etcd 版本
export ETCD_VERSION='3.4.14'

# 集群节点
export ETCD0='192.168.1.220'
export ETCD1='192.168.1.221'
export ETCD2='192.168.1.222'

# ETCD集群各机器 IP 数组
export NODE_IPS=(${ETCD0} ${ETCD1} ${ETCD2})

# 集群各 IP 对应的主机名数组
export NODE_NAMES=(etcd-0 etcd-1 etcd-2)

# etcd 集群服务地址列表
export ETCD_ENDPOINTS="https://${ETCD0}:2379,https://${ETCD1}:2379,https://${ETCD2}:2379"

# etcd 集群间通信的 IP 和端口
export ETCD_NODES="etcd-0=https://${ETCD0}:2380,etcd-1=https://${ETCD1}:2380,etcd-2=https://${ETCD2}:2380"

# etcd 目录
export ETCD_DIR="/data/etcd"

# etcd 数据目录
export ETCD_DATA_DIR="/data/etcd/data"

# etcd WAL 目录，建议是 SSD 磁盘分区，或者和 ETCD_DATA_DIR 不同的磁盘分区
export ETCD_WAL_DIR="/data/etcd/wal"

# etcd 自签证书存放目录
export ETCD_CA_DIR='/data/etcd/ca'

# etcd 各个节点证书存放目录
export ETCD_ETC_DIR='/etc/etcd/cert'
EOF
chmod +x environment.sh
# 创建存放数据、证书、WAl目录
mkdir ${ETCD_DATA_DIR} ${ETCD_CA_DIR} ${ETCD_WAL_DIR}
```

配置本地hosts

```bash
# 配置本地host
source ${ETCD_DIR}/environment.sh
cat >> /etc/hosts <<EOF
${ETCD0} etcd-1
${ETCD1} etcd-2
${ETCD2} etcd-3
EOF
```

### 下载和分发 etcd 二进制文件

[release](https://github.com/coreos/etcd/releases) 查找自己需要的版本。

```bash
source ${ETCD_DIR}/environment.sh
cd ${ETCD_DIR}
wget https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
tar xvf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
```

### 分发二进制文件到各个主机

```bash
cd ${ETCD_DIR}
source ${ETCD_DIR}/environment.sh
for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    scp -r /data/etcd/etcd-v${ETCD_VERSION}-linux-amd64/etcd* root@${node_ip}:/usr/local/bin/
    ssh root@${node_ip} "chmod +x /usr/local/bin/etcd*"
done
# 输出结果
>>> 192.168.1.220
etcd                                                                                                  100%   23MB  51.1MB/s   00:00
etcdctl                                                                                               100%   17MB  44.5MB/s   00:00
>>> 192.168.1.221
etcd                                                                                                  100%   23MB  39.1MB/s   00:00
etcdctl                                                                                               100%   17MB  34.4MB/s   00:00
>>> 192.168.1.222
etcd                                                                                                  100%   23MB  52.0MB/s   00:00
etcdctl                                                                                               100%   17MB  45.8MB/s   00:00  
```

### 安装 cfssl 工具集

```bash
# 安装cfssl
cd ${ETCD_DIR}
wget https://github.com/cloudflare/cfssl/releases/download/v1.4.1/cfssl_1.4.1_linux_amd64
mv cfssl_1.4.1_linux_amd64 /usr/local/bin/cfssl

# cfssljson
wget https://github.com/cloudflare/cfssl/releases/download/v1.4.1/cfssljson_1.4.1_linux_amd64
mv cfssljson_1.4.1_linux_amd64 /usr/local/bin/cfssljson

# cfssl-certinfo
wget https://github.com/cloudflare/cfssl/releases/download/v1.4.1/cfssl-certinfo_1.4.1_linux_amd64
mv cfssl-certinfo_1.4.1_linux_amd64 /usr/local/bin/cfssl-certinfo

# 添加执行权限
chmod +x /usr/local/bin/cfssl*
```

### 创建证书

CA 配置文件用于配置根证书的使用场景 (profile) 和具体参数 (usage，过期时间、服务端认证、客户端认证、加密等)：


```bash
cd ${ETCD_CA_DIR} 
cat > ca-config.json <<EOF
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

```bash
cat > ca-csr.json <<EOF
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

- `signing`：表示该证书可用于签名其它证书（生成的 `ca.pem` 证书中 `CA=TRUE`）；
- `server auth`：表示 client 可以用该该证书对 server 提供的证书进行验证；
- `client auth`：表示 server 可以用该该证书对 client 提供的证书进行验证；
- `"expiry": "876000h"`：证书有效期设置为 100 年；

### 创建证书签名请求文件

```bash
cat > ca-csr.json <<EOF
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

```bash
cd ${ETCD_CA_DIR} 
cfssl gencert -initca ca-csr.json | cfssljson -bare ca
输出结果：
2020/12/17 09:54:25 [INFO] generating a new CA key and certificate from CSR
2020/12/17 09:54:25 [INFO] generate received request
2020/12/17 09:54:25 [INFO] received CSR
2020/12/17 09:54:25 [INFO] generating key: rsa-2048
2020/12/17 09:54:26 [INFO] encoded CSR
2020/12/17 09:54:26 [INFO] signed certificate with serial number 437386317969465523284385845194090172491501571515
$ ls ca*
# 输出结果：
ca-config.json  ca.csr  ca-csr.json  ca-key.pem  ca.pem
```

### 分发证书文件

```bash
source ${ETCD_DIR}/environment.sh
for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "mkdir -p ${ETCD_ETC_DIR}"
    scp ca*.pem ca-config.json root@${node_ip}:${ETCD_ETC_DIR}
done
# 输出结果：
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

```bash
cd ${ETCD_CA_DIR} 
cat > /data/etcd/ca/etcd-csr.json <<EOF
{
  "CN": "etcd",
  "hosts": [
    "127.0.0.1",
    "${ETCD0}",
    "${ETCD1}",
    "${ETCD2}"
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

```bash
cfssl gencert -ca=${ETCD_CA_DIR}/ca.pem \
    -ca-key=${ETCD_CA_DIR}/ca-key.pem \
    -config=${ETCD_CA_DIR}/ca-config.json \
    -profile=etcd-cluster ${ETCD_CA_DIR}/etcd-csr.json | cfssljson -bare etcd
# 输出结果：
2020/12/17 10:03:52 [INFO] generate received request
2020/12/17 10:03:52 [INFO] received CSR
2020/12/17 10:03:52 [INFO] generating key: rsa-2048
2020/12/17 10:03:53 [INFO] encoded CSR
2020/12/17 10:03:53 [INFO] signed certificate with serial number 290666497635689555552442344139619956527112356386    
```

### 分发证书

```bash
cd ${ETCD_CA_DIR}
for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    scp etcd*.pem root@${node_ip}:${ETCD_ETC_DIR}
done
# 输出结果
>>> 192.168.1.220
etcd-key.pem                                                                                          100% 1679   279.6KB/s   00:00
etcd.pem                                                                                              100% 1448     1.3MB/s   00:00
>>> 192.168.1.221
etcd-key.pem                                                                                          100% 1679   763.6KB/s   00:00
etcd.pem                                                                                              100% 1448     1.0MB/s   00:00
>>> 192.168.1.222
etcd-key.pem                                                                                          100% 1679     1.0MB/s   00:00
etcd.pem
```

### 创建 etcd 的 systemd unit 模板文件

模板不需要做任何改动，所有需要替换的地方后续都会替换掉：

```bash
cd ${ETCD_DIR}
source ${ETCD_DIR}/environment.sh
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
  --cert-file=${ETCD_ETC_DIR}/etcd.pem \\
  --key-file=${ETCD_ETC_DIR}/etcd-key.pem \\
  --trusted-ca-file=${ETCD_ETC_DIR}/ca.pem \\
  --peer-cert-file=${ETCD_ETC_DIR}/etcd.pem \\
  --peer-key-file=${ETCD_ETC_DIR}/etcd-key.pem \\
  --peer-trusted-ca-file=${ETCD_ETC_DIR}/ca.pem \\
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

```bash
# 生成
source ${ETCD_DIR}/environment.sh
for (( i=0; i < 3; i++ ))
  do
    sed -e "s/##NODE_NAME##/${NODE_NAMES[i]}/" -e "s/##NODE_IP##/${NODE_IPS[i]}/" etcd.service.template > etcd-${NODE_IPS[i]}.service 
done
# 验证
ls *.service
# 输出结果：
etcd-192.168.1.220.service  etcd-192.168.1.221.service  etcd-192.168.1.222.service
```

- NODE_NAMES 和 NODE_IPS 为相同长度的 bash 数组，分别为节点名称和对应的 IP；

分发生成的 systemd unit 文件：

```bash
source ${ETCD_DIR}/environment.sh
for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    scp etcd-${node_ip}.service root@${node_ip}:/etc/systemd/system/etcd.service
done
```

### 启动服务测试

```bash
source ${ETCD_DIR}/environment.sh
for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "mkdir -p ${ETCD_DATA_DIR} ${ETCD_WAL_DIR}"
    ssh root@${node_ip} "systemctl daemon-reload && systemctl enable etcd && systemctl restart etcd " &
done
# 输出结果：
>>> 192.168.1.220
[7] 26642
>>> 192.168.1.221
[8] 26729
>>> 192.168.1.222
[9] 26840
```

- 命令首先创建 etcd 数据目录和工作目录
- etcd 进程首次启动时会等待其它节点的 etcd 加入集群，命令 `systemctl start etcd` 会卡住一段时间，为正常现象

### 检查启动结果

```bash
source ${ETCD_DIR}/environment.sh
for node_ip in ${NODE_IPS[@]}
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


### 验证ETCD集群服务状态

部署完 etcd 集群后，在任一 `etcd` 节点上执行如下命令，我是etcd-0执行的部署操作。

```bash
source ${ETCD_DIR}/environment.sh
for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    /usr/local/bin/etcdctl \
    --endpoints=https://${node_ip}:2379 \
    --cacert=${ETCD_ETC_DIR}/ca.pem \
    --cert=${ETCD_ETC_DIR}/etcd.pem \
    --key=${ETCD_ETC_DIR}/etcd-key.pem endpoint health
done
# 输出结果：
>>> 192.168.1.220
https://192.168.1.220:2379 is healthy: successfully committed proposal: took = 99.689319ms
>>> 192.168.1.221
https://192.168.1.221:2379 is healthy: successfully committed proposal: took = 47.262066ms
>>> 192.168.1.222
https://192.168.1.222:2379 is healthy: successfully committed proposal: took = 49.330772ms
```

ok, etcd集群已经部署完成.