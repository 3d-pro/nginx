FROM 3dpro/openssh

ADD build-files /build-files
RUN echo 'Acquire::http::Proxy "http://172.17.0.1:3142";' > /etc/apt/apt.conf.d/11proxy && \
    apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y nginx libnginx-mod-http-dav-ext && \
    sed -i 's/rotate .*/rotate 90/g' /etc/logrotate.d/nginx && \
    sed -i 's/weekly/daily/g' /etc/logrotate.d/nginx && \
    sed -i 's/invoke-rc.d nginx rotate >\/dev\/null 2>&1/[ ! -f \/var\/run\/nginx.pid ] || kill -USR1 `cat \/var\/run\/nginx.pid`/g' /etc/logrotate.d/nginx && \
    mv /build-files/nginx.conf /etc/nginx/nginx.conf && \
    mv /build-files/gzip.conf /etc/nginx/conf.d/gzip.conf && \
    rm /etc/logrotate.d/nginx && \
    mv /build-files/nginx.logrotate /etc/logrotate.d/nginx && \
    chmod 644 /etc/logrotate.d/nginx && \
    mv /build-files/start.sh /start.sh && \
    chmod 600 /root/.ssh/authorized_keys && \
    chown root:root /start.sh && \
    chmod 700 /start.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /build-files /etc/apt/apt.conf.d/11proxy

VOLUME ["/var/log", "/etc/nginx", "/etc/ssl", "/root/.ssh"]

CMD ["/start.sh"]

EXPOSE 80 443
