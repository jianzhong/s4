redis_role=$1 
if [ $redis_role = "master" ] ; then 
    redis-server /usr/local/etc/redis/redis.conf 
elif [ $redis_role = "slave" ] ; then   
    sed -i "s/#slaveof/slaveof/g" /usr/local/etc/redis/redis.conf 
    redis-server /usr/local/etc/redis/redis.conf 
elif [ $redis_role = "sentinel" ] ; then 
    redis-sentinel /usr/local/etc/redis/sentinel.conf 
else 
    echo "invalid role $1" 
fi
