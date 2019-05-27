### 用户管理

> 这部分文档主要用来介绍用户管理，它可以很精细的管理你的用户权限



#### 用户列表

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



![user_list](./_static/images/user_list.png)



#### 权限列表

用来详细配置管理每个接口的权限，默认不需修改。



**注意事项**

- 系统默认已经配置了所有权限和方法，管理员默认拥有`/`权限，无需修改，以免造成系统请求某功能出错



**功能说明**

- 支持多种搜索方式，如：权限名称、请求路径、请求方法、时间等
- 支持新增、编辑、关闭、删除等操作权限的管理

- 支持新增自定义权限功能，适用于开发人员编写的API接口能很方便的接入进来权限管理划分

- 一些详细的API及使用文档正在支持更新中............



![user_list](./_static/images/permission_list.png)



#### 菜单组件

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

![menus](./_static/images/menusv2.png)



#### 角色管理

基于[RBAC](https://baike.baidu.com/item/RBAC/1328788?fr=aladdin)角色管理访问控制权限，可以很精细/方便的管理你的用户权限



**功能介绍**

- 角色的搜索、编辑、关闭、删除
- 自定义角色名字，自定义赋权组件、菜单、权限管理

- 列表可搜索赋权设计，方便用户可视化操作

![rbac](./_static/images/rbac.png)





**示例介绍分为两部分，创建管理员用户赋权和创建普通用户赋权**

#### 创建普通用户示例

**新建用户**  

同上，填写信息即可，详细权限管理全部在角色管理配置

**用户赋权**

![create_general_user](./_static/images/create_general_user.png)



![general_user_epm](./_static/images/general_user_epmv2.png)


#### 创建管理员用户示例

**新增用户**

点击用户列表---新增用户，输入信息

![create_user](./_static/images/create_user.png)

**用户赋权**

点击角色管理---新建，输入角色信息，选择角色进行赋权

![create_rbac](./_static/images/create_rbac.png)

![user_emp](./_static/images/general_user_epmv2.png)

![user_emp02](./_static/images/user_emp02.png)

![user_emp03](./_static/images/user_emp03.png)

**获取长期Token**

>本系统使用token进行身份验证，当用户需要API进行访问的时候就需要获取token，并把token放入cookie里或者 访问的url参数里 

- 从用户管理 > 菜单组件里面找到 get_token_btn 这个代表获取token的按钮 要存在并且启用 
- 从用户管理 >角色管理里面找到你要赋值的角色，点击组件把get_token_btn 添加进去 

![](https://github.com/opendevops-cn/codo-admin/blob/master/doc/images/tianjiazujian.png)

- 从用户管理 > 用户列表 会看到这个长期token的按钮，如果你是超级管理员 你就可以选中用户点击，然后系统会通过邮件把这个用户的token 发送至当前用户以及被选中用户的邮箱，token 有效期为三年。强烈建议如果使用token进行操作的时候 使用单独用户，防止人员变动造成token不可用，要进行精确权限控制，做好备注，且不要给此用户菜单以及组件权限。

![](https://github.com/opendevops-cn/codo-admin/blob/master/doc/images/get_token.png)

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

