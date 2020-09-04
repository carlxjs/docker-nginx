FROM nginx:1.19.2

# prepare source code
RUN \
cd /usr/local/src && \
curl -O https://nginx.org/download/nginx-1.19.2.tar.gz  && \
tar -xzf nginx-1.19.2.tar.gz && \
apt update && \
apt install wget -y && \
wget https://github.com/openresty/echo-nginx-module/archive/v0.62.tar.gz && \
tar -xzf v0.62.tar.gz

# install some required
RUN \
apt install gcc -y && \
apt install libpcre3 libpcre3-dev -y && \
apt install openssl libssl-dev -y && \
apt install zlib1g.dev -y && \
apt install make -y

# rebuild nginx with echo module
RUN \  
cd /usr/local/src/nginx-1.19.2 && \
#  copy the config content from 'nginx -V'
./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -fdebug-prefix-map=/data/builder/debuild/nginx-1.19.2/debian/debuild-base/nginx-1.19.2=. -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie' --add-module=../echo-nginx-module-0.62/ && \
make && \
# keep the original nginx and replace it
mv /usr/sbin/nginx /usr/sbin/nginx.bak && \
cp ./objs/nginx /usr/sbin/   
