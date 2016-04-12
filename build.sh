#!/bin/bash
# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use the root user to install the software."
    exit 1
fi

clear && clear

echo "Did you run this script before? (y/n)"
read ft

if [ $ft = "n" ]
then
        #Installing Nginx to get the init.d and systemd unit scripts ###only the first time
        apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
        apt-get install curl nginx-full nginx nginx-common libxslt-dev libpcre3 libpcre3-dev build-essential zlib1g-dev libbz2-dev libssl-dev tar unzip curl git  -y
        
        #Removing
        apt-get remove nginx-full nginx nginx-common -y
fi


#Download Latest ngxin & LibreSSL, then extract.
latest_nginx=$(curl -L http://nginx.org/en/download.html | egrep -o "nginx\-[0-9.]+\.tar[.a-z]*" | head -n 1)
latest_libressl=$(curl -L http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/ | egrep -o "libressl\-[0-9.]+\.tar\.gz" | tail -n 1)

(curl -fLRO "http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${latest_libressl}" && tar -xaf "${latest_libressl}") &
(curl -fLRO "http://nginx.org/download/${latest_nginx}" && tar -xaf "${latest_nginx}") &
wait

cd "${latest_nginx//.tar*}"


#Configure & make & install
./configure \
--http-client-body-temp-path=/usr/local/etc/nginx/body \
--http-fastcgi-temp-path=/usr/local/etc/nginx/fastcgi \
--http-proxy-temp-path=/usr/local/etc/nginx/proxy \
--http-scgi-temp-path=/usr/local/etc/nginx/scgi \
--http-uwsgi-temp-path=/usr/local/etc/nginx/uwsgi \
--user=www-data \
--group=www-data \
--prefix=/etc/nginx \
--sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/usr/local/etc/nginx.pid \
--lock-path=/usr/local/etc/nginx.lock \
--with-pcre-jit \
--with-ipv6 \
--with-http_v2_module \
--with-debug \
--with-http_stub_status_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_dav_module \
--with-http_gzip_static_module \
--with-http_sub_module \
--with-http_xslt_module \
--with-file-aio \
--with-threads \
--with-http_ssl_module \
--with-http_geoip_module \
--with-openssl=../${latest_libressl//.tar*} \
--with-ld-opt=-lrt

make
make install

if [ $ft = "n" ]
then
        #Configure Nginx service
        systemctl unmask nginx.service
        mkdir /usr/local/etc/nginx
        mkdir /usr/local/etc/nginx/body
        service nginx stop
        service nginx start
fi

if [ $ft = "y" ]
then
        service nginx stop
        service nginx start
fi
