### 关于任务系统的一些视频示例

[戳这里观看OpenDevOps任务平台示例视频](https://www.bilibili.com/video/av53424572/)

视频里简单介绍了以下几种示例，至于模板里面的最终逻辑需要使用人根据自己的需求进行排版，编写等，不限制语言。



- 示例1. 平台上提交一个最简单的任务，不带参数的

- 示例2. 平台上提交一个带参数的任务。(PARAMETER)

- 示例3. 平台上基于JSON自定义提交一个任务

- 示例4. 不登陆平台的情况下怎么提交一个任务（脚本提交）

- 示例5. 怎么根据Git Hooks来提交一个任务

- 示例6. 怎么借助定时任务系统每天进行提交一个任务，（比如：备份）




**文档**

视频中涉及到的相关文档

- [Git钩子](http://yanghongfei.me/2019/03/25/git-hooks/)
- [任务模板](http://docs.opendevops.cn/zh/latest/task_template.html



**脚本**

视频中涉及到一些示例脚本

**示例3. 平台上基于JSON自定义提交一个任务， JSON内容**
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

**示例4. 不登陆平台的情况下怎么提交一个任务（脚本提交）**


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


**示例5. 怎么根据Git Hooks来提交一个任务**
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


**示例6. 怎么借助定时任务系统每天进行提交一个任务，（比如：备份）**

这里的脚本和示例4一样，都是向平台提交一个任务，关于定时任务相关的  

- [定时任务部署文档](http://docs.opendevops.cn/zh/latest/codo-cron.html)
- [定时任务使用文档](http://docs.opendevops.cn/zh/latest/timed_task.html)


