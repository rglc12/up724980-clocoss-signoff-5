#install all required modules
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo apt-get install -y git

git clone https://github.com/portsoc/clocoss-master-worker.git

#curl Key and IP address for each Server
key=$(curl "metadata.google.internal/computeMetadata/v1/instance/attribute/key" -H "Metadata-flavor: Google")
ip=$(curl "metadata.google.internal/computeMetadata/v1/instance/attribute/ip" -H "Metadata-flavor: Google")

#Run Client
npm run client $key $ip:8080