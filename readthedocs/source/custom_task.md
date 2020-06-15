### 添加自定义任务



#### 前言

> 随着云的发展，至今有很多云厂商：AWS、阿里云、腾讯云、华为云等，多账户之间管理起来对运维来说属实是挺头疼的，如果你的公司即是多云，业务也是国内海外都有的情况下，由于每家的操作也不同，必然会觉得维护起来很疲惫，这里简单记录下我们从购买-初始化的使用示例，仅供参考



#### 环境

- 平台
  - [OpenDevOps开源平台](http://www.opendevops.cn/)
  - 任务模板功能
- 云厂商
  - AWS 亚马逊
- 服务
  - EC2
  - Redis
  - RDS
  - S3
  - CloudFront
  - Godaddy
  - ZABBIX
  - ...........省略若干行
- 工具
  - Postman



#### 如何使用

>  这一步首先需要你已经使用了我们的开源平台，地址：https://github.com/opendevops-cn/opendevops
>
> 废话不多说，接下来直接上操作，具体关于任务模板介绍请参考：http://docs.opendevops.cn/zh/latest/task_template.html



##### 模拟登陆

- 登陆POST接口：https://doamin.com/api/accounts/login/

- POST数据

  ```
  {
   "username":"yanghongfei", #用户名
   "password":"password", #你的密码
   "dynamic":"732578"  #二次认证动态码
  }
  ```

- 登陆成功如下图：

![](https://ws1.sinaimg.cn/large/005X1wn0gy1g1bnhte39cj316d0neq4h.jpg)



##### 模拟登陆成功后要进行获取下Key

- GET接口：https://domain.com/api/task/v2/task/accept/

第一次使用需要获取下Key，直接GET 任务接口就可以，成功如下图

![](https://ws1.sinaimg.cn/large/005X1wn0gy1g1bnkch2pbj31630huwf3.jpg)

##### 登陆平台，创建模板

- 添加你的脚本命令

![](https://ws1.sinaimg.cn/large/005X1wn0gy1g1bno2m6n6j31g70os0wj.jpg)

- 创建执行命令

![](https://ws1.sinaimg.cn/large/005X1wn0gy1g1bnpq9db3j31gg0lu76n.jpg)

- 创建模板并进行排版

> 这里需要注意的是
>
> 1. 执行用户的选择， 下面POSTMAN提交数据的时候会有一个字段是HOST，这里一定要确认你选择执行用户，可以通过密钥登陆你的执行主机。类似：`ssh -i xxxx.pem <username>@<ip_address>`
> 2. 模板的ID，一会POSTMAN模拟提交的时候要用到
> 3. 参数， 里面的参数都是你的脚本逻辑，需要传哪些参数自己定义，这些参数统一在args字典里面传过来

![](https://ws1.sinaimg.cn/large/005X1wn0gy1g1bns609akj311z0iajti.jpg)



##### 以上，创建完成后，我们开始使用POSTMAN进行提交数据

- POST接口：https://domain.com/api/task/v2/task/accept/

- POST数据

  - task_name: 任务名字
  - submitter: 提交人
  - temp_id： 模板ID，就是你上面创建模板时候生成的那个ID
  - schedule： 这是状态，常用的有ready和new
    - ready：表示不通过人工审核，只要到了执行时间直接执行任务
    - new： 表示需要任何审核，管理员审核，选择执行时间，到时间后开始执行
  - exec_time： 任务执行时间，状态为ready的情况下，到这个时间会进行执行

  - args：这里是一个字典，里面的参数可以自行定义，如上，你模板参数里面用到了哪些你都可以在这里定义出来，当你的POST到这个接口时候，我们会自动接受此参数，并帮你运行脚本 解析你要传入的参数。
  - details： 描述，备注信息
  - hosts： 这个是执行主机，字典形式，
    - 1表示第一组主机，也就是上面模板里面的组1，任务支持多组。
    - 主机IP，这个是执行主机，这个废话多一点，比如我以上模板的脚本在172.16.0.101这台主机上，我就想平台登陆我这个主机，来帮我执行这些脚本，至于怎么登陆，那么就是我最开始在平台里面配置了一个执行用户，我将我这个主机的私钥放到了平台上，公钥在我服务器上，这样子CODO平台就可以ssh -i xxxx.pem <username>@<ip_address>远程到我的主机上帮我执行命令。

  ```json
  {
  "task_name":"这是任务名字",    
  "submitter":"杨红飞",
  "temp_id": "35",
  "schedule":"ready",
  "exec_time":"2019-03-22 16:09:50",
   "args": "{'HOSTNAME': 'FT-VA-01-web01,FT-VA-01-web02', 'INSTANCE_TYPE': 'c5.2xlarge', 'RDS_TYPE': 'None', 'RDS_CLUSTER': 'M1', 'RDS_SIZE': '100', 'REDIS_TYPE': 'cache.r4.large', 'ALB': 'yes', 'DOMAIN': 'yes', 'CDN': 'yes', 'END_TIME': '', 'ENV': 'php72,python3,nginx,zabbix,salt'}",
   "details":"这是自动化购买AWS资源组",
   "hosts": "{1: '172.16.0.101'}"
  }
  ```

- 返回结果

```
{
    "code": 0,
    "msg": "Task creation success, ID：291",
    "list_id": 291
}
```



#####  登陆平台查看订单

- 订单参数详情

![](https://ws1.sinaimg.cn/large/005X1wn0gy1g1bob82jtij31ey0fqta6.jpg)

- 订单状态

![](https://ws1.sinaimg.cn/large/005X1wn0gy1g1bob82p05j310e0kbgne.jpg)

![](https://ws1.sinaimg.cn/large/005X1wn0gy1g1bob82rnqj310p0jxjt6.jpg)


以上，只是为AWS购买资源组简单说明，你可以根据你自己的需求任意排版，不限语言，不限制主机，可执行，可登陆即可，已任务形式进行，模板有权限控制，任务有权限控制，操作记录，历史记录，定时执行，手工干预，这里任务系统包含了很多组件等待你的体验，若你也喜欢我们的项目，请你给项目点一个Star，让我们给贡献者点动力。



以下是我们目前已完成模块和用户使用交流群，欢迎你的加入。

![](https://ws1.sinaimg.cn/large/005X1wn0gy1g1boj8xgupj31gp0nrgqe.jpg)

