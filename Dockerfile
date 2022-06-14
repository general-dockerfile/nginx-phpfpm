ARG IMAGE_BASE="alpine"
ARG IMAGE_TAG="3.15.4"

FROM lengyuewusheng/${IMAGE_BASE}:${IMAGE_TAG}

# Docker Build Arguments
ARG RESTY_IMAGE_BASE="alpine"
ARG RESTY_IMAGE_BASE_TAG="3.15"
ARG RESTY_APK_KEY_URL="http://openresty.org/package/admin@openresty.com-5ea678a6.rsa.pub"
ARG RESTY_APK_REPO_URL="http://openresty.org/package/alpine/v${RESTY_IMAGE_BASE_TAG}/main"
ARG RESTY_APK_VERSION="1.21.4.1-r0"
ARG PHP_APK_VERSION="7.4.29-r0"

LABEL resty_image_base="${RESTY_IMAGE_BASE}"
LABEL resty_image_tag="${RESTY_IMAGE_BASE_TAG}"
LABEL resty_apk_key_url="${RESTY_APK_KEY_URL}"
LABEL resty_apk_repo_url="${RESTY_APK_REPO_URL}"
LABEL resty_apk_version="${RESTY_APK_VERSION}"
LABEL php_image_base="${RESTY_IMAGE_BASE}"
LABEL php_image_base_tag="${RESTY_IMAGE_BASE_TAG}"
LABEL php_apk_version="${PHP_APK_VERSION}"

USER root

WORKDIR /root

RUN wget -O "/etc/apk/keys/$(basename ${RESTY_APK_KEY_URL})" "${RESTY_APK_KEY_URL}" \
    && echo "${RESTY_APK_REPO_URL}" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache --progress "openresty=${RESTY_APK_VERSION}" \
    && mkdir -pv /dev/shm/nginx /data /usr/local/openresty/nginx/conf/vhosts /usr/local/openresty/nginx/core /usr/local/openresty/site/lualib/{lib,clib} \
    && chown -R nobody:root /dev/shm/nginx /usr/local/openresty/nginx/core /usr/local/openresty/nginx/logs\
    && ln -svf /usr/local/openresty/nginx /usr/local/nginx \
    && ln -svf /usr/local/openresty/site/lualib /usr/local/openresty/nginx/lua \
    && ln -svf /usr/local/openresty/nginx /data/nginx \
    && apk add --no-cache --progress php7=${PHP_APK_VERSION} \
    php7-bcmath=${PHP_APK_VERSION} \
    php7-bz2=${PHP_APK_VERSION} \
    php7-calendar=${PHP_APK_VERSION} \
    php7-common=${PHP_APK_VERSION} \
    php7-ctype=${PHP_APK_VERSION} \
    php7-curl=${PHP_APK_VERSION} \
    php7-dba=${PHP_APK_VERSION} \
    php7-dev=${PHP_APK_VERSION} \
    php7-dom=${PHP_APK_VERSION} \
    php7-embed=${PHP_APK_VERSION} \
    php7-enchant=${PHP_APK_VERSION} \
    php7-exif=${PHP_APK_VERSION} \
    php7-ffi=${PHP_APK_VERSION} \
    php7-fileinfo=${PHP_APK_VERSION} \
    php7-fpm=${PHP_APK_VERSION} \
    php7-ftp=${PHP_APK_VERSION} \
    php7-gd=${PHP_APK_VERSION} \
    php7-gettext=${PHP_APK_VERSION} \
    php7-gmp=${PHP_APK_VERSION} \
    php7-iconv=${PHP_APK_VERSION} \
    php7-imap=${PHP_APK_VERSION} \
    php7-intl=${PHP_APK_VERSION} \
    php7-json=${PHP_APK_VERSION} \
    php7-ldap=${PHP_APK_VERSION} \
    php7-litespeed=${PHP_APK_VERSION} \
    php7-mbstring=${PHP_APK_VERSION} \
    php7-mysqli=${PHP_APK_VERSION} \
    php7-mysqlnd=${PHP_APK_VERSION} \
    php7-odbc=${PHP_APK_VERSION} \
    php7-opcache=${PHP_APK_VERSION} \
    php7-openssl=${PHP_APK_VERSION} \
    php7-pcntl=${PHP_APK_VERSION} \
    php7-pdo=${PHP_APK_VERSION} \
    php7-pdo_dblib=${PHP_APK_VERSION} \
    php7-pdo_mysql=${PHP_APK_VERSION} \
    php7-pdo_odbc=${PHP_APK_VERSION} \
    php7-pdo_pgsql=${PHP_APK_VERSION} \
    php7-pdo_sqlite=${PHP_APK_VERSION} \
    php7-pear=${PHP_APK_VERSION} \
    php7-pgsql=${PHP_APK_VERSION} \
    php7-phar=${PHP_APK_VERSION} \
    php7-posix=${PHP_APK_VERSION} \
    php7-pspell=${PHP_APK_VERSION} \
    php7-session=${PHP_APK_VERSION} \
    php7-shmop=${PHP_APK_VERSION} \
    php7-simplexml=${PHP_APK_VERSION} \
    php7-snmp=${PHP_APK_VERSION} \
    php7-soap=${PHP_APK_VERSION} \
    php7-sockets=${PHP_APK_VERSION} \
    php7-sodium=${PHP_APK_VERSION} \
    php7-sqlite3=${PHP_APK_VERSION} \
    php7-static=${PHP_APK_VERSION} \
    php7-sysvmsg=${PHP_APK_VERSION} \
    php7-sysvsem=${PHP_APK_VERSION} \
    php7-sysvshm=${PHP_APK_VERSION} \
    php7-tidy=${PHP_APK_VERSION} \
    php7-tokenizer=${PHP_APK_VERSION} \
    php7-xml=${PHP_APK_VERSION} \
    php7-xmlreader=${PHP_APK_VERSION} \
    php7-xmlrpc=${PHP_APK_VERSION} \
    php7-xmlwriter=${PHP_APK_VERSION} \
    php7-xsl=${PHP_APK_VERSION} \
    php7-zip=${PHP_APK_VERSION} \
    php7-pecl-amqp \
    php7-pecl-apcu \
    php7-pecl-ast \
    php7-pecl-couchbase \
    php7-pecl-event \
    php7-pecl-gmagick \
    php7-pecl-igbinary \
    php7-pecl-imagick \
    php7-pecl-imagick-dev \
    php7-pecl-lzf \
    php7-pecl-mailparse \
    php7-pecl-maxminddb \
    php7-pecl-mcrypt \
    php7-pecl-memcache \
    php7-pecl-memcached \
    php7-pecl-mongodb \
    php7-pecl-msgpack \
    php7-pecl-oauth \
    php7-pecl-protobuf \
    php7-pecl-psr \
    php7-pecl-redis \
    php7-pecl-ssh2 \
    php7-pecl-timezonedb \
    php7-pecl-uploadprogress \
    php7-pecl-uuid \
    php7-pecl-vips \
    php7-pecl-yaml \
    php7-pecl-zmq \
    php7-brotli \
    php7-phalcon \
    # php7-doc=${PHP_APK_VERSION} \
    # php7-pecl-uploadprogress-doc \
    # php7-apache2=${PHP_APK_VERSION} \
    # php7-dbg=${PHP_APK_VERSION} \
    # php7-phpdbg=${PHP_APK_VERSION} \
    # php7-cgi=${PHP_APK_VERSION} \
    # php7-pecl-xdebug \
    # php7-pecl-xhprof \
    # php7-pecl-xhprof-assets \
    && mkdir -pv /var/log/php && chown -R nobody:root /var/log/php \
    && rm -rvf /etc/php7/conf.d/*.ini /etc/logrotate.d/php-fpm7 /etc/apk/keys/$(basename ${RESTY_APK_KEY_URL}) /var/cache/apk/*

COPY nginx/ /usr/local/openresty/nginx/
COPY etc/php7/ /etc/php7/
COPY etc/logrotate.d/ /etc/logrotate.d/

ENV PATH=$PATH:/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin

EXPOSE 80

CMD ["/usr/local/nginx/scripts/entrypoint.sh"]

STOPSIGNAL SIGQUIT

