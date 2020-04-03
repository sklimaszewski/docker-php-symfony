FROM php:7.3.14-fpm-alpine

## Install system dependencies, imagemagick, yarn, wkhtmltopdf and mongodb tools
RUN apk update && \
    apk add --no-cache --virtual dev-deps autoconf gcc g++ make && \
    apk add --no-cache git rsync bash bash-completion nano curl unzip \
        openssl-dev zlib-dev libzip-dev libxslt-dev icu-dev freetype-dev libpng-dev libxpm-dev  \
        imagemagick-dev imagemagick jpegoptim libjpeg-turbo-dev \
        nodejs-npm yarn \
        wkhtmltopdf \
        mongodb-tools

## Install php extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ --with-xpm-dir=/usr/include/ --enable-gd-jis-conv && \
    echo "autodetect" | pecl install imagick && \
    echo "no" | pecl install mongodb-1.6.1 && \
    echo "no" | pecl install redis && \
    docker-php-ext-enable opcache imagick redis mongodb && \
    docker-php-ext-install iconv exif gd pcntl intl xsl xml json zip

## Install composer
RUN wget https://getcomposer.org/installer && \
    php installer --install-dir=/usr/local/bin/ --filename=composer && \
    rm installer && \
    composer global require hirak/prestissimo

## Cleanup
RUN apk del dev-deps

ENV PS1="\u@\h:\w\\$ "

## Create target directory
RUN mkdir -p /var/www/symfony
WORKDIR /var/www/symfony

CMD ["php-fpm"]