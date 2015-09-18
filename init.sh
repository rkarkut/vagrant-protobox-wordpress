#!/usr/bin/env bash

directory="wp-vagrant"

if [ -d "wp-vagrant" ]; then
    rm -rf "wp-vagrant"
fi
echo "==> Clone protobox..."
git clone git@github.com:protobox/protobox.git wp-vagrant
echo "==> Copy config file..."

git clone git@github.com:slummer87/vagrant-protobox-wordpress.git tmp_config

cp tmp_config/common.yml wp-vagrant/data/config

cd $directory

echo "==> Install box..."
vagrant protobox install 'http://getprotobox.com/share/8dx0'
echo "==> Run virtual machine..."
vagrant up

echo "==> Clone GetResponse plugin..."
git clone git@git.int.getresponse.com:integrations/wp-getresponse-integration.git web/wp-getresponse-integration

cp ../tmp_config/run.sh web
chmod 777 web/run.sh

vagrant ssh -- -t 'sh /vagrant/web/run.sh'

#echo "==> Add domain gr-wordpress.app to hosts"
#echo "192.168.5.99    gr-wordpress.app" >> /etc/hosts