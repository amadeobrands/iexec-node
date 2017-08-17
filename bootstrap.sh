#!/usr/bin/env bash

set vx
apt-get install -y software-properties-common
add-apt-repository -y ppa:ethereum/ethereum
add-apt-repository -y ppa:ethereum/ethereum-dev
add-apt-repository -y ppa:ethereum/ethereum-qt
# for apt-get install icedtea-8-plugin
add-apt-repository ppa:maarten-fonville/ppa
add-apt-repository -y ppa:openjdk-r/ppa
# for docker
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# for docker compose
curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
export DEBIAN_FRONTEND="noninteractive"


apt-get update
# apt-get upgrade -y





#install for root user node v6.11.2 (npm v3.10.10) and set it as default
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
nvm install v6.11.2

#install for vagrant user node v6.11.2 (npm v3.10.10) and set it as default
su - vagrant -c "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash"
su - vagrant -c "touch ~/.bash_profile"
su - vagrant -c "echo 'export NVM_DIR=~/.nvm' >> .bash_profile"
su - vagrant -c "echo 'source ~/.nvm/nvm.sh' >> .bash_profile"
su - vagrant -c "nvm install v6.11.2"


#java
apt-get install -y icedtea-8-plugin
apt-get install -y openjdk-8-jre
apt-get install -y openjdk-8-jdk

# config vagarnt .bash_profile"
su - vagrant -c "echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> .bash_profile"
su - vagrant -c "echo 'export XTREMWEB_VERSION=\$(ls ~/iexecdev/xtremweb-hep/build/dist/)' >> .bash_profile"

# utils
apt-get install -y coreutils
apt-get install -y git
apt-get install -y build-essential
apt-get install -y ant
apt-get install -y zip
apt-get install -y uuid-runtime
apt-get install -y python
apt-get install -y python-pip
apt-get install -y python-dev
apt-get install -y libssl-dev
apt-get install -y php5-cli

apt-get install -y dstat
apt-get install -y ntp
service ntp reload


#docker
apt-get install -y linux-image-extra-$(uname -r)
apt-get install -y linux-image-extra-virtual
apt-get -y install docker-ce
# add vagrant to docker group
usermod -aG docker vagrant


# mysql client
apt-get install -y mysql-client

# mysql server

debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
apt-get install -y mysql-server

# ethereum solidity
apt-get install -y solc
apt-get install -y ethereum

# truffle, testrpc pm2
su - vagrant -c "npm install -g truffle@3.4.7"
su - vagrant -c "npm install -g ethereumjs-testrpc@4.0.1"
su - vagrant -c "npm install pm2 -g"

# robotframework lib
pip install robotframework
pip install robotframework-selenium2library
pip install robotframework-databaselibrary
pip install pymysql

# xtremweb dir needed
mkdir /var/xwhep
chmod 777 /var/xwhep
mkdir /home/vagrant/castore
chmod 777 /home/vagrant/castore
chmod 777 /var/log

# ethereum dir needed
mkdir -p /home/vagrant/iexecdev/.ethash
chmod 777 /home/vagrant/iexecdev/.ethash
ln -s /home/vagrant/iexecdev/.ethash /home/vagrant/.ethash
