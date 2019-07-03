### 快速部署

> 这里先简单说明下，最近有很多同学在部署的时候遇到了各种各样的问题，很多都是一些文档不仔细/网络不给力/修改了不改修改的配置导致的，所以专门提供了快速部署，让同学们进行快速体验




**注意**

- 单机部署
- 此部署文档不建议线上使用
- 快速部署体验版本为：Beta0.3.0
- 快速部署和分布式稍有不同，不提供全面技术支持，只供体验
- 线上使用强烈推荐分布式部署，更快的熟悉每个功能的用户，偏于后续排错 [分布式部署文档](http://docs.opendevops.cn/zh/latest/install.html)



**部署视频**
> 近期有部分同学反应说部署太麻烦了，为什么不做成一个Docker，其实我们这里单项目已经是Docker部署了，为了更好的让用户更快的了解我们的平台，我们准备了部署视频，[视频入口](https://www.bilibili.com/video/av53446517?from=search&seid=16003251072301252333)


**建议配置**

- 系统： CentOS7+
- CPU：  2Core+
- 内存：  4G+
- 磁盘：  >=50+

**适配系统**
- 测试兼容阿里云CentOS7+
- 测试兼容腾讯云CentOS7+
- 其余平台/系统没有进行多测试


**优化系统**

注意：

- 如果你的系统是新的，我们建议你先优化下系统，此步非必须，同样我们也提供了[优化系统脚本](https://github.com/opendevops-cn/opendevops/tree/master/scripts/system_init_v1.sh)


**快速开始**

- 快速部署脚本下载地址：https://raw.githubusercontent.com/opendevops-cn/opendevops/master/scripts/fast_depoly.sh
```shell  

#下载脚本，赋权执行即可，执行的时候将你的内网IP当作参数传进来
chmod +x fast_depoly.sh
sh fast_depoly.sh <内网IP>  

```  
**访问**

`注意： 这里如果没修改默认域名、且没有域名解析的同学，请访问的时候绑定下本地Hosts，防止访问到我们默认的Demo机器上。`

- 地址：demo.opendevops.cn
- 用户：admin
- 密码：admin@opendevops

**日志路径**

> 若这里访问有报错，请看下日志，一般都是配置错误。
- 日志路径：所有模块日志统一`/var/log/supervisor/`

