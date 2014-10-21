#!/usr/bin/env bash

sed -i 's!Listen 443!#Listen 443!' /etc/httpd/conf.d/ssl.conf

iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -p tcp --dport 3306 -j ACCEPT
service iptables save

service iptables restart
service httpd restart