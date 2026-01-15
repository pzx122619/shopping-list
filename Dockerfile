FROM webdevops/php-nginx:8.4

ENV WEB_DOCUMENT_ROOT /app/public
ENV APP_ENV local
WORKDIR /app
COPY .. .

COPY .env.example .env
COPY docker/10-cors.conf /opt/docker/etc/nginx/vhost.common.d/10-cors.conf
COPY docker/crontab /etc/crontabs/root
COPY docker/php.ini /etc/php/8.4/cli/conf.d/99-sail.ini

RUN apt-get update --allow-unauthenticated --allow-insecure-repositories
RUN apt-get install -y sudo
RUN curl -s https://deb.nodesource.com/setup_22.x | sudo bash
RUN apt-get -y install nodejs

RUN crontab /etc/crontabs/root

RUN chown -R application:application .
