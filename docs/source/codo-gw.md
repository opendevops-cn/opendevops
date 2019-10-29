### API网关（部署容易出问题的地方）

==重点仔细看==

> 由于此项目是模块化、微服务化，因此需要在借助API网关，需要在API网关注册，此步骤是必须的。


**注意事项**

开始之前，你需要确认以下2个事情

- DNS服务是否正常，域名能否正常解析
- 微服务的模块部署是否正常，进行检测

**检查DNS思路**

```shell
1. 确保你的dnsmasql服务是启动的，服务没有报错
2. 确保/etc/dnsmasqhosts文件有解析的IP
3. 确保你网关的这台机器/etc/resolv.conf DNS执行你刚部署的dnsmasq服务IP
4. 确保你网关所在的机器都能正常ping通所有的服务，比如：ping cmdb2.opendevops.cn
5. 确保你的防火墙规则是清空的`iptables -F`
6. 确保你的SELINUX是关闭的`setenforce 0`
```

**服务健康检测**

```
# 进行所有服务进行检测，返回200则正常
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://mg.opendevops.cn:8010/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://task.opendevops.cn:8020/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://cmdb2.opendevops.cn:8050/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://kerrigan.opendevops.cn:8030/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://cron.opendevops.cn:9900/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://tools.opendevops.cn:8040/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://dns.opendevops.cn:8060/are_you_ok/
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://0.0.0.0:80
```


**下载网关**
```shell
cd /opt/codo/ && git clone https://github.com/ss1917/api-gateway.git && cd /opt/codo/api-gateway
```

**修改配置**
> 主要修改`nginx.conf`配置信息和`config.lua`配置，具体参考API网关块：[API网关修改配置](https://github.com/ss1917/api-gateway/blob/master/README.md#%E4%BA%8C-%E4%BF%AE%E6%94%B9%E9%85%8D%E7%BD%AE)


**全局nginx配置**   

这里主要修改resolver 内部DNS服务器地址`conf/nginx.conf` ==一定要修改==

```nginx
user root;
worker_processes auto;
worker_rlimit_nofile 51200;
error_log logs/error.log;
events {
    use epoll;
    worker_connections 51024;
}
http {
    #设置默认lua搜索路径
    lua_package_path '$prefix/lua/?.lua;/blah/?.lua;;';
    lua_code_cache on;      #线上环境设置为on, off时可以热加载lua文件
    lua_shared_dict user_info 1m;
    lua_shared_dict my_limit_conn_store 100m;   #100M可以放1.6M个键值对
    include             mime.types;    #代理静态文件

    client_header_buffer_size 64k;
    large_client_header_buffers 4 64k;

    init_by_lua_file lua/init_by_lua.lua;       # nginx启动时就会执行
    include ./conf.d/*.conf;                    # lua生成upstream
    resolver 10.10.10.12;                       # 内部DNS服务器地址 一定要修改 对应起来
}
```


**网关配置** `conf/conf.d/gw.conf`
```nginx
server {
    listen 80;
    server_name gw.opendevops.cn;
    lua_need_request_body on;           # 开启获取body数据记录日志

    location / {
        ### ws 支持
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        ### 获取真实IP
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        access_by_lua_file lua/access_check.lua;
        set $my_upstream $my_upstream;
        proxy_pass http://$my_upstream;

        ### 跨域
        add_header Access-Control-Allow-Methods *;
        add_header Access-Control-Max-Age 3600;
        add_header Access-Control-Allow-Credentials true;
        add_header Access-Control-Allow-Origin $http_origin;
        add_header Access-Control-Allow-Headers $http_access_control_request_headers;
        if ($request_method = OPTIONS){
            return 204;}
    }
}

```


**注册API网关**

请仔细阅读下面需要修改配置的地方`vim lua/configs.lua` ==这个配置基本上都要修改，请务必仔细==


```lua
json = require("cjson")


-- redis配置，一定要修改，并且和codo-admin保持一致，admin会把权限写进去提供网关使用
redis_config = {
    host = '10.10.10.12',
    port = 6379,
    auth_pwd = 'cWCVKJ7ZHUK12mVbivUf',
    db = 8,
    alive_time = 3600 * 24 * 7,
    channel = 'gw'
}


-- 注意：这里的token_secret必须要和codo-admin里面的token_secret保持一致
token_secret = "pXFb4i%*834gfdh96(3df&%18iodGq4ODQyMzc4lz7yI6ImF1dG"
logs_file = '/var/log/gw.log'

--刷新权限到redis接口
rewrite_cache_url = 'http://mg.opendevops.cn:8010/v2/accounts/verify/'

-- 注意：rewrite_cache_token要和codo-admin里面的secret_key = '8b888a62-3edb-4920-b446-697a472b4001'保持一致
rewrite_cache_token = '8b888a62-3edb-4920-b446-697a472b4001'  


--并发限流配置
limit_conf = {
    rate = 10, --限制ip每分钟只能调用n*60次接口
    burst = 10, --桶容量,用于平滑处理,最大接收请求次数
}

--upstream匹配规则,API网关域名
gw_domain_name = 'gw.opendevops.cn' 

--下面的转发一定要修改，根据自己实际数据修改
rewrite_conf = {
    [gw_domain_name] = {
        rewrite_urls = {
            {
                uri = "/dns",
                rewrite_upstream = "dns.opendevops.cn:8060"
            },
            {
                uri = "/cmdb2",
                rewrite_upstream = "cmdb2.opendevops.cn:8050"
            },
            {
                uri = "/tools",
                rewrite_upstream = "tools.opendevops.cn:8040"
            },
            {
                uri = "/kerrigan",
                rewrite_upstream = "kerrigan.opendevops.cn:8030"
            },
            {
                uri = "/cmdb",
                rewrite_upstream = "cmdb.opendevops.cn:8002"
            },
            {
                uri = "/k8s",
                rewrite_upstream = "k8s.opendevops.cn:8001"
            },
            {
                uri = "/task",
                rewrite_upstream = "task.opendevops.cn:8020"
            },
            {
                uri = "/cron",
                rewrite_upstream = "cron.opendevops.cn:9900"
            },
            {
                uri = "/mg",
                rewrite_upstream = "mg.opendevops.cn:8010"
            },
            {
                uri = "/accounts",
                rewrite_upstream = "mg.opendevops.cn:8010"
            },
        }
    }
}

```

**修改Dockerfile**

使用自动构建的镜像，默认使用最新版本，这一步的目的是把修改后的配置覆盖进去

```
cat >Dockerfile <<EOF
FROM registry.cn-shanghai.aliyuncs.com/ss1917/api-gateway

#修改配置
ADD . /usr/local/openresty/nginx/

EXPOSE 80
CMD ["/usr/bin/openresty", "-g", "daemon off;"]
EOF

```

**编译，启动**

```
#编译镜像
docker build . -t gateway_image
#启动
docker-compose up -d
```

启动后地址为`http://gw.opendevops.cn:8888`，这里是和前端的地址有对应，请勿修改

```
#测试一下
curl -I -X GET -m 10 -o /dev/null -s -w %{http_code} http://gw.opendevops.cn:8888/api/accounts/are_you_ok/
```

> 提醒:openresty服务器DNS必须指向--->最起初部署的DNS服务器地址,另外若你本机ping以上随便一个域名都不通的话，那你要确认下你本机DNS指向你最初部署了DNS服务器了？ 修改vim /etc/resolv.conf



**访问**

`注意： demo-init.opendevops.cn 建议修改成自己的域名，也可以绑定hosts来测试一下`  可以再部署前端的时候修改

- 地址：demo-init.opendevops.cn
- 用户：admin
- 密码：admin@opendevops

**日志路径**

> 若这里访问有报错，请看下日志，一般都是配置错误。
- 日志路径：所有模块日志统一`/var/log/supervisor/`


**特别感谢**  

感谢大佬 `shenyingzhi` 提供测试环境，特此致谢