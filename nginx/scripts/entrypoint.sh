#!/bin/sh

pgrep crond >/dev/null 2>&1 || /usr/sbin/crond -L /var/log/crond/cron.log

/usr/sbin/php-fpm7 -c /etc/php7/php-fpm.conf -t && /usr/sbin/php-fpm7 -c /etc/php7/php-fpm.conf -D
sleep 1
mkdir -pv /dev/shm/nginx
chown -R nobody:root /dev/shm/nginx
/usr/local/nginx/sbin/nginx -t && /usr/local/nginx/sbin/nginx -g "daemon off;"

