[![Codo](https://img.shields.io/badge/python-CoDo-red)](https://www.opendevops.cn/)
[![Python3](https://img.shields.io/badge/Python-3.6-green.svg?style=plastic)](https://www.python.org/)
[![Tornado](https://img.shields.io/badge/Tornado-5.0-brightgreen.svg?style=plastic)](https://www.tornadoweb.org)
[![swagger-py-codegen](https://img.shields.io/badge/python-swagger--py--codegen-red)](https://github.com/guokr/swagger-py-codegen)
[![PyPi Version](https://img.shields.io/pypi/v/swagger-py-codegen.svg?style=flat-square)](https://pypi.python.org/pypi/swagger-py-codegen/)


----

CODO是一款为用户提供企业多混合云、自动化运维、完全开源的云管理平台。

CODO前端基于Vue iview开发、为用户提供友好的操作界面，增强用户体验。

CODO后端基于Python Tornado开发，其优势为轻量、简洁清晰、异步非阻塞。

CODO开源多云管理平台将为用户提供多功能：ITSM、基于RBAC权限系统、Web Terminnal登陆日志审计、录像回放、强大的作业调度系统、CMDB、监控报警系统、DNS管理、配置中心等

众多功能模块我们一直在不停的调研和开发，如果你对此项目感兴趣可以加入我们的社区交流群，

同时也希望你能给我们项目一个![](https://img.shields.io/github/stars/opendevops-cn/opendevops.svg)，为贡献者加油⛽️！为运维干杯🍻！

----

### 简单描述
- 该内容应位于codo安装步骤中vue和静态文件部分。
- 通过 swagger-py-codegen 生成swagger-ui文件，生成静态文件，复制到静态目录文件夹，即可使用swagger。

### 基于 CODO 的 swagger-py-codegen 步骤（快速使用）
*请按着CODO文档，完成操作后再进行该操作，该操作在文档中也同样存在。*

```bash
# 就是这么简单
cd /opt/codo/codo
\cp -r swagger-ui/ /var/www/codo/ 
``` 


### swagger-py-codegen 的简单使用
- python3
- pip3

__1、安装swagger-py-codegen__
```bash
pip3 install swagger-py-codegen
``` 

__2、准备or编辑yml文件__
*官方的在线编辑工具*

__https://editor.swagger.io/__

__3、swagger_py_codegen命令参考__

__https://github.com/guokr/swagger-py-codegen__
```bash
# 生成静态文件
swagger_py_codegen -tpl=tornado  -s api.yml example-app-ui -p codo --ui --spec

``` 

__4、修改index.html文件__
首次生成，需要修改html文件 之后每次替换json文件即可让swagger生效

大概是77行左右 将“url: "/swagger-ui/swagger.json",” 的 json地址，改成真实可访问地址即可
```bash
vim example-app-ui/codo/static/swagger-ui/index.html
```

__5、复制swagger文件到网站的静态文件夹目录，注意json文件位置__
```bash
\cp -r example-app-ui/codo/static/swagger-ui/ /var/www/codo/
```


__6、每次重新生成静态文件后，替换json即可__
```bash
\cp -r example-app-ui/codo/static/swagger.json /var/www/codo/swagger-ui
```