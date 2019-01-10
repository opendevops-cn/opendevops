### API网关

> 由于此项目是模块化、微服务化，因此需要在借助API网关，需要在API网关注册，此步骤是必须的。

**安装openresty**

```shell
yum update
yum install yum-utils -y
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum install openresty -y
yum install openresty-resty -y
```

**部署网关**
```shell
cd /opt/codo/ && git clone https://github.com/ss1917/api-gateway.git
\cp -arp api-gateway/* /usr/local/openresty/nginx/
```

**修改配置**
> 主要修改`nginx.conf`配置信息和`config.lua`配置，具体参考API网关块：[API网关修改配置](https://github.com/ss1917/api-gateway/blob/master/README.md#%E4%BA%8C-%E4%BF%AE%E6%94%B9%E9%85%8D%E7%BD%AE)

接下来配置：

    因为我把前端静态文件也使用 网关进行代理 所以配置文件如下

```nginx
# 全局nginx配置
#  /usr/local/openresty/nginx/conf/nginx.conf
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
    lua_code_cache off;         #线上环境设置为on, off时可以热加载lua文件
    lua_shared_dict user_info 1m;
    lua_shared_dict my_limit_conn_store 100m;   #100M可以放1.6M个键值对
    include             mime.types;

    client_header_buffer_size 64k;
    large_client_header_buffers 4 64k;
    proxy_redirect off;
    proxy_buffering off;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Scheme $scheme;

    init_by_lua_file lua/init_by_lua.lua;       #nginx启动时就会执行
    #include /etc/nginx/conf.d/*.conf;
    include ./conf.d/*.conf;                    #lua生成upstream
    resolver 10.2.2.236;                        # 内部DNS地址，上面dnsmasq地址

}
```

```shell
#前端vhosts
mkdir -p /usr/local/openresty/nginx/conf/conf.d/
# /usr/local/openresty/nginx/conf/conf.d/demo.conf
server {
        listen       80;
        server_name demo.opendevops.cn;
        access_log /var/log/nginx/f_access.log;
        error_log  /var/log/nginx/f_error.log;
        root /var/www/admin-front;

        location / {
                    root /var/www/admin-front;
                    index index.html index.htm;
                    try_files $uri $uri/ /index.html;
                    }

        location /api {
                ### ws 支持
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";

                add_header 'Access-Control-Allow-Origin' '*';
                proxy_pass http://gw.opendevops.cn;
        }

        location ~ /(.svn|.git|admin|manage|.sh|.bash)$ {
            return 403;
        }
}

```

```shell
#网关vhosts
# /usr/local/openresty/nginx/conf/conf.d/gw.conf
    server {
        listen 80;
        server_name  gw.opendevops.cn;
        lua_need_request_body on;           # 开启获取body数据记录日志

        location / {
            ### ws 支持
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            access_by_lua_file lua/access_check.lua;
            set $my_upstream $my_upstream;
            proxy_pass http://$my_upstream;

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

**API网关启动**
```shell
#OpenResty 是一个基于 Nginx 与 Lua 的高性能 Web 平台，使用的也是80端口，若不能启动请检查你的80端口是否被占用了
systemctl start openresty
systemctl enable openresty

```

