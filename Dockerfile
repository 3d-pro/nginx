FROM 3dpro/openssh:latest

COPY build-files /build-files
RUN apt-get update && \
    sed -i '/^weekly/a \dateext\ndateformat .%Y%m%d' /etc/logrotate.conf && \
    sed -i 's/\trotate .*/\trotate 365/g' /etc/logrotate.d/rsyslog && \
    # sed -i 's/reload rsyslog/service rsyslog rotate/g' /etc/logrotate.d/rsyslog && \
    sed -i 's/--pidfile \$PIDFILE --exec \$DAEMON$/--pidfile \$PIDFILE/g' /etc/init.d/rsyslog && \
    sed -i '/^\($ModLoad imklog\|$KLogPermitNonKernelFacility\)/ s/^#*/#/' /etc/rsyslog.conf && \
    service rsyslog start && \
    service rsyslog stop && \
    apt-get install --no-install-recommends -y nginx libnginx-mod-http-dav-ext && \
    sed -i 's/rotate .*/rotate 90/g' /etc/logrotate.d/nginx && \
    sed -i 's/weekly/daily/g' /etc/logrotate.d/nginx && \
    sed -i 's/invoke-rc.d nginx rotate >\/dev\/null 2>&1/[ ! -f \/var\/run\/nginx.pid ] || kill -USR1 `cat \/var\/run\/nginx.pid`/g' /etc/logrotate.d/nginx && \
    mv /build-files/nginx.conf /etc/nginx/nginx.conf && \
    mv /build-files/gzip.conf /etc/nginx/conf.d/gzip.conf && \
    rm /etc/logrotate.d/nginx && \
    mv /build-files/nginx.logrotate /etc/logrotate.d/nginx && \
    chmod 644 /etc/logrotate.d/nginx && \
    mv /build-files/start.sh /start.sh && \
    chown root:root /start.sh && \
    chmod 700 /start.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /build-files

VOLUME ["/var/log", "/etc/nginx", "/etc/ssl", "/root/.ssh"]

CMD ["/start.sh"]

EXPOSE 80 443
