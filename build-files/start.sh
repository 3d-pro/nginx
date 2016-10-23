#!/bin/bash

rm -rf /var/run/rsyslogd.pid
service rsyslog start
cron
service ssh start
nginx
