FROM php:fpm-alpine3.7

# Install selected extensions and other stuff
RUN apk add --update \
        autoconf \
        g++ \
        libtool \
        make \
        libmcrypt-dev \
        icu-dev \
        zlib-dev \
        libldap \
        openldap-dev \
        libxslt \
        libxslt-dev \
        libssh2 \
        libssh2-dev \
        git \
    && docker-php-source extract \
    && docker-php-ext-install opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-install ldap \
    && pecl install mcrypt-1.0.1 \
    && pecl install redis \
    && pecl install xdebug \
    && pecl install raphf \
    && pecl install propro \
    && pecl install ssh2-alpha \
    && docker-php-ext-install soap \
    && docker-php-ext-install zip \
    && docker-php-ext-install xsl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pcntl \
    && docker-php-ext-enable \
        ssh2 \
        xdebug \
        redis \
        mcrypt \
        raphf \
        propro \
        pcntl \
    && pecl install pecl_http \
    && docker-php-source delete \
    && apk del \
        autoconf \
        bash \
        binutils \
        binutils-libs \
        db \
        expat \
        file \
        g++ \
        gcc \
        gdbm \
        gmp \
        isl \
        libatomic \
        libbz2 \
        libc-dev \
        libffi \
        libgcc \
        libgomp \
        libldap \
        libltdl \
        libmagic \
        libsasl \
        libstdc++ \
        libtool \
#        openldap-dev \
#        libxslt-dev \
#        icu-dev \
        m4 \
        make \
        mpc1 \
        mpfr3 \
        musl-dev \
        perl \
        pkgconf \
        pkgconfig \
        python \
        re2c \
        readline \
        sqlite-libs \
        zlib-dev \
    && rm -rf /tmp/* /var/cache/apk/* /usr/local/etc/php/conf.d/docker-php-ext-propro.ini /usr/local/etc/php/conf.d/docker-php-ext-raphf.ini
ADD ./files/fpm/php.ini /usr/local/etc/php/
ADD ./files/fpm/http.ini /usr/local/etc/php/conf.d/
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
WORKDIR /var/www/s4
RUN chown www-data.www-data /var/www/s4
USER www-data