FROM php:7.4-fpm-alpine

## Install extra system dependencies
RUN apk update && \
    apk add --no-cache --virtual dev-deps autoconf gcc g++ make && \
    apk add --no-cache git rsync bash bash-completion nano curl unzip openssl-dev \
        libzip-dev libxslt-dev icu-dev freetype-dev libpng-dev libxpm-dev libjpeg-turbo-dev \
        nodejs yarn \
        mongodb-tools && \
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv && \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-xpm && \
    echo "no" | pecl install mongodb-1.6.1 && \
    docker-php-ext-enable opcache mongodb && \
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