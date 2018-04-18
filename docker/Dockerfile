FROM php:5.6-apache

# Install git (for composer)
RUN apt-get update && apt-get install -y git

# Install MySQL client (for drush)
RUN apt-get update && apt-get install -y mysql-client

# Custom php ini settings
COPY php/php.ini /usr/local/etc/php/

RUN apt-get update && apt-get install -y libpng-dev

RUN apt-get update \
    &&  docker-php-ext-install pdo_mysql opcache zip gd

# Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer
ENV PATH /root/.composer/vendor/bin:$PATH

# Drush
RUN composer global require "drush/drush:8.*"

# Copy apache config file
COPY apache/proctorsdevtest.local.conf /etc/apache2/sites-available/

# Enable apache modules
RUN a2enmod rewrite

# Enable the site
RUN a2ensite proctorsdevtest.local

# Set the working directory
WORKDIR /var/www