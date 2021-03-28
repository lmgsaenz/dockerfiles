#!/bin/bash -e

if $DO_JINJA ; then
#APACHE
  j2 /root/jinja.d/nginx.conf.j2 > /etc/nginx/nginx.conf
  j2 /root/jinja.d/nginx-site.j2 > /etc/nginx/sites-enabled/default
#PHP
  mkdir -p /etc/php/$PHP_VERSION/fpm/pool.d/include.d
  mkdir -p /var/log/php-fpm
  j2 /root/jinja.d/php-fpm-pool-www.j2    > /etc/php/$PHP_VERSION/fpm/pool.d/www.conf
  #php-fpm.conf
  j2 /root/jinja.d/php-fpm.conf.j2        > /etc/php/$PHP_VERSION/fpm/php-fpm.conf
  # pool config
  j2 /root/jinja.d/supervisord.conf.j2 > /etc/supervisor/supervisord.conf
  # opcache
  j2 /root/jinja.d/php-opcache.j2         > /etc/php/$PHP_VERSION/fpm/conf.d/10-opcache.ini
  # extra php conf
  j2 /root/jinja.d/php-custom-extras.j2 > /etc/php/$PHP_VERSION/fpm/conf.d/22-custom-extras.ini
# Config TimeZone
  if ! [ -z $TZ ] && [ -f /usr/share/zoneinfo/$TZ ]; then
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
  fi
fi
/usr/bin/supervisord