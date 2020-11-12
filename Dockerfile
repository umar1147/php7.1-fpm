FROM php:7.1-fpm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /www

RUN apt-get update && \
  apt-get upgrade -y

RUN apt-get install -y wget bash zip  zlib1g-dev libpng-dev libzip-dev git \
  && curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/local/bin --filename=composer

# MySql ext
RUN docker-php-ext-install pdo pdo_mysql

# GD ext
RUN docker-php-ext-install gd zip

# Redis ext
RUN pecl install redis-5.1.1 \
	&& docker-php-ext-enable redis

# Installk AWS SSM
RUN wget https://github.com/Droplr/aws-env/raw/v0.4/bin/aws-env-linux-amd64 -O /bin/aws-env && \
  chmod +x /bin/aws-env

# COPY PHP config
COPY ./config/php /usr/local/etc/
COPY ./config/php-fpm.conf /usr/local/etc/php-fpm.conf

# Create user and group
RUN groupadd -g 1000 www && useradd -u 1000 -g www www

RUN touch /www/docker-volume-not-mounted && chown www:www /www

CMD [ "php-fpm", "-c", "/usr/local/etc/php-fpm.conf" ]
