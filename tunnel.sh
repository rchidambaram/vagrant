#!/usr/bin/env bash


tunnel () {
	echo "tunnel called"
	ssh -fNg -L 33306:10.1.190.199:3306 $1@128.177.69.248
	ssh -fNg -L 33307:10.1.190.199:3307 $1@128.177.69.248
	ssh -fNg -L 33308:10.1.190.199:3308 $1@128.177.69.248
}

common () {

    files=(
	    includes/db.inc.php
		application/configs/db.ini
	)

    for i in "${files[@]}"
    do
		echo "replacing file with /tmp/wfh/"$1"/"$i
        test -f /tmp/wfh/$1/$i && cp /tmp/wfh/$1/$i /var/www/html/public_html/$i
    done
}

workFromHome () {
	if [ ! $2 ]; then
		echo "Error missing argument username for ssh: tunnel workFromHome **username**"
		kill -INT $$
	fi
	
	if [ ! -f /tmp/wfh/fromhome/includes/db.inc.php ]; then
		mkdir -p /tmp/wfh/fromhome/includes/
		cp /vagrant/includes/db.inc.php /tmp/wfh/fromhome/includes/db.inc.php
		mkdir -p /tmp/wfh/fromhome/application/configs/
		cp /vagrant/application/configs/db.ini /tmp/wfh/fromhome/application/configs/db.ini
	fi
	common $1
	tunnel $2
}

NDC_MERGE () {
	common 'branches/'$1
}

if [ ! -d "/tmp/wfh" ]; then
        svn checkout --depth immediates https://auctioncom.svn.beanstalkapp.com/source_mlh /tmp/wfh
		svn up --set-depth files /tmp/wfh/branches/NDC_MERGE
		svn up --set-depth files /tmp/wfh/branches/NDC_MERGE/includes
		svn up --set-depth files /tmp/wfh/branches/NDC_MERGE/application/configs
fi

svn up /tmp/wfh

case $1 in
	"NDC_MERGE")
		NDC_MERGE NDC_MERGE
		;;
	"workFromHome")
		#$2 is username
		workFromHome fromhome $2
		;;
	*)
		echo "Invalid Request: here are the available functions NDC_MERGE | workFromHome"
		exit;
		;;
esac