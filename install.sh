#!/usr/bin/env bash
# Install and configure mongoDB v4.2.6
# Add public key
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
# Associate PATH URL to download
echo "deb [ arch=amd64,arm64,s390x ] http://repo.mongodb.com/apt/ubuntu xenial/mongodb-enterprise/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-enterprise.list
sudo apt-get update
sudo apt-get install -y mongodb-enterprise
sudo apt-get install -y mongodb-enterprise=4.2.6 mongodb-enterprise-server=4.2.6 mongodb-enterprise-shell=4.2.6 mongodb-enterprise-mongos=4.2.6 mongodb-enterprise-tools=4.2.6
echo "mongodb-enterprise hold" | sudo dpkg --set-selections
echo "mongodb-enterprise-server hold" | sudo dpkg --set-selections
echo "mongodb-enterprise-shell hold" | sudo dpkg --set-selections
echo "mongodb-enterprise-mongos hold" | sudo dpkg --set-selections
echo "mongodb-enterprise-tools hold" | sudo dpkg --set-selections
# Optional Ensure the binaries are in a directory listed in your PATH env variable
sudo cp mongodb-install/bin/* /usr/local/bin/
# Configure
# Create a directory where the MongoDB instance stores its data
sudo mkdir -p /var/lib/mongo
# Create a directory for its log
sudo mkdir -p /var/log/mongodb
# Process must have read and write permission to these directories
sudo chown `whoami` /var/lib/mongo     # Or substitute another user
sudo chown `whoami` /var/log/mongodb   # Or substitute another user
# Run MongoDB
mongod --dbpath /var/lib/mongo --logpath /var/log/mongodb/mongod.log --fork
# Verify that mongoDB has started successfully
cat /var/log/mongodb/mongodb.log
# Begin using Mongo
mongo
