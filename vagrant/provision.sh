#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

apt-get install -y -q git
apt-get install -y -q python-pip
pip install --upgrade ansible

# setting up local SSH keys.
if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
    wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant \
        -O /home/vagrant/.ssh/id_rsa
    wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub \
        -O /home/vagrant/.ssh/id_rsa.pub
fi

cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
ssh-keyscan -t rsa,dsa 127.0.0.1  2>&1 > /home/vagrant/.ssh/known_hosts
ssh-keyscan -t rsa,dsa spry.dev  2>&1 >> /home/vagrant/.ssh/known_hosts

chmod 0600 /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/id_rsa
chmod 0644 /home/vagrant/.ssh/id_rsa.pub
chmod 0644 /home/vagrant/.ssh/known_hosts

chown -R vagrant:vagrant /home/vagrant/.ssh

rm /etc/update-motd.d/*

cat << HERE > /etc/update-motd.d/10-sprydev
#!/bin/sh
echo
echo See /vagrant/README.md for help.
echo
HERE


chmod 755 /etc/update-motd.d/10-sprydev

sudo -i -u vagrant ansible-playbook -i /vagrant/ansible/inventory/vagrant/hosts.py /vagrant/ansible/configure-dev.yml
