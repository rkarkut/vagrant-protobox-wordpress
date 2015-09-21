#!/usr/bin/env bash

directory="project"

if [ -d $directory ]; then
    rm -rf $directory
fi
echo "==> Clone protobox..."
git clone git@github.com:protobox/protobox.git $directory
echo "==> Copy config file..."

cp common.yml $directory/data/config

cd $directory

echo "==> Install box..."
vagrant protobox install 'http://getprotobox.com/share/8dx0'
echo "==> Run virtual machine..."
vagrant up

echo "==> Clone GetResponse plugin..."
git clone git@git.int.getresponse.com:integrations/wp-getresponse-integration.git web/wp-getresponse-integration

cp ../vagrant.sh web
chmod 777 web/vagrant.sh

vagrant ssh -- -t 'sh /vagrant/web/vagrant.sh'

echo "==> Add domain gr-wordpress.app to hosts"
echo "192.168.5.99    gr-wordpress.app" >> /etc/hosts