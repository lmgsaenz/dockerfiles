FROM debian:buster-slim
LABEL maintainer=lmgsaenz

ENV DEBIAN_FRONTEND=noninteractive
ENV PHP_VERSION=8.0

RUN apt update \
    && apt -y --no-install-recommends install \
        apt-transport-https ca-certificates wget curl gnupg2 git \
        bash vim net-tools procps lsb-release cron supervisor python-pip \
    && pip install setuptools && pip install j2cli[yaml] \
    && wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
    && apt update \
    && apt -y --no-install-recommends install \
        nginx php${PHP_VERSION} php${PHP_VERSION}-fpm php${PHP_VERSION}-curl php${PHP_VERSION}-zip \
        php${PHP_VERSION}-mysql \
    && rm -rf /var/lib/apt/lists/* /var/lib/archieves/*.deb

COPY files/ /root/files

RUN \
    mv /root/files/jinja.d/                                         /root/      \
    && mv /root/files/entrypoint.sh                                 /root/      \
    && rm -rf /root/files                                                       \
    && ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/sbin/php-fpm                  \
    && ln -sf /dev/stdout /var/log/nginx/access.log                             \
    && ln -sf /dev/stderr /var/log/nginx/error.log                              \
    && chown -R www-data:www-data /var/www/html                                 \
    && chmod +x /root/entrypoint.sh

ENV \
    DO_JINJA="true"                         \
    NGINX_DOCUMENTROOT="/var/www/html"      \
    NGINX_WORKER_PROCESSES="5"              \
    NGINX_ENABLE_HTST="true"                \
    NGINX_HSTS_MAXAGE="4838400"             \
    NGINX_STATUS_PATH="/nginx-status"       \
    CLIENT_MAX_BODY_SIZE="32M"              \
    PHPFPM_ENABLE_TCP="false"               \
    PHPFPM_TCP_PORT="9000"                  \
    PHP_MAX_EXEC_TIME="60"                  \
    PHP_MAX_INPUT_VARS="1000"               \
    PHPFPM_PROC_MANAGER="ondemand"          \
    PHPFPM_MAX_CHILDREN="5"                 \
    PHPFPM_START_SERVERS="3"                \
    PHPFPM_MIN_SPARE_SERVERS="2"            \
    PHPFPM_MAX_SPARE_SERVER="4"             \
    PHPFPM_PROC_IDLE_TIMEOUT="5s"           \
    PHPFPM_MAX_REQUESTS="100"               \
    PHPFPM_STATUS_PATH="/fpm-status"        \
    PHPFPM_ERROR_LOG_PATH="/proc/1/fd/1"    \
    PHPFPM_LOG_ERRORS="on"                  \
    PHPFPM_MEM_LIMIT="128M"                 \
    PHPFPM_CLEAR_ENV="yes"                  \
    PHPFPM_ENABLE_OPCACHE="true"            \   
    KEEPALIVE_TIMEOUT="5"                   \
    KEEPALIVE_REQUESTS="1000"               \
    ENABLE_CROND="true"

EXPOSE 80

ENTRYPOINT ["/root/entrypoint.sh"]