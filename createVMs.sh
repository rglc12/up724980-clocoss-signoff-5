#!/bin/bash

#Create key
key=`openssl rand -base64 32`

#Get Server IP Address
servIP=$(curl "http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip" -H "Metadata-Flavor:Google")

git clone https://github.com/portsoc/clocoss-master-worker
cd clocoss-master-worker
sudo npm install

#Run Server with the Key Parameter
npm run server $key &

gcloud config set compute/zone europe-west1-c

#Create any number of VMs 
for i in `seq 1 $1`
do

gcloud compute instances create --machine-type n1-standard-1 --metadata number=$i,key=$key,ip=$servIP --metadata-from-file startup-script="worker.sh" ryan-worker$i --preemptible

done

#Wait until all processes are complete
wait "$!"

#Delete all VMs once process has been completed
for i in `seq 1 $1`

do

gcloud compute instances delete ryan-worker$i --quiet

done
