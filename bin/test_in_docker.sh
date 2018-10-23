#!/bin/bash

if [ -z "$PHP_VERSION" ];
then
    PHP_VERSION=7.0
fi

docker run --rm -v `pwd`:/app:ro -it "php:${PHP_VERSION}-cli" sh -c "apt-get update && apt-get install -yq zip && rm -rf /var/lib/apt/lists/* && \
    php -r \"copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');\" && \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    cp -r /app/. /app-running/ && cd /app-running && \
    composer --prefer-dist install && \
    ./vendor/bin/phpunit -v"