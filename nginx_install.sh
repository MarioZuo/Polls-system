

#install nginx
#!/bin/bash

yum install -y gcc-c++
yum install -y pcre pcre-devel
yum install -y zlib zlib-devel
yum install -y openssl openssl-devel
wget http://nginx.org/download/nginx-1.17.3.tar.gz
tar -xvzf nginx-1.17.3
cd nginx-1.17.3.tar.gz

 ./configure \
--prefix=/usr/local/nginx \
--pid-path=/var/run/nginx/nginx.pid \
--lock-path=/var/lock/nginx.lock \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_gzip_static_module \
--http-client-body-temp-path=/var/temp/nginx/client \
--http-proxy-temp-path=/var/temp/nginx/proxy \
--http-fastcgi-temp-path=/var/temp/nginx/fastcgi \
--http-uwsgi-temp-path=/var/temp/nginx/uwsgi \
--http-scgi-temp-path=/var/temp/nginx/scgi

make && make install

cat > /usr/lib/systemd/system/nginx.service << EOF
[Unit]
Description=nginx - high performance web server
Documentation=http://nginx.org/en/docs/
After=network.target remote-fs.target nss-lookup.target
 
[Service]
Type=forking
PIDFile=/usr/local/nginx/logs/nginx.pid
ExecStartPre=/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true
 
[Install]
WantedBy=multi-user.target

EOF

change /usr/local/nginx/conf/nginx.conf
pid /usr/local/nginx/logs/nginx.pid;



#install python3

cd /home/usr/local/python3
wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
tar -zxvf Python-3.7.4.tgz 
yum install -y gcc  
yum install -y zlib*
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel
cd Python-3.7.4/
./configure --prefix=/usr/local/python3 --with-ssl
make && +make install
ln -s /usr/local/python3/bin/python3 /usr/bin/python3 
ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3 


pip3 install django
pip3 install ipython 
ln -s /usr/local/python3/bin/ipython3 /usr/bin/ipython3

wget https://www.sqlite.org/2019/sqlite-autoconf-3290000.tar.gz
tar -xvzf sqlite-autoconf-3290000.tar.gz
cd sqlite-autoconf-3290000
./configure
make
make install
export LD_LIBRARY_PATH="/usr/local/lib"   ->> ~/.bashrc


add '*' to allowed_hosts in project folder setting.py










