#! /bin/bash

set -x

status=`mysql -uroot -ppassword -hlocalhost -e "GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%' IDENTIFIED BY 'password'; FLUSH HOSTS; SHOW MASTER STATUS\G"`
echo "$status"

file=`echo "$status" | grep -Po "(?<=File:\ ).*"`
position=`echo "$status" | grep -Po "(?<=Position:\ ).*"`

echo "File is: $file"
echo "Position is: $position"

cat > /var/lib/mysql/bin/init_slave1.sh << EOF
#! /bin/bash
set -x
mysql -uroot -ppassword -hlocalhost -e "STOP SLAVE; CHANGE MASTER TO master_host='db1', master_port=3306, master_user='replication', master_password='password', master_log_file='$file', master_log_pos=$position; START SLAVE\G"
set +x
EOF

chmod +x /var/lib/mysql/bin/init_slave1.sh

until [ -f /var/lib/mysql/bin/init_slave2.sh ]
do
	sleep 0.1
done

( exec /var/lib/mysql/bin/init_slave2.sh )

set +x