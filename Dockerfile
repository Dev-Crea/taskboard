FROM php:5.5-apache
MAINTAINER "VAILLANT Jérémy" <vaillant.jeremy@dev-crea.com>

ENV PROJECT /var/www/html

RUN apt-get update && apt-get install -y sqlite php5-sqlite git openjdk-7-jre

RUN a2enmod rewrite
RUN a2enmod expires

RUN git clone https://github.com/kiswa/TaskBoard $PROJECT

WORKDIR $PROJECT

RUN ./build/composer.phar install
RUN ./build/build-all
