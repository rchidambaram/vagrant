#!/usr/bin/env bash

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

#echo '[Auction]
#name=Auction
#enabled=1
#baseurl=http://satellite.prod.auction.local/repo
#gpgcheck=0' > /etc/yum.repos.d/auction.repo

yum install -y epel-release
yum install -y puppet

#echo 'relayhost = crn01lax01us.dev.prod.auction.local' >> /etc/postfix/main.cf 

#ln -s /vagrant/tunnel.sh /usr/bin/tunnel
