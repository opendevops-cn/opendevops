## FAQ

### 邮箱设置问题

> 由于常见的Email有很多，这里列举下最常见的Email设置

- Q: QQ邮箱怎么设置？
- A: QQ邮箱主要注意使用网页生成授权码进行作为密码登陆
    - [SMTP地址](https://service.mail.qq.com/cgi-bin/help?id=28&no=167&subtype=1)：smtp.qq.com
    - SMTP端口：465
    - SSL加密：True, 开启
    - 用   户: <your_qq>@qq.com
    - 密   码： 授权码（一般为16位）



- Q: 腾讯企业邮箱如何设置？
- A: 腾讯企业邮箱同QQ邮箱，唯一一点SMTP服务器不同
    - [SMTP地址](https://service.exmail.qq.com/cgi-bin/help?subtype=1&id=28&no=1000585)：smtp.exmail.qq.com
    - SMTP端口：465
    - SSL加密：True, 开启
    - 用   户: <your_name>@domain.com
    - 密   码： 授权码（一般为16位）



- Q: 网易163邮箱如何设置？
- A: 同上，唯一一点SMTP服务器不同
    - [SMTP地址](http://help.163.com/09/1223/14/5R7P3QI100753VB8.html)：smtp.163.com
    - SMTP端口：465
    - SSL加密：True, 开启
    - 用   户: <your_name>@163.com
    - 密   码： 授权码（一般为16位）



- Q: Gmail邮箱如何设置？
- A: Gmail邮箱考虑到安全，需要注意以下2步
  -  首先开启Google 二步认证
  -  [生成Google 应用专用密码](https://support.google.com/mail/answer/185833?hl=zh-Hans)
  - [SMTP地址](https://support.google.com/mail/answer/7126229?hl=zh-Hans&visit_id=636771670247559816-1235179449&rd=2)：smtp.gmail.com
  - SMTP端口：465
  - SSL加密：True, 开启
  - 用   户: <your_name>@gmail.com
  - 密   码： 授权码（一般为16位）

### Docker Bulid 报错问题

- 安装依赖报错：`Could not install packages due to an EnvironmentError: [Errno 2] No such file or directory: '/tmp/pip-uninstall-y8n2hlf9/usr/local/bin/pip3'`
```
错误信息：
Step 10/16 : RUN pip3 install --upgrade pip
---> Running in 83716c526776

Collecting pip
Downloading https://files.pythonhosted.org/packages/c2/d7/90f34cb0d83a6c5631cf71dfe64cc1054598c843a92b400e55675cc2ac37/pip-18.1-py2.py3-none-any.whl (1.3MB)
Installing collected packages: pip
Found existing installation: pip 10.0.1
Uninstalling pip-10.0.1:
Successfully uninstalled pip-10.0.1
Could not install packages due to an EnvironmentError: [Errno 2] No such file or directory: '/tmp/pip-uninstall-y8n2hlf9/usr/local/bin/pip3'

The command '/bin/sh -c pip3 install --upgrade pip' returned a non-zero code: 1
```
- 解决办法：
```shell

Python3x版本后Docker里面需要加入--user的参数，修改Dockerfile, 加上--user参数， 如：pip3 install --user --upgrade pip
```