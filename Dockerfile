FROM php:alpine
MAINTAINER "VAILLANT Jérémy" <vaillant.jeremy@dev-crea.com>

ENV PROJECT /var/www/html

# Prepare system
RUN apk update \
  && apk upgrade \
  && apk add --no-cache sqlite git openjdk8-jre apache2 openrc \
  && rm -rf /var/cache/apk/*

# Configure Apache
RUN rc-update add apache2
# RUN a2enmod rewrite
# RUN a2enmod expires
# RUN rc-service apache2 restart

# Download project
RUN git clone https://github.com/kiswa/TaskBoard $PROJECT

WORKDIR $PROJECT

# Build project
RUN ./build/composer.phar install
RUN ./build/build-all

# Configure project
RUN chmod -R +w $PROJECT/api/
RUN chown -R www-data:www-data $PROJECT/

# Cleanning system
RUN apk del git
