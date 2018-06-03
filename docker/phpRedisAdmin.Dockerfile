FROM my_php:latest
MAINTAINER Jianzhong Yu <docker@jianzhong.co.uk>
RUN composer create-project --no-plugins --no-scripts -s dev erik-dubbelboer/php-redis-admin /var/www/s4/redis_admin
RUN chown www-data.www-data /var/www/s4/redis_admin
USER root
WORKDIR /var/www/s4/redis_admin
ENTRYPOINT ["php", "-S", "0.0.0.0:80"] 
