## 介绍

### OpenDevOps
[![Python3](https://img.shields.io/badge/Python-3.6-green.svg?style=plastic)](https://www.python.org/)
[![Tornado](https://img.shields.io/badge/Tornado-5.0-brightgreen.svg?style=plastic)](https://www.tornadoweb.org)
[![Vue.js](https://img.shields.io/badge/Vuejs-2.5-brightgreen.svg?style=plastic)](https://cn.vuejs.org)
[![iview](https://img.shields.io/badge/iview-3.2.0-blue.svg?style=plastic)](https://www.iviewui.com/)


----
CODO是一款为用户提供企业多混合云、自动化运维、完全开源的云管理平台。

CODO前端基于Vue iview开发、为用户提供友好的操作界面，增强用户体验。

CODO后端基于Python Tornado开发，其优势为轻量、简洁清晰、异步非阻塞。

CODO开源多云管理平台为用户提供多功能：ITSM、基于RBAC权限系统、Web Terminnal登陆日志审计、录像回放、强大的作业调度系统、CMDB、监控报警系统等

众多功能模块我们一直在不停的调研和开发，如果你对此项目感兴趣可以加入我们的社区QQ交流群：18252156

同时也希望你能给我们项目一个star，为贡献者加油⛽️！为运维干杯🍻！

----

### Microservice

- codo
  - 功能：项目前端
  - 端口：80/443
  - 安装：必须
  - 检测：openresty -t

- codo-admin
  - 功能：管理后端
  - 端口：8010
  - 安装：必须
  - 检测：`curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://mg.opendevops.cn:8010/are_you_ok/`

- codo-cmdb
  - 功能：资产管理
  - 端口：8050
  - 安装：必须
  - 检测：`curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://cmdb2.opendevops.cn:8050/are_you_ok/`

- codo-task
  - 功能：任务系统
  - 端口：8020
  - 安装：必须
  - 检测: `curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://task.opendevops.cn:8020/are_you_ok/`


- codo-cron
  - 功能：定时任务
  - 端口：9900
  - 安装：必须
  - 备注: 单进程，可使用本机IP
  - 检测: `curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://cron.opendevops.cn:9900/are_you_ok/`

- kerrigan
  - 功能：配置中心
  - 端口：8030
  - 安装：必须
  - 检测: `curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://kerrigan.opendevops.cn:8030/are_you_ok/`
  

- codo-tools
  - 功能：运维工具
  - 端口：8040
  - 安装：必须
  - 检测: `curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://tools.opendevops.cn:8040/are_you_ok/`
  
- codo-dns
  - 功能：域名管理
  - 端口：8060
  - 安装：必须
  - 检测: `curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://dns.opendevops.cn:8060/are_you_ok/`
  

  
- codo-scripts
  - 功能：一些示例脚本库，将提供提供示例脚本
  - 端口：N/A，示例脚本没有端口
  - 安装：N/A



### Architecture

- Apigateway代理前端文件
- ApigateWay依赖DNS服务，需要安装Dnsmasq
- 微服务部署完成后，需在Apigateway进行注册
- 一台MySQL Master示例，不同的微服务使用单独的库


![](./_static/images/architecture.png)
