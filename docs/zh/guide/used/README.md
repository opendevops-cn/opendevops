# 如何使用
[[toc]]

::: tip
这部分主要是使用文档
:::


## 任务模版

> 这部分文档主要用来介绍任务模板，任务模板：可以帮助你实现一个很强大、很复杂、可干预、自定义的任务流程模板；  
> 任务模板功能主要分为：命令管理、模板管理、参数管理、执行用户等部分，由于这块稍微有点难理解，我们提供了[示例文档](https://docs.opendevops.cn/zh/guide/more/example/)和[视频演示](https://www.bilibili.com/video/av53424572/)



**命令管理**
> 主要用于创建你的自定义命令，后续供平台执行使用

**功能特点**
- 支持`Linux Bash`命令
- 支持自定义脚本命令(不限语言)
- 全局命令统一管理、详细记录展示
- 命令可视化编辑、搜索、新增、删除等操作

**如何使用**

点开`任务模板`->`命令管理`
- 新建命令
  - 命令名称：输入你的名称(建议是有意义的名字，后续方便你勾选使用)
  - 执行命令：可以是`Linux Bash`命令，如：`ls,free -m`，也可以是一个执行脚本，如：`python3 xxx.py`
  - 命令参数：这里一般用于执行脚本传入参数，如：`pytho3 xxx.py --host=127.0.0.1`，这里就可以填入自身参数：`--host=127.0.0.1`, 可留空，也可后续使用到修改
  - 强制主机：默认可为空，用于你所填写的命令强制指定哪个主机上进行执行（注意：你所指定的这台机器IP，此平台必须可以登陆过去，否则无法执行，CODO平台如何登陆所指定的主机IP请参考`执行用户`文档）


![](/create_bash.png)

示例图：

![](/bash_list.png)


**模板管理**
> 模板管理是一个核心功能，这里逻辑稍有复杂、但功能极为强大，这里主要用于自定义你的任务流程。

**功能特点**
- 支持自定义模板流程
- 支持多组多优先级并发执行
- 自定义流程可人工干预、可定时执行
- 模板可搜索、可编辑、可删除、模板权限细分等


**如何使用**  

点开`任务模板`->`模板管理`
- 创建模板
  - 模板名称： 建议输入一个有意义的名称，注意：`此名称不可更改`

![](/template_create.png)

**如何对模板赋权**
> 模板赋权是☞哪些用户可以对此模板有权限（编辑、删除、修改等），管理员默认拥有所有权限。

点开点开`任务模板`->`模板管理`->`授权`-`选择关联的用户`


**自定义你的模板流程**

首先我们已经创建了一个新的模板，接下来我们向模板里面添加一些自定义的内容
- 1、选中你的模板
- 2、下拉选择你的命令进行提交（支持同时选择多个哦~）
- 3、修改模板流程中的字段信息
- 4、最后记得保存编辑

示例：

![](/select_bash.png)

下图字段说明：
- 组：默认为：88， 请修改为：1， 默认从第一组开始执行（多组配置示例见下图）
- 优先级： 执行命令的优先级，修改对应数字即可
- 任务名称： 此任务名称是你`命令管理`命令名称，自动带出
- 执行命令： 此执行命令是你`命令管理`执行命令，自动带出
- 参数：此参数是你`命令管理`参数，自动带出，`参数例如：--host=127.0.0.1 --group=game01`空格隔离第二个参数
- 执行用户： 此执行用户用于登陆你的执行主机，从`任务模板->执行用户`里面选择，详细见`执行用户`部分使用说明
- 触发器：可选默认（默认直接执行）、定时（到达时间后开始执行，此时间是提交任务的时候指定的时间）、干预（需要手动触发执行）
- 指定主机：指定那台主机执行此命令，IP地址形式，`CODO平台需要能登陆此主机`
- 删除： 删除所选项


单组配置示例：

![](/template_edit.png)

多组配置示例：

![](/s_group_template.png)


**参数管理**
> 参数名称类似于别名的概念，订单显示时参数值会被参数名称替代

多组配置示例：

​                        ![](/parameter.png)

**执行用户**

> 执行用户：主要用于登陆命令管理/模板管理里面指定的主机的验证，任务一般都是通过SSH进行远程执行、编排模板的时候需要选择一个用户进行登陆主机

**如何使用**
点开`任务模板`->`执行用户`

- 新建用户
  - 用户名称：如：`root, ops`此系统用户，注意：`此用户是Linux系统用户哦~`
  - SSH端口：你的SSH端口，如：`22`
  - 备注：描述用途使用
  - 用户私钥：服务器机器的私钥，一般默认生成的为：`id_rsa`

若你的机器没有私钥，你可以手动生成一堆公钥私钥进行放置到服务器~/.ssh/目录下，参考命令：
```shell
#生成密钥对
$ ssh-keygen -t rsa
# 将公钥加到`authorized_keys`文件
$ [ ! -d /root/.ssh ] && mkdir /root/.ssh ; [ ! -f /root/.ssh/authorized_keys ] && touch /root/.ssh/authorized_keys ; cat /root/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && echo ok
```

新建执行用户示例：

![](/create_exec_user.png)

![](/exec_user_list.png)



## 任务发布

> 这部分主要介绍代码发布的配置和一些SQL相关配置(更新中)，任务发布后续将会支持更多业务模块，目前以任务发布和SQL优化审核相关的配置为主；

**操作教学视频**：[https://www.bilibili.com/video/av53424572/](https://www.bilibili.com/video/av53424572/ ) 

**应用发布**

>该模块是任务发布主要功能，预先配置你代码发布的相关信息，设定时间自动执行。

例举例一个简单发布示例：

>请选择你要发布的应用，具体配置参考【作业配置】-【应用配置】。发布权限关联代码仓库权限【作业配置】-【代码仓库】。

**创建应用发布**

点开`应用发布`

- 选择应用：下拉选择在作业配置中配置的应用配置
- 标签版本：输入你的TAG
- 自定义参数：前面定义参数，后面填写对应值(例如：[IP] [203.167.11.100] )
- 开始时间：选择一个执行时间，来触发模板中的定时触发器
- 备注详情：填写你发布应用的标识

![](/app_publish_1.png)

**SQL审核**

>该模块用来将要执行的SQl语句的提交给审批人进行审批，审批通过后才会在指定时间执行该SQL语句

**注意**
- 1.当前页面使用标签关联相关数据库，选取标签下的mysql的写库
- 2.本服务多部署在内网，为了适配多云多区域，需要经过代理连接数据库，标签里面应配置代理主机，当前任务会跳转到代理主机执行数据库审核
- 3.请使用标准的SQL语句，从语句上选择数据库。
- 4.使用内建模板ID：9001主机组为1在没有熟悉模板的使用之前，不要随意更改相关任务模板

点开`SQL审核`

- 目标标签：下拉选择你要关联的标签组
- SQL语句：填写要执行的SQL语句
- 审批人员：下拉选择你要提交审核的用户

![](/sql_auth.png)

**SQL优化**

>该模块用于优化SQL语句，输入要执行的SQL语句然后进行平分和优化等操作

**注意**

- 1.当前页面使用标签关联相关数据库，选取标签下的mysql,SQL优化使用内建模板ID：9901主机组为1，在没有熟悉模板的使用之前，不要随意更改相关任务模板
- 2.本服务多部署在内网，为了适配多云多区域，需要经过代理连接数据库，标签信息里面应配置代理主机，当前任务会跳转到代理主机执行

点开`SQL优化`

- 目标标签：下拉选择你要关联的标签组(注意:目标库只能选择一个数据库)
- 数据库名：输入要操作的数据库名称
- 优化类型：选择优化类型`SOAR`或`SQLAdvisor`
- SQL语句：填写要优化的SQL语句
- 操作： 选择你要操作的选项`SQL评分`,`SQL指纹`,`SQL美化`,`语法检查`

![](/sql_opti.png)

**资源申购**

>该模块用于申购服务器，数据库，Redis，负载均衡等资源使用(更新中)

**节点添加**

>用于横向扩展Kubernetes(K8S)节点(更新中)

**自定义任务**

>该模块可以更灵活的添加自己要对服务器操作的任务模板

**注意**
- 1.当前页面使用标签关联相关主机，选取标签下的主机, 系统直连主机并发执行选择模板的任务，为了减轻任务压力，限制并发100以内

点开`自定义任务`

- 目标标签：下拉选择自定义的标签组
- 选择模板：下拉选择自定义的模板
- 参数1：填写上传的参数和对应参数值(可增加和删除参数选项)
- 执行时间：选择一个执行时间，用来触发模板中的定时触发器

![](/custom_task.png)

**自定义任务-代理**

>该模块用于处理无法直连服务器需要通过代理连接来执行一些任务

**注意**
- 1.当前页面使用标签关联相关主机，选取标签下的主机,在代理主机上执行选择模板的任务，并把主机名，IP地址传给任务，任务本身通过ansible、saltsatck、多线程、多进程等方法来进行并发。参数IP：SERVER_IP,主机名：SERVER_HOST一般可以作为salt name。

点开`自定义任务-代理`

- 目标标签：下拉选择自定义的标签组(注意：标签可以多选，但是代理主机有且仅有一个，不可多选)
- 选择模板：下拉选择自定义的模板
- 参数：填写上传的参数和对应参数值(可增加和删除参数选项)
- 执行时间：选择一个执行时间，用来触发模板中的定时触发

![](/custom_task_proxy.png)

**自定义任务-JSON**

>该模块提供了自定义JSON的方式更方便灵活的来进行自定义任务

**注意：参数详解**
```json


{
	"task_name": "任务名称",
	"submitter": "提交人",
	"temp_id": "1",
	"schedule": "ready",
	"exec_time": "2018-11-27 14:09:50",
	"associated_user": "{'group-1': ['杨红飞']}",
	"args": "{'VERSION':'eeee', 'arg02': 'xxxx'}",
	"details": "这里是备注",
	"hosts": "{1: '127.0.0.1'}"
}


```

- 1.task_name: 任务名字
- 2.submitter: 提交人
- 3.temp_id：模板ID，就是你上面创建模板时候生成的那个ID
- 4.schedule：这是状态，常用的有ready和new ready：表示不通过人工审核，只要到了执行时间直接执行任务new：表示需要任何审核，管理员审核，选择执行时间，到时间后开始执行
- 5.exec_time： 任务执行时间，状态为ready的情况下，到这个时间会进行执行
- 6.args：这里是一个字典，里面的参数可以自行定义，如上，你模板参数里面用到了哪些你都可以在这里定义出来，当你的POST到这个接口时候，我们会自动接受此参数，并帮你运行脚本 解析你要传入的参数。
- 7.details：描述，备注信息
- 8.hosts：这个是执行主机，字典形式， 1表示第一组主机，也就是上面模板里面的组1，任务支持多组。主机IP，这个是执行主机，这个废话多一点，比如我以上模板的脚本在172.16.0.101这台主机上，我就想平台登陆我这个主机，来帮我执行这些脚本，至于怎么登陆，那么就是我最开始在平台里面配置了一个执行用户，我将我这个主机的私钥放到了平台上，公钥在我服务器上，这样子CODO平台就可以ssh -i xxxx.pem@{ip_address}远程到我的主机上帮我执行命令。

点开`自定义任务-JSON`

- POST JSON：输入你的数据，参考上面的示例，你也可以二次开发对接自己的CMDB获取主机，时间字段从下面获取，方便处理(注意：提交的数据必须以JSON格式，请严格按照说明提交)
- 执行时间：选择一个执行时间，用来触发模板中的定时触发

![](/custom_task_json.png)


PS：已经文档会在后续过程中不断更新完善，感谢大家支持。


## 定时任务

> 通过定时任务可以进行添加你的定时任务


**定时任务特点**

- restful api 简单易定制
- 可接入可视化界面操作
- 定时任务统一管理
- 完全兼容 crontab
- 支持秒级定时任务
- 任务可搜索、暂停、编辑、删除



**用户使用说明**

- 新增任务
  - job_id： 任务名称，建议为有意义的英文名称
  - 可执行命令： `Linux Bash` 命令，亦可将可执行程序放入指定的目录（使用docker 切记安装依赖）
  - 任务定时器： （秒、分、时、日、月、周）
    - 示例：每分钟的第20秒开始执行`pwd`命令

![](/timed_task01.png)



- 编辑任务

![](/timed_task02.png)



- 暂停恢复
  - 状态栏可以将任务暂停/恢复

![](/timed_task03.jpg)



- 任务日志
  - 每条任务执行都会记录日志
  - 日志可根据Job_id、状态、关键字、时间范围等搜索


![](/timed_logs.jpg)







## 代码仓库

> 列举一个平台上代码仓库部分的示例，让大家快速灵活的使用OpenDevOps平台，进行对接代码仓库的实战操作；

**创建代码仓库**

点开`作业配置`-`代码仓库`-`GIT配置`

**填写对应git_url、[private_token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)、deploy_key**

- git_url： https://gitlab.domain.com/
- [private_token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html): Gitlab申请的Access Token

![](/create_git01.png)

![](/20190705172432.png)

- 添加保存后点击刷新地址，将同步所有该地址下的项目分支到平台

![](/create_git03.png)



至此，Gitlab的仓库信息已经可以同步到平台上了，如果你需要基于Gitlab 钩子进行操作，你需要进行以下配置

- **Git服务器操作-->配置GitLab全局钩子**
- **CODO平台操作--->配置单个仓库钩子匹配规则**





**第一步、配置Gitlab全局钩子**

> 此步骤是监控GitLab所有提交事件，根据平台配置的钩子匹配规则进行触发你所定义的任务

注意：`由于Gitlab版本存在CE版本和源码安装版本，全局update钩子配置不同`

- GitlabCE版本路径：`/opt/gitlab/embedded/service/gitlab-shell/hooks`
- GitLab源码版本路径：`/home/git/gitlab-shell/hooks/`

此目录下的钩子都是为全局钩子，请慎重修改，本操作是不影响其余钩子/局部钩子的情况下添加的。

请修改`update`文件，在`ruby`脚本中修改成以下内容：

```ruby
#!/opt/gitlab/embedded/bin/ruby --disable-gems
# Fix the PATH so that gitlab-shell can find git-upload-pack and friends.
ENV['PATH'] = '/opt/gitlab/bin:/opt/gitlab/embedded/bin:' + ENV['PATH']

#!/usr/bin/env ruby

# This file was placed here by GitLab. It makes sure that your pushed commits
# will be processed properly.

ref_name  = ARGV[0]
old_value = ARGV[1]
new_value = ARGV[2]
repo_path = Dir.pwd
key_id    = ENV.delete('GL_ID')
#CODO TASK，只需要加下面2行即可
codo_task_script = '/opt/codo/codo-scripts/gitlab/codo_task.py'
system(codo_task_script, ref_name, old_value, new_value)

require_relative '../lib/gitlab_custom_hook'

if GitlabCustomHook.new(repo_path, key_id).update(ref_name, old_value, new_value)
  exit 0
else
  exit 1
end

```
示例图：

![](/20190705174524.png)


`/opt/codo/codo-scripts/gitlab/codo_task.py`脚本内容

注意： 一定要修改脚本中`accept_task_url` 、`git_url`、`auth_key`内容

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019/6/27 13:48
# @Author  : Fred Yangxiaofei
# @File    : codo_task.py
# @Role    : GitLab全局Hooks  update钩子


import sys
import os
import requests
import json


def post_codo_task():
    """
    监控全局钩子，CODO提交任务
    注意，Gitlab全局钩子调用此脚本的时候不能使用format
    :return:
    """
    # 修改你的钩子任务API接口
    accept_task_url = 'https://codo.opendevops.com/api/task/other/v1/git/hooks/'
    # 修改你的GIT地址
    git_url = 'http://gitlab.domain.com/'
    # 修改你的长期Token，从管理员获取， 此用户的Token需要对/task/other/v1/git/hooks/接口有权限
    auth_key = "eyJ0eXAiOiJeHAiOjE2NTY1NzgwOTUsIm5iZiI6MTU1Mjg5ODA3Nh"

    try:
        tag_name = sys.argv[1].split("/")[-1]  # tag/branch 名字
        repo_group = os.getcwd().split('/')[-2]  # 组名字
        repo_name = os.getcwd().split('/')[-1].replace('.git', '')  # git名字
        relative_path = repo_group + '/' + repo_name  # 组+git名字路径

        the_body = json.dumps({
            "git_url": git_url,
            "relative_path": relative_path,
            "tag_name": tag_name
        })

        req1 = requests.get(accept_task_url, cookies=dict(auth_key=auth_key))
        csrf_key = json.loads(req1.text)['csrf_key']
        cookies = dict(auth_key=auth_key, csrf_key=csrf_key)
        req = requests.post(accept_task_url, data=the_body, cookies=cookies)
        req_dict = json.loads(req.text)
        print('Hooks Log: ', req_dict.get('msg'))
    except Exception as e:
        print(e)


if __name__ == '__main__':
    post_codo_task()

```



**第二步、CODO平台配置钩子规则**

> 针对单个项目进行配置钩子规则，当你打Tag/brach中提交的的时候，根据你的匹配规则，正则匹配、来触发你所定义的任务


- 选择其中一个项目，点击对应的编辑按钮

![](/create_git_hook01.png)

![](/create_git_hook02.png)

- 提交测试钩子会在订单中心生成一个新订单，说明平台通道已经配置好

![](/create_git_hook03.png)


- 根据不同版本的gitlab有不同配置方式，老版本的gitlab由于API不完善，可以单独进行添加

![](/create_git04.png)

![](/create_git05.png)




![](/create_git_hook02.png)



- 都配置好之后可以自己打一个测试的tag进行测试

示例命令：

```shell
#基于branch
git touch test
git add --all
git commit -m "test"
git push -u origin master

#基于tag
git tag release-ftqqminigame-test01
git push -u origin release-ftqqminigame-test01

```

**平台查看钩子日志**  

![](/20190705175739.png)



**注意**

- 填写的git仓库域名地址和对应参数必须真实有效，否则测试不通过将不会保存



## 监控告警


> 监控报警主要分为2部分，ZABBIX+Prometheus 都是基于Webhook做的


**ZABBIX**

本章主要介绍下CODO中的ZABBIX怎么使用，他能帮你做什么？


**功能简介**

- 支持多ZABBIX配置
- 支持多ZABBIX webhooks同时接入
- 支持多ZABBIX webhook告警日志展示
- 支持多ZABBIX 配置钩子实现故障自愈、自定义任务等
- 获取多ZABBIX Last Issues统一展示，不再多个系统之间奔波


**首先，点击ZABBIX配置，配置你的地址**


![](/20190718170416.png)
**刷新地址，将已配置的ZABBIX组/主机Hostname拉取下来**


![](/20190718175252.png)

**回到首页，你可以看到你多个ZABBIX Last Issues都统一展示出来了**

![](/20190718175435.png)

至此，到这一步，已经将ZABBIX的信息给获取下来了, 并且可以看到  Last ISSUES了

But，你如果觉得这些还不够，接下来想要对报警进行下一步的操作，比如我要`故障自愈`，那么你就要开始用钩子功能了

这部分的逻辑是`配置权限`--->`配置ZABBIX webhook`--->`配置钩子`---->`根据告警tagger_name匹配`--->`故障自愈/自定义任务等操作`


那么，让我们开始吧。


**配置权限**

- 权限配置用于向平台提交任务的权限，需要用户输入对应的API接口和Auth_key
- auth_key：是管理员生成的长期Token
- task_url：https://codo-v1.domain.com/api/task/v2/task/accept/  

测试保存，这里会进行权限认证，只有通过了认证才能保存成功。


![](/20190718175850.png)

**配置钩子**

选择一台机器，进行配置钩子


新建一个钩子， 这里可以配置多个 那么这里是怎么匹配的呢？ 简单记录下。

- 收到告警后，开始根据告警的ZABBIX地址+ZABBIX 主机查询 这个主机有配置钩子
- 如果有钩子规则，开始全匹配告警的tagger_name和你配置的tagger_name是不是一致的，一致的之间触发任务

![](/20190719095329.png)




**测试钩子**

- 模拟ZABBIX告警信息来测试告警是否匹配，从而触发钩子任务

![](/.png)  

![](/20190719095734.png)


![](/20190719095806.png)


从上图可以看到，正常匹配到了，触发了任务， 数据也传了过来，接下来了有数据，用户可以实现自己的逻辑了。


那么如果告警没匹配怎么办， 我们来测试下  

![](/20190719095806.png)

可以看到，他会给我说匹配不到钩子  

![](/20190719100136.png)


**钩子日志**


我们通过刚来的测试看下钩子日志

- 匹配到的会记录下来，并打出来执行的模板等信息
- 接收到的告警，没匹配也会记录下来，但是不做任何操作


![](/20190719100312.png)




**ZABBIX webhook**

到了这一步，我们都是平台配置和测试，那么如果想要接入ZABBIX告警信息，就必须要借助的ZABBIX 的webhook功能

这里我们接着操作，接入ZABBIX，实现全局监控ZABBIX告警，自动触发，故障自愈，自定义任务等操作


ZABBIX的版本迭代也是蛮快的，为了更好的让用户使用，不同的版本我写了不同的适配脚本来实现， 差别不大


谈一下ZABBIX配置， 这里只要是配置一个ZABBIX mediatype，和 Action触发器，将告警信息发到我的接口里面，我来帮你分析





**先来讲一下ZABBIX2.0**

ZABBIX 2.0 的版本是不支持mediaType里面传参的，但是他有三个默认参数，$3是邮件内容 $2 邮件标题 $1 发送给谁

既然他不支持自定义参数，那我们就借助他的默认参数，这里我用到了$2 第二个标题参数


**先将脚本放到服务器上**

脚本放在那？  这个要看你配置在那里了，不管是Mail\SMS\Webhooks  只要是触发脚本类型的都在这里


```shell
#让我们查一下你的配置是什么？

$ grep -r "AlertScriptsPath" /etc/zabbix/zabbix_server.conf

AlertScriptsPath=/usr/lib/zabbix/alertscripts   #脚本就放在这里

```

ZABBIX2.0版本

官方示例脚本：

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019/7/10 10:09
# @Author  : Fred Yangxiaofei
# @File    : send_alert.py
# @Role    : Zabbix webhooks 发送告警信息测试


# zabbix3.0+配置

import sys
import requests
import json


def send_alert(zabbix_url, webhook_url, messages):
    # 这里就是一个长期Token，管理员可以在用户列表选择一个用户进行生成一个长期Token， 但是需要对/tools/v1/zabbix/hooks/接口有权限
    params = {
        "auth_key": "eyJ0eXAiOiJKV1QiLCJhbGciSmW4m45L4w5XjDHPU3yBIzU0gfWeKnLH3SV4gFPLN6g"
    }
    # payload = "{\"data\": \"test\"}"
    payload = {"zabbix_url": zabbix_url, "messages": messages}
    headers = {'content-type': "application/json", 'cache-control': "no-cache"}
    response = requests.post(url=webhook_url, data=json.dumps(payload), headers=headers, params=params)
    print(response.text)


if __name__ == '__main__':
    # 你的ZABBIX地址,高版本ZABBIX你也可以从ZABBIX配置中传过来,请确保你和CODO平台上配置的一模一样
    zabbix_url = 'http://zabbixdoamin.com/zabbix'

    webhook_url = 'https://codo.domain.com/api/tools/v1/zabbix/hooks/'


    # ZABBIX的告警信息，这个我要用到，所以就要强规范：{HOSTNAME}___{HOST.IP}___{TRIGGER.NAME}___{TRIGGER.STATUS}___{TRIGGER.SEVERITY}
    messages = sys.argv[2]

    send_alert(zabbix_url, webhook_url, messages)

"""
如何使用：

pip install json
pip install requests

如何测试：

python send_alert_to_codo.py '' 'Zabbix server___127.0.0.1___Zabbix agent on Zabbix server is unreachable for 5 minutes___PROBLEM___Average'
"""


```


**配置好了脚本，我们来配置2版本的ZABBIX**


![](/20190719101037.png)


**配置一个Action**

这里为了不影响你现有的，我们之间配置一个新的

但是这里切记标题是强规范，将我的标题给复制进去，其余的不重要

```

{HOSTNAME}___{HOST.IP}___{TRIGGER.NAME}___{TRIGGER.STATUS}___{TRIGGER.SEVERITY}

```

![](/20190719101654.png)

![](/20190719101829.png)

![](/20190719101943.png)




以上，是ZABBIX 2.0版本的配置


**ZABBIX3.0配置webhook**

现在相信很多人也都用了最新的ZABBIX，那么我们必然也要支持以下了，ZABBIX 3.0+就支持自定义传参了，这个还是挺人性化的， ZABBIX3.0和2.0的配置思路一样，接下来让我们开始吧。




**先将脚本放到服务器上**

脚本放在那？  这个要看你配置在那里了，不管是Mail\SMS\Webhooks  只要是触发脚本类型的都在这里


```shell
#让我们查一下你的配置是什么？

$ grep -r "AlertScriptsPath" /etc/zabbix/zabbix_server.conf

AlertScriptsPath=/usr/lib/zabbix/alertscripts   #脚本就放在这里

```

ZABBIX3.0版本

官方示例脚本：

```python

#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019/7/10 10:09
# @Author  : Fred Yangxiaofei
# @File    : send_alert.py
# @Role    : Zabbix webhooks 发送告警信息


# zabbix3.0+配置

import sys
import requests
import json


def send_alert(zabbix_url, webhook_url, messages):
    # 这里就是一个长期Token，管理员可以在用户列表选择一个用户进行生成一个长期Token， 但是需要对/tools/v1/zabbix/hooks/接口有权限
    params = {
        "auth_key": "eyJ0eXAiOiJKV1QiLCJ.SmW4m45L4w5XjDHPU3yBIzU0gfWeKnLH3SV4gFPLN6g"
    }
    # payload = "{\"data\": \"test\"}"
    payload = {"zabbix_url": zabbix_url, "messages": messages}
    headers = {'content-type': "application/json", 'cache-control': "no-cache"}
    response = requests.post(url=webhook_url, data=json.dumps(payload), headers=headers, params=params)
    print(response.text)


if __name__ == '__main__':
    zabbix_url = 'http://xxxxx/zabbix'  # 你的ZABBIX地址,高版本ZABBIX你也可以从ZABBIX配置中传过来
    webhook_url = sys.argv[1]
    messages = sys.argv[2]

    send_alert(zabbix_url, webhook_url, messages)

"""
如何使用：

pip install json
pip install requests

如何测试：

python send_alert_to_codo.py https://codo.domain.com/api/tools/v1/zabbix/hooks/ alert_message_test
"""

```

ZABBIX3.0配置

![](/20190719101943.png)


![](/20190719102304.png)


**配置一个Action**

这里为了不影响你现有的，我们之间配置一个新的

但是这里切记标题是强规范，将我的标题给复制进去，其余的不重要

```

{HOSTNAME}___{HOST.IP}___{TRIGGER.NAME}___{TRIGGER.STATUS}___{TRIGGER.SEVERITY}

```


![](/20190719102659.png)

![](/20190719102808.png)

![](/20190719102916.png)


接下来就完成了，你可以触发一个告警，进行测试了。




## 资产管理

> 这部分主要介绍CMDB资产管理一期，更多新功能正在开发中，现版本详细操作也可观看[视频示例](https://www.bilibili.com/video/av53408299/)



**添加主机**

- 管理用户： 例如AWS的`ec2-user`

- 其余字段不做多解释，从字面可以看出意思

![](/cmdh_add_host.png)

**资产更新**

选择主机进行资产更新，这里为手动更新，默认系统会每天进行后台自动更新

![](/cmdb_asset_update.png)

![](/asset_server_detail.png)

**同步标签树**

不需要选中主机，同步标签树是一个和作业配置中标签树进行了打通，如果需要CMDB的数据同步到标签树里面则点击此按钮即可同步，同步后数据以CMDB为主，标签树里面多出来的则会被删除，谨慎操作。

![](/cmdb_sync_tag.png)



**机器状态**

CMDB中的几种状态

- New：表示手动新增的机器
- Auto：表示自动从云厂商拉取过来的主机，这个时候主机详情的信息都是云上获取到的一些基础信息
- True：表示已经手动点了资产更新的操作，这时候资产信息都是从主机系统上脚本获取到的信息

- False：表示更新资产失败，这个状态下是可以查看错误日志的



**DB管理**

这里DB管理第一版只是简单的记录，没有规划很多功能，很多字段也是预留字段，后续会做成自动相关的

![](/asset_db.png)

**标签管理**

取消了组的概念，Tag设计的出发点就是伪组，这里也是将机器分类

![](/asset_tag.png)

**管理用户**

- 将私钥放在平台上，平台是根据这个私钥去连接你的主机的，例如：AWS的`ec2-user`

![](/asset_admin_user.png)



**资产配置**

这一块主要用来用户给我配置一些Key信息，我去APi接口里面把机器给获取下来加到CMDB里面

自动拉取，后端日志统一在：` tailf /var/log/supervisor/cmdb_cron.log `

- 只有状态按钮为开启状态，系统才会去你配置的区域里面去拉取主机信息
- 请确保你填写的AccessID/AccessKey/Region区域信息的准确性，可点击测试按钮进行测试权限
- 最好能够确保你机器的Hostname是唯一值，CMDB设计中Hostname是不允许重复的，自动必然要有一些规范
-  默认管理用户：此用户是可以登陆机器的，若此处填写了默认管理用户，会自动给机器关联上此用户，用于后续资产更新连接使用，一般情况下管理用户一个账户里面OPS都是1-2个，毕竟太多OPS自己维护起来也很麻烦
- 自动获取来的机器状态都是Auto状态，若不配置管理用户，默认资产详情信息都是从云平台获取的一些基本信息，若配置了管理用户并更新了资产，资产信息来源基于系统本身获取到的
- `拉取资产按钮：手动触发云厂商主机更新到主机列表，默认情况下6小时会自动更新一次，请不要频繁点击，可能会产生调用接口费用(AWS)`
- 若此处配置了，系统会自动调用请求云厂商主机详情脚本(只要有查询实例的权限即可)，将指定区域的配置自动拉取并写入CMDB中,另外AWS测试可能需要5~10s不等，因为请求接口都在国外

![](/asset_config.png)

## 配置中心

> 这部分主要介绍下配置中心使用说明


**新建项目**  

![](/configuration_center01.png)

**填写环境-服务等信息**
![](/configuration_center02.png)

**对项目授权**

对整个项目授权是可以看到整个项目里面的配置

![](/configuration_center03.png)

**对单个环境授权**

对单个环境授权：项目下若有多个环境，授权的用户只能看到指定的环境

![](/configuration_center04.png)

**如何获取配置**

> 那么我新建了一个配置，我怎么获取到他呢？ 没关系我们提供了获取配置的示例

- 简单示例，也可[参考复杂示例](https://github.com/opendevops-cn/kerrigan/blob/master/libs/get_config.py)

Python版本 

```python

class ConfApi:
    def __init__(self):
        # self.auth_key 是一个长期Token，基于用户管理里面，管理员选中用户生成长期Token，默认发送到用户邮箱
        self.auth_key = 'eyJ0eXAiOiJKV1QiLCJhbmZpZyIsIm5pY2XcFBbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTMwMzQyNzYsIm5iZiI6MTU1Nzk5NDI1NiwiaWF0IjoxNTU3OTk0Mj3ZjZlXHU3NTI4XHU2MjM3IY2LCJpc3MiOiJhdXRoOiBzcyIsInQiOiIxNTYxODcxODA2MCIsImRhdGEiOnsidXNlcl9pZCI6NjYsInVzZXJuYW1lIjoiZ2V0X2NvFOOo'
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

def main():
    obj = ConfApi()
    config_file = obj.create_config_file('DNS', 'release', 'dnsmasq', 'dnsmasq.conf')
    hosts_config_file = obj.create_config_file('DNS', 'release', 'dnsmasq', 'dnsmasq_hosts')

if __name__ == '__main__':
    main()

```



Go版本    

`go run write_conf.go -p code-v1 -e dev -s codo-admin -f settings.py -r /tmp/settings.py1`
```go
// 用golang编写，可以应付多种环境，并且可以对文件编译，防止密钥泄露
package main

import (
 "encoding/json"
 "flag"
 "fmt"
 "io/ioutil"
 "os"

 "github.com/kirinlabs/HttpRequest"
)

const (
 authKey = "eyJ0eXAiOiJKV1QiLCJ2MCIsImRhdGEiOnsidXNlcl9pZCI6MjgsInVzZXJuYW1lIjoic3MtdGVzdhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTQ4MjzdXBlcnVzZXIiOmZhbHNlfc2MDYsIm5iZiI6MTU1OTc4NzU4NiwiaWF0IjoxNTU5Nzg3NTk2LCJpc3MiOiJhdXRoOiBzcyIsInN1YiI6Im15IHRva2VuIiwiaWQiOiIxNTYxODcxODACIsIm5pY2tuYWJpc19X0.gMGMRKqtd_CM6rIzE8mxuwR8c8dz_hyH21FETOO4XbE"
 confURL = "https://codo.domain.com/api/kerrigan/v1/conf/publish/config/"
)

var (
 project_code string
 environment  string
 service      string
 filename     string
 realfilename string
 configData   string
)

func getArgs() error {
 flag.StringVar(&project_code, "p", "ss", "项目代号")
 flag.StringVar(&environment, "e", "dev", "环境")
 flag.StringVar(&service, "s", "app", "应用名称")
 flag.StringVar(&filename, "f", "settings.py", "文件名")
 flag.StringVar(&realfilename, "r", "/tmp/settings.py", "最终写入文件")
 flag.Parse()
 if project_code == "ss" {
  fmt.Println("[Error] 参数不正确，请使用参数 --help 查看帮助")
  os.Exit(-5)
 }
 return nil
}

func writeWithIoutil(name, content string) {
 data := []byte(content)
 if ioutil.WriteFile(name, data, 0644) == nil {
  fmt.Println("[Success] 修改配置成功")
 }
}

func main() {
 getArgs()
 req := HttpRequest.NewRequest()

 // 设置超时时间，不设置时，默认30s
 req.SetTimeout(30)

 // 设置Headers
 req.SetHeaders(map[string]string{
  "Content-Type": "application/x-www-form-urlencoded", //这也是HttpRequest包的默认设置
 })

 // 设置Cookies
 req.SetCookies(map[string]string{
  "auth_key": authKey,
 })

 // GET
 resp, err := req.Get(confURL, map[string]interface{}{
  "project_code": project_code,
  "environment":  environment,
  "service":      service,
  "filename":     filename,
 })

 if err != nil {
  fmt.Println("[Error]", err)
  // log.Println(err)
  os.Exit(-1)
 }

 if resp.StatusCode() == 200 {
  body, err := resp.Body()

  if err != nil {
   fmt.Println("[Error]", err)
   os.Exit(-2)
  }

  res := make(map[string]interface{})
  json.Unmarshal(body, &res)

  for _, v := range res["data"].(map[string]interface{}) {
   configData = fmt.Sprintf("%v", v)
  }
 } else {
  os.Exit(-3)
 }
 writeWithIoutil(realfilename, configData)
}

```



## 用户管理

> 这部分文档主要用来介绍用户管理，它可以很精细的管理你的用户权限



**用户列表**

用户列表：顾名思义，用来管理和展示用户的列表，记录用户的详细信息

**功能支持**

- 搜索用户
- 新建用户
- 删除用户
- 关闭用户
- 重置密码
- 重置MFA（Google Authenticator）
- 生成长期Token(管理员)


**展示界面**



![user_list](/user_list.png)



**权限列表**

用来详细配置管理每个接口的权限，默认不需修改。



**注意事项**

- 系统默认已经配置了所有权限和方法，管理员默认拥有`/`权限，无需修改，以免造成系统请求某功能出错



**功能说明**

- 支持多种搜索方式，如：权限名称、请求路径、请求方法、时间等
- 支持新增、编辑、关闭、删除等操作权限的管理

- 支持新增自定义权限功能，适用于开发人员编写的API接口能很方便的接入进来权限管理划分

- 一些详细的API及使用文档正在支持更新中............



![user_list](/permission_list.png)



**菜单组件**

菜单组件：顾名思义，也就是导航栏所看到的功能模块（如：用户管理、系统管理）和一些功能按钮（如：编辑、删除按钮），默认无需修改



**注意事项**

- 系统默认已经配置了所有菜单功能模块及组件，无需修改此项，以免造成访问出错。



**功能介绍**

列举以下几个菜单和组件进行介绍，字面英语也可看出含义，如下：

- home：家目录
- usermanage：用户管理
- cron：定时任务
- edit_button：编辑按钮

由于代码层面不好直接使用中文，你可以选择平台语言`English`，如下图，很清晰看到每个作用。

![menus](/menusv2.png)



**角色管理**

基于[RBAC](https://baike.baidu.com/item/RBAC/1328788?fr=aladdin)角色管理访问控制权限，可以很精细/方便的管理你的用户权限



**功能介绍**

- 角色的搜索、编辑、关闭、删除
- 自定义角色名字，自定义赋权组件、菜单、权限管理

- 列表可搜索赋权设计，方便用户可视化操作

![rbac](/rbac.png)





**示例介绍分为两部分，创建管理员用户赋权和创建普通用户赋权**

**创建普通用户示例**

**新建用户**  

同上，填写信息即可，详细权限管理全部在角色管理配置

**用户赋权**

![create_general_user](/create_general_user.png)



![general_user_epm](/general_user_epmv2.png)


**创建管理员用户示例**

**新增用户**

点击用户列表---新增用户，输入信息

![create_user](/create_user.png)

**用户赋权**

点击角色管理---新建，输入角色信息，选择角色进行赋权

![create_rbac](/create_rbac.png)

![user_emp](/general_user_epmv2.png)

![user_emp02](/user_emp02.png)

![user_emp03](/user_emp03.png)

**获取长期Token**

>本系统使用token进行身份验证，当用户需要API进行访问的时候就需要获取token，并把token放入cookie里或者 访问的url参数里 

- 从用户管理 > 菜单组件里面找到 get_token_btn 这个代表获取token的按钮 要存在并且启用 
- 从用户管理 >角色管理里面找到你要赋值的角色，点击组件把get_token_btn 添加进去 

![](https://raw.githubusercontent.com/opendevops-cn/codo-admin/master/doc/images/tianjiazujian.png)

- 从用户管理 > 用户列表 会看到这个长期token的按钮，如果你是超级管理员 你就可以选中用户点击，然后系统会通过邮件把这个用户的token 发送至当前用户以及被选中用户的邮箱，token 有效期为三年。强烈建议如果使用token进行操作的时候 使用单独用户，防止人员变动造成token不可用，要进行精确权限控制，做好备注，且不要给此用户菜单以及组件权限。

![](https://raw.githubusercontent.com/opendevops-cn/codo-admin/master/doc/images/get_token.png)

- 使用token 向 CODO 服务 API 提交安全的 REST 或 HTTP 查询协议请求。为了您的安全，请不要与任何人分享您的密钥。作为最佳做法，我们建议经常更换密钥 
- 简单python示例，当然你之前一定会检查这个token是否对这个接口有权限，对吧！ 

```python
import requests
import json

auth_key= '这里就是你的token'
url = 'https://xxx.xxxx.cn/api/kerrigan/v1/conf/publish/config/?project_code=shenshuo&environment=dev&service=nginx&filename=demo.conf'
### 使用 cookie 传递
try:
    res = requests.get(url, cookies=dict(auth_key=auth_key))
    ret = json.loads(res.content)
    if ret['code'] == 0: return ret['data']
except Exception as e:
    print('[Error:] 接口连接失败，错误信息：{}'.format(e))
    exit(-1)

### 使用url 传递
try:
    _params = {'这里是参数名': '这里是参数值', 'auth_key': auth_key}
    res = requests.get(url, params=_params)
    ret = json.loads(res.content)
    if ret['code'] == 0: return ret['data']
except Exception as e:
    print('[Error:] 接口连接失败，错误信息：{}'.format(e))
    exit(-2)
```


## 系统管理

> 这部分主要介绍系统配置，系统管理模块主要分为：`系统配置`和`系统日志`

**系统配置**
> 系统配置主要介绍系统参数配置，后续后陆续支持各种核心功能配置

**系统配置**
> 这块需要配置你的API地址，部署时你API网关服务所部署的服务器地址，只有确认了API网关，各个功能模块才可以正常通信。

- API地址: 你的API网关地址，可以是IP/域名，必填项.

![](/api_addressv2.png)

**邮件设置**

> 这块主要配置邮箱，配置了此邮箱信息后，后续平台内所涉及到邮件提醒都会使用此邮箱配置。

不同运营商配置可参考`FAQ`中[邮箱设置问题](https://docs.opendevops.cn/zh/guide/more/faq/)


- SMTP主题： 邮件标题
- SMTP主机： 服务器地址
- SMTP端口： 服务器端口
- SMTP账户： 邮箱账户名
- SMTP密码： 邮箱账户密码
- 如果SMTP端口是465，通常需要启用SSL
- 如果SMTP端口是587，通常需要启用TLS
- 点击测试邮件会给当前用户发送一封邮件用于测试


![](/system_email.png)


**短信接口**
> 这块主要配置短信接口信息，短信接口只支持阿里云`阿里大鱼`，后续平台所涉及到发短信会调用此接口

- 短信区域： `cn-hangzhou` 目前阿里官方给出必须是这个
- API名称： `Dysmsapi` 目前官方给出一般都是这个名称
- API域名：`dysmsapi.aliyuncs.com` 目前官方给出必须是这个地址
- KEY_ID： 你的IAM访问控制密钥ID
- KEY_SECRET： 你的access_secret密钥，备注：`这里需要必须有SMS的权限`
- 点击测试端口系统会向阿里大鱼进行发送查询接口，如果配置验证不通过则提示报错信息

![](/system_smsv2.png)

**LDAP设置**

>这块主要用于配置LDAP认证

实例图如下：

​    ![](/ldap.png)

**邮箱登陆**
> 这块主要是支持第三方邮箱登陆，当你想要使用邮箱登陆此平台时，你可以在此进行配置
比如我们企业邮箱是腾讯的,域名就是`opendevops.cn`，SMTP就是腾讯的`stmp.exmail.qq.com`,这样配置完成后我就可以使用我`yanghongfei@opendevops.cn`邮箱+密码登陆此平台了。


- 邮箱SMTP： 这里输入你邮箱服务商的SMTP地址
- 邮箱域名：这里是你的邮箱后缀名字

![](/system_email_loginv2.png)



**存储配置**

> 这块主要是配置Bucket信息，目前只支持阿里云的OSS，这里目前主要用于将跳板日志审计的内容存放到OSS目录里面，若不配置此项则存本地数据库（可能会很大，建议配置OSS)
- 区域Region：阿里云的可用区域，如：`cn-hangzhou`
- 存储桶名称: Bucket名称
- SecretID: 密钥ID，需要有OSS权限
- Secret Key： 密钥Key，需要有OSS权限

![](/system_bucketv2.png)


**系统日志**
> 这里主要记录的本系统平台的所有请求日志，如：GET/POST/DELETE/PUT等，你的操作信息都会被记录，不要随意干坏事哟，管理员都可以看到的，安全我们还是会考虑进去的。

![](/system_log.png)






最后，感谢你的支持，我们正在不断完善文档和平台功能，你也可以加入我们的的社区交流群进行反馈信息，给我们带来你的意见和建议。