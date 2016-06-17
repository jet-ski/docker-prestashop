FROM php:7-fpm-alpine

RUN apk upgrade --update && apk add nginx coreutils autoconf file g++ gcc binutils isl libatomic libc-dev \
   musl-dev make re2c libstdc++ libgcc binutils-libs mpc1 mpfr3 gmp libgomp \
  coreutils freetype-dev libjpeg-turbo-dev libltdl libmcrypt-dev libpng-dev icu-dev libxslt-dev


RUN    docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN wget http://download.prestashop.com/download/releases/prestashop_1.6.1.6.zip -O /tmp/prestashop.zip


#RUN unzip -q prestashop.zip -d /tmp/ && mv /tmp/prestashop/* /var/www/html

ADD entrypoint.sh /entrypoint.sh
ADD nginx.conf /etc/nginx/nginx.conf

RUN apk upgrade --update && apk add mysql-dev
RUN docker-php-ext-install -j$(nproc) mysqli  pdo pdo_mysql


# ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]

