# 最佳实践

[[toc]]

::: tip

视频里简单介绍了以下几种示例，至于模板里面的最终逻辑需要使用人根据自己的需求进行排版，编写等，不限制语言。

[戳这里观看OpenDevOps任务平台示例视频](https://www.bilibili.com/video/av53424572/)
:::

::: details 点我展开
- 示例1. 平台上提交一个最简单的任务，不带参数的（视频）

- 示例2. 平台上提交一个带参数的任务。(PARAMETER)（视频）

- 示例3. 平台上基于JSON自定义提交一个任务
```
{
	"task_name": "这是通过JSON提交的任务",
	"submitter": "yanghongfei", 
	"temp_id": "1", 
	"schedule": "ready",   
	"exec_time": "2019-5-24 09:09:50", 
	"associated_user": "{'group-1': ['杨红飞']}",
	"args": "{'VERSION':'你可以看到我这次传入的参数是VERSION，但是显示成了版本，是因为我在参数管理里面设置了别名'}",
	"details": "这里是备注",
	"hosts": "{1: '172.16.0.101'}"  
}
```

- 示例4. 不登陆平台的情况下怎么提交一个任务（POST API提交）
```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Author  : Fred Yangxiaofei
# @File    : codo_post_task.py
# @Role    : 利用脚本向平台提交一个任务

import json
import datetime
import requests


def post_task(temp_id, schedule):
    """
    :param temp_id:  模板ID，平台里面任务模板里面查看
    :param task_status: 提交任务的状态，常用的为：ready: 表示不需人工干预，平台直接执行，new: 平台需要选择审批。根据审批时间执行。
    :return:

    """

    #平台接口连接，这里只需要修改域名即可， 任务API连接都是我们内置进去的，在【用户管理】-【权限列表】 权限名称：钩子提交任务
    accept_task_url = 'https://<域名地址>/api/task/v2/task/accept/'

    #这里就是一个长期Token，管理员可以在用户列表选择一个用户进行生成一个长期Token，这个用户需要有权限名称：钩子提交任务的权限
    auth_key = "yODk4MDX19.BgP8UAoNiBkzJNSN1pa-eQVjlAxrKGxYZf0YgvXv39k"


    # 执行主机IP地址, 1代码第一组
    hosts = {1: '172.16.0.101'}
    #这里都是传入的参数
    args = {
        "TAG": 'codo-beta0.3',
        "GIT_URL": "git@gitlab.xxxxxxx.com:xxxxx/xxxxx.git",
        "APP_NAME": "Web"
    }
    the_body = json.dumps({
        "task_name": "脚本任务", #修改此项
        "temp_id": temp_id,
        "args": str(args),
        "details": "通过脚本提交一个自定义的任务",
        "hosts": str(hosts),
        "submitter": "yanghongfei",
        "exec_time": datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        "schedule": schedule,
        "executor": "yanghongfei"
    })


    req1 = requests.get(accept_task_url, cookies=dict(auth_key=auth_key))
    csrf_key = json.loads(req1.text)['csrf_key']
    cookies = dict(auth_key=auth_key, csrf_key=csrf_key)
    req = requests.post(accept_task_url, data=the_body, cookies=cookies)
    req_code = json.loads(req.text)['code']
    if req_code != 0:
        # print(json.loads(req.text)['msg'])
        print('task commit failed Please contact  OPS Group')
        exit(-111)
    else:
        # print(json.loads(req.text)['msg'])
        print('Asynchronous task has been submitted successfully!!!')
        print('Please do not submit multiple times to prevent the task from jamming!!!')


if __name__ == '__main__':
    print(post_task('1', 'new'))

```

- 示例5. 怎么根据Git Hooks来提交一个任务
主要基于`GitLab Custom Hooks`和`GitLab Tag`借助opendevops平台实现自动化发布，以下为所用到的功能简单介绍。
这里基本上和上面一样，就是多一个怎么用`update`钩子获取Tag

**为什么使用Git TAG发布,然后再接到平台里面呢？**

- 进度可视化
- 平台发布记录
- Git Tag 可快速回滚
- 权限控制，可由PM登陆平台审核后发布
- 可定时执行，报错可重装，不同项目需求可根据实际编写脚本进行排版任务等。


**配置钩子**

[GitLab Hooks](https://docs.gitlab.com/ee/administration/custom_hooks.html)分为2种：

- Hooks：全局钩子，适用于所有项目
- Custom Hooks： 项目钩子，针对项目来做钩子触发任务

如何使用？

本章主要使用项目钩子，不建议使用全局钩子，这样会出问题，亲自尝试，毕竟我们的需求是针对xxx项目进行做自动化发布的。
  
  
登陆GitLab服务器操作  

```shell

$ cd <project_name>.git/
$ mkdir -p custom_hooks ; chown -R git.git custom_hooks; chmod 777 custom_hooks

```
  
 
创建[Update](http://yanghongfei.me/2019/03/25/git-hooks/)钩子


```python

#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019/5/24 10:31
# @Author  : Fred Yangxiaofei
# @File    : git_tag_post_task.py
# @Role    : 基于Git Tag来提交一个任务



import sys
import json
import datetime
import requests
import re

def post_task(tag, temp_id, schedule):
    """
    :param temp_id:  模板ID，平台里面任务模板里面查看
    :param task_status: 提交任务的状态，常用的为：ready: 表示不需人工干预，平台直接执行，new: 平台需要选择审批。根据审批时间执行。
    :return:

    """

    #平台接口连接，这里只需要修改域名即可， 任务API连接都是我们内置进去的，在【用户管理】-【权限列表】 权限名称：钩子提交任务
    accept_task_url = 'https://<域名地址>/api/task/v2/task/accept/'

    #这里就是一个长期Token，管理员可以在用户列表选择一个用户进行生成一个长期Token，这个用户需要有权限名称：钩子提交任务的权限
    auth_key = "eyJ0eXAiOiTUyODk4MDg1LCJpc3McxODA2MCIsImRhdGEiOnsidXNlcl9pZCI6IWJsaXNoIiwibmlja25hbWUiOiJwdWJsaXNoIiwiaXNfc3VwZXJ1c2VyIjpmYWxzZX19.BgP8UAoNiBkzJNSN1pa-eQVjlAxrKGxYZf0YgvXv39k"


    # 执行主机IP地址, 1代码第一组
    hosts = {1: '172.16.0.101'}
    #这里都是传入的参数
    args = {
        "TAG": tag,
        "GIT_URL": "git@gitlab.xxxxxxx.com:xxxxx/xxxxx.git",
        "APP_NAME": "Web"
    }
    the_body = json.dumps({
        "task_name": "脚本任务", #修改此项
        "temp_id": temp_id,
        "args": str(args),
        "details": "通过脚本提交一个自定义的任务",
        "hosts": str(hosts),
        "submitter": "yanghongfei",
        "exec_time": datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        "schedule": schedule,
        "executor": "yanghongfei"
    })


    req1 = requests.get(accept_task_url, cookies=dict(auth_key=auth_key))
    csrf_key = json.loads(req1.text)['csrf_key']
    cookies = dict(auth_key=auth_key, csrf_key=csrf_key)
    req = requests.post(accept_task_url, data=the_body, cookies=cookies)
    req_code = json.loads(req.text)['code']
    if req_code != 0:
        # print(json.loads(req.text)['msg'])
        print('task commit failed Please contact  OPS Group')
        exit(-111)
    else:
        # print(json.loads(req.text)['msg'])
        print('Asynchronous task has been submitted successfully!!!')
        print('Please do not submit multiple times to prevent the task from jamming!!!')


def main():
    '''获取TAG'''
    tag = sys.argv[1].split("/")[-1]
    qa = re.match(r'\Aqa-yanghongfei[\w]*',tag)     #测试 ，直接执行,ready
    release = re.match(r'\Arelease-yanghongfei[\w]*',tag)   #正式,需要审核,new

    if qa:
        print(post_task(tag, '1','ready'))
    elif release:
        print(post_task(tag, '1','new'))
    else:
         print(tag)



if __name__ == '__main__':
    main()

```


配置好钩子后，接下来克隆版本库进行提交测试　


```shell

git clone git@gitlab.xxxxxx:xxx/xxx.git
git pull

echo "README" > README.md
git add --all
git commit -m "[Add] README,测试发布"
git push -u origin origin
git tag release-yanghongfei-v1  
git push -u origin release-yanghongfei-v1  #把tag推送上去

```
:::




### 基于任务平台实现Git发布示例

::: tip
本章节实验环境主要基于`GitLab Custom Hooks`和`GitLab Tag`借助opendevops平台实现自动化发布，以下为所用到的功能简单介绍。
:::

::: details 点我展开

你需要具备以下环境：

- [GitLab](https://github.com/gitlabhq/gitlabhq/blob/master/doc/install/README.md)
- [GitLab Hooks](http://yanghongfei.me/2019/03/25/git-hooks/)
- [GitLab Depoly Keys](http://yanghongfei.me/2019/03/19/gitlab-api-enable-depoly-key/)
- [OpenDevOps 开源自动化运维平台](http://www.opendevops.cn/)


**发布为什么选择过OpenDevOps平台**

- 进度可视化
- 平台发布记录
- Git Tag 可快速回滚
- 权限控制，可由PM登陆平台审核后发布
- 可定时执行，报错可重装，不同项目需求可根据实际编写脚本进行排版任务等。



**快速使用**

> 这里废话不多说，直接上实践，至于Tag、Hooks、Depoly Keys不熟悉的请参考以上链接，也可自行百度。
发布流程：`enable depoly keys`->`git clone`–>`git pull`—>`git checkout <tag>`—>`rsync_code`—>`code_backup`—>`publish code`->`publish OK~`，平台历史记录可查看发布信息


**创建模板**

- 记下模板ID
- 模板执行顺序自行排版
- [opendevops模板使用说明](https://docs.opendevops.cn/zh/guide/used/#%E4%BB%BB%E5%8A%A1%E6%A8%A1%E7%89%88)
![](/005X1wn0gy1g1ewg3sgrrj31gk0n7n0o.jpg)


**配置钩子**

[GitLab Hooks](https://docs.gitlab.com/ee/administration/custom_hooks.html)分为2种：

- Hooks：全局钩子，适用于所有项目
- Custom Hooks： 项目钩子，针对项目来做钩子触发任务

如何使用？

本章主要使用项目钩子，不建议使用全局钩子，这样会出问题，亲自尝试，毕竟我们的需求是针对xxx项目进行做自动化发布的。
  
  
登陆GitLab服务器操作  

```shell

$ cd <project_name>.git/
$ mkdir -p custom_hooks ; chown -R git.git custom_hooks; chmod 777 custom_hooks

```
  
 
创建[Update](http://yanghongfei.me/2019/03/25/git-hooks/)钩子


> 这里我有已经运行2年的脚本供各位参考。

```python 
 
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Author  : Fred Yangxiaofei
# @File    : new_hook_for_update.py
# @Role    : 利用gitlab Tag触发钩子像平台提交任务

import sys
import json
import datetime
import requests
import re


def post_task(tag, temp_id, schedule):
    """
    :param tag:      从gitlab钩子获取TAG信息
    :param temp_id:  模板ID，平台里面任务模板里面查看
    :param task_status: 提交任务的状态，常用的为：ready: 表示不需人工干预，平台直接执行，new: 平台需要选择审批。根据审批时间执行。
    :return:

    """
    #这里是浏览器Cookie里面auth_key，可使用超级管理员用户，平台获取长期auth_key
    auth_key = "va2VuIsImRhdGEiOnsi9.BgP8UAoNiBkzJNSN1pa-eQVjlAxrKGxYZf0YgvXv39k"  
    # 这里hosts必须是IP，CODO平台只走的是SSH协议，需要在执行用户配置链接主机的key,或者自行打通。
    hosts = {1: '118.25.xx.xx'}  # 上海Salt IP，执行主机IP。
    args = {
        "TAG": tag,
        "GIT_URL": "git@gitlab.xxxxxxx.com:xxxxx/xxxxx.git",  # 修改此项
        "APP_NAME": "DBTT"  # 修改此项
    }
    the_body = json.dumps({
        "task_name": "DBTT", #修改此项
        "temp_id": temp_id,
        "args": str(args),
        "details": "git hook auto exec",
        "hosts": str(hosts),
        "submitter": "githook",
        "exec_time": datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        "schedule": schedule,
        "executor": "githook"
    })

    accept_task_url = 'https://codo-v1.domain.com/api/task/v2/task/accept/'
    req1 = requests.get(accept_task_url, cookies=dict(auth_key=auth_key))
    csrf_key = json.loads(req1.text)['csrf_key']
    cookies = dict(auth_key=auth_key, csrf_key=csrf_key)
    req = requests.post(accept_task_url, data=the_body, cookies=cookies)
    req_code = json.loads(req.text)['code']
    if req_code != 0:
        # print(json.loads(req.text)['msg'])
        print('task commit failed Please contact  OPS Group')
        exit(-111)
    else:
        # print(json.loads(req.text)['msg'])
        print('Asynchronous task has been submitted successfully!!!')
        print('Please do not submit multiple times to prevent the task from jamming!!!')

def get_tag():
    '''获取TAG'''
    tag = sys.argv[1].split("/")[-1]
    qa = re.match(r'\Aqa-dbtt[\w]*',tag)     #测试
    release = re.match(r'\Arelease-dbtt[\w]*',tag)   #正式

    if qa:
        print(post_task(tag, '32','ready'))  #这是模板ID
    elif release:
        print(post_task(tag, '32','ready'))  #这是模板ID
    else:
         print(tag)


if __name__ == '__main__':
    get_tag()


```


配置好钩子后，接下来克隆版本库进行提交测试　


```shell

git clone git@gitlab.xxxxxx:xxx/xxx.git
git pull

echo "README" > README.md
git add --all
git commit -m "[Add] README,测试发布"
git push -u origin origin
git tag release-dbtt-server-20190320-02  #这里只要能让钩子里面正则匹配到dbtt-release都会被触发
git push -u origin release-dbtt-server-20190320-02  #把tag推送上去

```

最终的结果

![](/005X1wn0gy1g1exnc0cv9j30uc0iw75r.jpg)
:::




### 基于配置中心管理dnsmasq示例
::: tip
这是一篇关于如何基于配置中心来图形化管理你的内网DNS，一般来说互联网企业里面都会部署自己内部的DNS服务，来提升解析速度。本示例dnsmasq，关于bind DNS域名管理是平台的一个单独模块。
:::

::: details 点我展开

**环境说明**

> Q: 为什么要配置到平台上？
>
> A：假如你内网DNS有多台，即使是管理简单的dnsmasq服务，你也要手动登录机器进行编辑配置文件，很麻烦，机器上直接操作是非常危险的，且没有回滚功能，一不小心就可能导致出错，Server 挂掉等。所以在此借助配置中心模块简单记录下，配置中心支持图形化操作、对比、回滚等操作

- OpenDevOps平台
- 配置中心模块
- 任务模板
- 内网DNS服务(dnsmasq)



**如何使用**

**开始之前你可以点击以下视频链接，看下最终效果，看此操作是否可以满足你的需求**

[Youtube](https://www.youtube.com/watch?v=jM8DSbUh0Rs&t=47s) | [BiliBili](https://www.bilibili.com/video/av53460519/)



**登录配置中心新建一个项目**

![](/add_config.png)

**对项目进行赋权**

新建的项目默认只有创建人才有权限， 需要赋权，其余用户才可以看到/拉取配置文件详情

![](/user_auth.png)

**获取一个用户的长期Token**

这个用户必须有你这个项目的权限才可以，然后获取到这个用户的长期Token，后面脚本要用到

![](/get_token.png)



**服务器上拉取配置**

这里需要在服务器上放一个拉取配置中心配置的一个脚本，逻辑就是，通过一个有权限的用户—拉取指定的配置信息—将配置同步到你的server上—-reload服务

这里提供一个配置脚本示例(dnsmasq)，更详情的脚本可参考[配置中心](https://github.com/opendevops-cn/kerrigan/blob/master/libs/get_config.py)

示例脚本放到DNS服务器目录：`/data1/shell/dns_publish.py`

```python
#!/usr/bin/env python
# -*-coding:utf-8-*-
"""
Contact : 191715030@qq.com
Author  : shenshuo
Date    : 2019/1/29
Desc    : 获取配置文件内容，
          要确保有全局权限 /kerrigan/v1/conf/publish/
          要确保有当前项目配置获取权限
"""

import os
import requests
import json
import subprocess



def exec_shell(cmd):
    '''执行shell命令函数'''
    sub2 = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    stdout, stderr = sub2.communicate()
    ret = sub2.returncode
    return ret,stdout.decode('utf-8').strip()



class ConfApi:
    def __init__(self):
        # self.auth_key 是一个长期Token，基于用户管理里面，管理员选中用户生成长期Token，默认发送到用户邮箱
        self.auth_key = 'eyJ0eXAiOiJKV1QiLCJhbmZpZyIsIm5pY2XcFBbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTMwMzQyNzYsIm5iZiI6MTU1Nzk5NDI1NiwiaWF0IjoxNTU3OTk0Mj3ZjZlXHU3NTI4XHU2MjM3IY2LCJpc3MiOiJhdXRoOiBzcyIsInN1YiI6Im15IHRva2VuIiwiaWQiOiIxNTYxODcxODA2MCIsImRhdGEiOnsidXNlcl9pZCI6NjYsInVzZXJuYW1lIjoiZ2V0X2NvFOOo'
        self.conf_path ='/tmp'
        self.conf_config_api = "https://codo.domain.com/api/kerrigan/v1/conf/publish/config/"   #配置中心获取API



    def get_config_details(self, project_code, environment, service, filename):
        # 获取配置文件内容,  2019-04-28支持URL auth_key登陆，不需要再登陆进行获取auth_key，直接生成长期Token用
        #__token = self.login()

        __token = self.auth_key
        try:
            _params = {'project_code': project_code, 'environment': environment,'service':service,'filename':filename, 'auth_key': __token}
            res = requests.get(self.conf_config_api, params=_params)
            ret = json.loads(res.content)
            if ret['code'] == 0: return ret['data']
        except Exception as e:
            print('[Error:] 发布配置接口连接失败，错误信息：{}'.format(e))
            exit(-2)



    def create_config_file(self, project_code, environment, service, filename):
        # 生成配置文件
        config_data = self.get_config_details(project_code, environment, service, filename)
        for k,v in config_data.items():
            config_file = self.conf_path + k
            dir_name, _ = os.path.split(config_file)
            if not os.path.exists(dir_name):
                os.makedirs(dir_name)
            with open(config_file ,'w') as f:
                f.write(v)
        #     print('config file path is {}'.format(config_file))
        # print('success')
        return config_file  #返回文件路径


    def rsync_file(self, config_file):
        """
        同步文件
        :return:
        """
        #目标文件名：
        target_file_name = config_file.split('/')[-1]
        cmd = 'rsync -avz {}  /etc/{}'.format(config_file,target_file_name)
        ret, stdout = exec_shell(cmd)
        if ret != 0:
            print('[ERROR]: 文件同步失败'.format(target_file_name))
            return False
        print('[Sucess]: {}文件同步成功'.format(target_file_name))

    def reload_service(self):
        cmd = 'service dnsmasq reload'
        ret, stdout = exec_shell(cmd)
        if ret != 0:
            print('[ERROR]: 服务启动失败')
            return False
        print('[Sucess]: 服务reload成功')


def main():
    obj = ConfApi()
    config_file = obj.create_config_file('DNS', 'release', 'dnsmasq', 'dnsmasq.conf')
    hosts_config_file = obj.create_config_file('DNS', 'release', 'dnsmasq', 'dnsmasq_hosts')
    if config_file:
        obj.rsync_file(config_file)

    if hosts_config_file:
        obj.rsync_file(hosts_config_file)

    obj.reload_service()

if __name__ == '__main__':
    main()
```

运行查看结果：

```python
python3 /data1/shell/dns_publish.py
[Sucess]: dnsmasq.conf文件同步成功
[Sucess]: dnsmasq_hosts文件同步成功
[Sucess]: 服务reload成功
```

其实到了这一步，基本配置已经完成了，由于这个DNS每次修改后配置都要reload服务，所以不建议放到crontab里面进行轮训配置，接下来配置下发布，IT人员修改后配置，点下发布进行触发


**配置DNS发布**



**新建一个Tag，将机器添加进去**

![](/add_dns_tag.png)

**新建命令和模板配置**

这里是发布的时候选择我们自己排序的模块任务

![](/add_dns_bash.png)

![](/add_dns_temp.png)

**提交一个自定义任务**

![](/commit_dns_task.png)



**审批任务**

![](/approval_dns_task.png)



**执行结果**

![](/dns_task_res.png)

如果出错可以查看日志进排查，也可以重做，终止等操作

![](/dns_task_log.png)
:::








