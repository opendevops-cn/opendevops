<p align="center">
    <a href="http://www.opendevops.cn/">
        <img width="200" src="http://www.opendevops.cn/images/head_logo.png">
    </a>
</p>


[![Python3](https://img.shields.io/badge/Python-3.6-green.svg?style=plastic)](https://www.python.org/)
[![Tornado](https://img.shields.io/badge/Tornado-5.0-brightgreen.svg?style=plastic)](https://www.tornadoweb.org)
[![Vue.js](https://img.shields.io/badge/Vuejs-2.5-brightgreen.svg?style=plastic)](https://cn.vuejs.org)
[![iview](https://img.shields.io/badge/iview-3.2.0-blue.svg?style=plastic)](https://www.iviewui.com/)


----
CODO是一款为用户提供企业多混合云、自动化运维、完全开源的云管理平台。

CODO前端基于Vue iview开发、为用户提供友好的操作界面，增强用户体验。

CODO后端基于Python Tornado开发，其优势为轻量、简洁清晰、异步非阻塞。

CODO开源多云管理平台为用户提供多功能：ITSM、基于RBAC权限系统、Web Terminnal登陆日志审计、录像回放、强大的作业调度系统、CMDB、监控报警系统等

众多功能模块我们一直在不停的调研和开发，如果你对此项目感兴趣可以加入我们的社区交流群，

同时也希望你能给我们项目一个star，为贡献者加油⛽️！为运维干杯🍻！

----

### 产品架构

![](docs/source/_static/images/project_arch.png)

### 产品功能

![](docs/source/_static/images/pro_fun.png)

### Demo
我们提供了Demo供使用者体验,可点击Try Online Demo快速进行体验。

<a href="https://demo.opendevops.cn/login" target="api_explorer">
  <img src="https://img.alicdn.com/tfs/TB12GX6zW6qK1RjSZFmXXX0PFXa-744-122.png" width="180" />
</a>

`PS: 权限正在调试中，目前Demo用户只有查看权限，且暂不开放用户列表`
- 地址：http://demo.opendevops.cn/login
- 用户：demo
- 密码：2ZbFYNv9WibWcR7GB6kcEY
- MFA: 123456 (还在调，可随意输入)



![](docs/source/_static/images/codo_index.png)


### 开始使用

我们提供多种部署文档，支持快速部署文档和一步步安装。


你也可以查阅我们完整的官方文档：http://docs.opendevops.cn/zh/latest/

- 快速安装：[部署参考](http://docs.opendevops.cn/zh/latest/stand_alone_install.html)
```shell
注： 线上环境我们建议一步步安装方式，这样您能够快速理解每个模块的含义。

$ mkdir -p /opt/codo/ && cd /opt/codo/   #创建代码目录
$ git clone https://github.com/opendevops-cn/opendevops.git  #克隆代码
$ cd opendevops && source env.sh #修改环境变量文件env.sh,主要修改IP地址和域名信息，Token,Key可默认
$ sh -x deploy.sh #一键部署脚本，网络问题/其余问题可重试安装
```
- 分布式安装：[部署参考](http://docs.opendevops.cn/zh/latest/distributed_install.html)



### 模块链接
> CODO 项目我们是使用模块化、微服务化，以下为各个模块地址，同时也欢迎业界感兴趣各位大佬前来贡献

`PS: 项目模板化代码我们正在频繁调试，很快我们就会进行更新代码，请谅解！`
- 前端代码：[codo](https://github.com/opendevops-cn/codo)
- 管理后端：[codo-admin](https://github.com/opendevops-cn/codo-admin)
- 定时任务：[codo-cron](https://github.com/opendevops-cn/codo-cron)
- 任务调度：[codo-task](https://github.com/opendevops-cn/codo-task)
- 资产管理: [codo-cmdb](https://github.com/opendevops-cn/codo-cmdb)
- K8S发布：[codo-k8s](https://github.com/opendevops-cn/codo-k8s)
- 基础发布：[codo-publish](https://github.com/opendevops-cn/codo-publish.git)
- 资源申请：[codo-res_app](https://github.com/opendevops-cn/codo-res_app)




### 感谢贡献者

感谢以下贡献着为Codo(CloudOpenDevOps)的贡献;  
感谢各位的付出，让维护因你们变的不再枯燥、世界因你们而美丽，此排名不分前后，谢谢大家!
  

|Name|Github Avatar|Name| GitHub Avatar                                                       | Name                                              | Github Avatar                                                       |
|---|---|---|---|---|---|
|[laoxu](https://github.com/rootman-xjj) |  ![](https://avatars1.githubusercontent.com/u/46043588?s=70&v=4) | [shenshuo](https://github.com/ss1917)          |  ![](https://avatars3.githubusercontent.com/u/20316110?s=70&v=4)  |  [yangmingwei](https://github.com/yangmv)  |  ![](https://avatars3.githubusercontent.com/u/18107515?s=70&v=4)  |
|[yanghongfei](https://github.com/yanghongfei)           |  ![](https://avatars3.githubusercontent.com/u/22789928?s=70&v=4)  |[shenyingzhi](https://github.com/shenyingzhi) |  ![](https://avatars0.githubusercontent.com/u/20352098?s=70&v=4)  |  [biantingting](https://github.com/biantingting94)  |  ![](https://avatars2.githubusercontent.com/u/32928032?s=70&v=4)  |
|[zhirenyongnan](https://github.com/Aaronzryn) | ![](https://avatars3.githubusercontent.com/u/35439838?s=70&v=4) | [libo](https://github.com/alexbolee) | ![](https://avatars0.githubusercontent.com/u/46021689?s=70&v=4) |  |  |


## License

Everything is [GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).
