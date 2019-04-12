### 快速安装

> 快速部署文档使用Shell脚本部署安装，此部署安装仅供参考，供用户快速体验使用

> 若线上使用我们建议用户一步步安装，并熟悉每个组件的用途，请参考： [分布式安装](http://docs.opendevops.cn/zh/latest/distributed_install.html)


**注意**

- 国内Github速度慢问题
- Docker默认镜像源下载慢问题

**建议配置**

- 系统： CentOS7+
- CPU：  2Core+
- 内存：  4G+
- 磁盘：  >=50+

**环境介绍**

- codo
  - 功能：项目前端
  - 端口：80/443
  - 安装：必须
  - 检测：openresty -t

- codo-admin
  - 功能：管理后端
  - 端口：8001
  - 安装：必须
  - 检测：`curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://$mg_domain:8010/are_you_ok/`

- codo-cmdb
  - 功能：资产管理/跳板审计
  - 端口：8002
  - 安装：必须
  - 检测：`	curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://${cmdb_domain}:8002/v1/cmdb/`

- codo-task
  - 功能：任务系统
  - 端口：8020
  - 安装：必须
  - 检测: `curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://${cron_domain}:9900/are_you_ok/`


- codo-cron
  - 功能：定时任务
  - 端口：9900
  - 安装：必须
  - 检测: `curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://${cron_domain}:9900/are_you_ok/`

- kerrigan
  - 功能：配置中心
  - 端口：8030
  - 安装：必须
  - 检测: `curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://${kerrigan_domain}:8030/are_you_ok/`

- codo-check
  - 功能：代码检查
  - 端口：N/A，示例脚本没有端口
  - 安装：可选

- codo-publish
  - 功能：发布脚本
  - 端口：N/A，示例脚本没有端口
  - 安装：可选

- codo-res_app
  - 功能：资源申请
  - 端口：N/A，示例脚本没有端口
  - 安装：可选


**开始使用**

`注意注意： depoly.sh后续不维护，后续会更新其余快速部署方式。`

- 所有项目都放到/opt/codo/
- 修改环境变量文件env.sh,主要修改IP地址和域名信息，Token,Key可默认
- Other,由于没法完全适配环境，网络问题/其余常见报错问题请自行处理重试安装。
- 若部署项目报错退出，如：codo-cmdb等，请删除项目路径重新执行脚本。`rm -rf /opt/codo/codo-cmdb`


```shell
$ mkdir -p /opt/codo/ && cd /opt/codo/   #创建代码目录
$ git clone https://github.com/opendevops-cn/opendevops.git  #克隆代码
$ cd opendevops && source env.sh #修改环境变量文件env.sh,主要修改IP地址和域名信息，Token,Key可默认
$ sh -x deploy.sh  #一键部署脚本，网络问题/其余问题可重试安装
```


