FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    lsb-release \
    curl \
    lsof \
    nano \
    ca-certificates \
    wget \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
    && apt-get update && apt-get install -y \
    php8.1-fpm \
    php8.1-mysql \
    php8.1-curl \
    php8.1-gd \
    php8.1-intl \
    php8.1-mbstring \
    php8.1-xml \
    php8.1-zip \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/8.1/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

COPY ./conf/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

RUN mkdir -p /run/php
RUN touch /run/php/php8.1-fpm.sock
RUN chown -R www-data:www-data /run/php

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT [ "bash", "/tmp/setup.sh" ]