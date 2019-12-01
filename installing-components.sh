#!/bin/bash
yum update -y
yum install httpd
yum install php php-mysql -y
yum install mysql-server -y
service httpd start
service mysqld start
mysqladmin -uroot create mydb
cd /var/www/html
wget  http://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress/ testwordpress
cd testwordpress
mv wp-config-sample.php wp-config.php
