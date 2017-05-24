FROM php:5-apache
MAINTAINER Kurniawan Yudha Putrama "kurniawan.yudha.p@gmail.com"

RUN apt-get update
RUN apt-get install -y unzip libaio-dev php5-dev
RUN apt-get clean -y

# Oracle instantclient
ADD instantclient-basic-linux.x64-12.1.0.2.0.zip /tmp/
ADD instantclient-sdk-linux.x64-12.1.0.2.0.zip /tmp/
ADD instantclient-sqlplus-linux.x64-12.1.0.2.0.zip /tmp/

RUN unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /usr/local/
RUN unzip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /usr/local/
RUN unzip /tmp/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip -d /usr/local/
RUN ln -s /usr/local/instantclient_12_1 /usr/local/instantclient
RUN ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so
RUN ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus

RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8-2.0.11
RUN echo "extension=oci8.so" > /usr/local/etc/php/conf.d/30-oci8.ini
RUN a2enmod rewrite
RUN echo "<?php echo phpinfo(); ?>" > /var/www/html/index.php
