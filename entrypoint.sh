#!/bin/sh

DIR=/var/www/html
if [ -n "$(ls -A $DIR)" ]; then
   echo "$DIR is not empty. Running php-fpm with its content"
else
    echo "$DIR is empty. Initialising prestashop from zip"
    unzip -q /tmp/prestashop.zip -d /tmp/ && mv /tmp/prestashop/* /var/www/html
fi

php-fpm

