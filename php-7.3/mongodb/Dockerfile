FROM php:7.3-fpm-alpine

## Install extra system dependencies
RUN apk update && \
    apk add --no-cache --virtual dev-deps autoconf gcc g++ make && \
    apk add --no-cache git rsync bash bash-completion nano curl unzip openssl-dev \
        libzip-dev libxslt-dev icu-dev freetype-dev libpng-dev libxpm-dev libjpeg-turbo-dev \
        imagemagick-dev imagemagick jpegoptim \
        nodejs yarn \
        mongodb-tools && \
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ --with-xpm-dir=/usr/include/ --enable-gd-jis-conv && \
    echo "autodetect" | pecl install imagick && \
    echo "no" | pecl install mongodb-1.6.1 && \
    echo "no" | pecl install redis && \
    docker-php-ext-enable opcache imagick redis mongodb && \
    docker-php-ext-install iconv exif gd pcntl intl xsl xml json zip && \
    apk del --no-cache dev-deps && \
    rm -rf /var/cache/apk/* && rm -rf /tmp/*

## Install proper alpine iconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

## Install composer
RUN wget https://getcomposer.org/installer && \
    php installer --install-dir=/usr/local/bin/ --filename=composer && \
    rm installer

ENV PS1="\u@\h:\w\\$ "

## Create target directory
RUN mkdir -p /var/www/html/project/symfony
WORKDIR /var/www/html/project/symfony

CMD ["php-fpm"]