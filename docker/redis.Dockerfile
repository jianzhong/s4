FROM redis:alpine
MAINTAINER Jianzhong Yu <docker@jianzhong.co.uk>
RUN mkdir /usr/local/etc/redis -p
COPY ./files/redis/redis-server.conf /usr/local/etc/redis/redis.conf 
COPY ./files/redis/redis-sentinel.conf /usr/local/etc/redis/sentinel.conf 
COPY ./files/redis/entrypoint.sh /usr/local/bin/entrypoint.sh 
RUN chmod +x /usr/local/bin/entrypoint.sh 
RUN chown redis:redis /usr/local/etc/redis/* 
ENTRYPOINT ["sh","/usr/local/bin/entrypoint.sh"] 
CMD ["master"] 
