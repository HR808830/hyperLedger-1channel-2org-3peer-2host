******************************  Author  *****************************

	Author 	: HEMANT PATEL
	EMAIL	:	PATELHR808830@GMAIL.COM

******************************  1channel-2org-3peer-2host  *****************************

step1. Login   1st machine with terminal 
	
	ubuntu@home:~$ ssh -i "ec2.pem" ubuntu@ec2_url

	after login sucessfully

	ubuntu@ip-<1st-machine-ip-address>:~$ 

	1. Execute the following commands to update the software on your system: 
	sudo apt-get update 

	2. Install curl and the golang software package: 
		sudo apt-get install curl 
		sudo apt-get install golang 
		export GOPATH=$HOME/go 
		export PATH=$PATH:$GOPATH/bin 

	3. Install Node.js, npm , and Python: 
		sudo apt install nodejs 
		sudo apt install npm 
		sudo apt-get install python 

	4. Install and upgrade docker and docker-compose : 
    • sudo apt-get install docker 

    • sudo apt install apt-transport-https ca-certificates curl software-properties-common 

    • curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 

 

    • sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" 

    • sudo apt update 
    • sudo apt-cache policy docker-ce 
    • sudo apt install docker-ce 
    • sudo apt-get install docker-compose 

	5. Let's customize and update Node.js and golang to the proper versions: 

    • wget https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz 
    • tar -xzvf go1.11.2.linux-amd64.tar.gz 
    • sudo mv go/ /usr/local 
    • export GOPATH=/usr/local/go 
    • export PATH=$PATH:$GOPATH/bin 
    • curl -sL https://deb.nodesource.com/setup_8.x | sudo bash - 
    • sudo apt-get install -y nodejs 

	6. Verify the installed software package versions: 

		curl --version 
		/usr/local/go/bin/go version 
		python -V 
		node -v 
		npm -version 
		docker --version 
		docker-compose --version 


	7. Install Hyperledger Fabric 
		sudo usermod -a -G docker ubuntu 
    		sudo chmod 666 /var/run/docker.sock 
		sudo curl -sSL http://bit.ly/2ysbOFE | bash -s 

	8. Install Hyperledger composer 
	 
    • curl -O https://hyperledger.github.io/composer/latest/prereqs-ubuntu.sh

    • chmod u+x prereqs-ubuntu.sh

    • ./prereqs-ubuntu.sh   
    • sudo npm install --unsafe-perm -g composer-cli
    • sudo npm install –unsafe-perm -g generator-hyperledger-composer 
    • sudo npm i –unsafe-perm -g composer-playground




step2. Login   2st machine with terminal 

	enter all command present in step 1


step3. Download code or clone repo for 1channel-2org-3peer-2host (1st Machine)

	ubuntu@ip-<1st-machine-ip-address>:~$ 
	
	### Download the repo for 1channel-2org-3peer-2host 
	``` 

	step3.1 goto folder 1channel-2org-3peer-2host (1st Machine)
	ubuntu@ip-<1st-machine-ip-address>:~$  cd ~
	
	ubuntu@ip-<1st-machine-ip-address>:~$ cd 1channel-2org-3peer-2host 

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$
	
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ ls

		bin                     endorsement-policy.json  stopFabric-Peer1.sh 
		bna                     iot-network@0.0.2.bna    stopFabric.sh 
		composer                README.md                teardownAllDocker.sh 
		createPeerAdminCard.sh  startFabric-Peer2.sh     teardownFabric.sh 
		downloadFabric.sh       startFabric.sh 


	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ cd composer

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/composer$

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/composer$ ls

		channeliot1.tx          crypto-config             docker-compose.yml 
		composer-genesis.block  crypto-config.yaml        howtobuild.sh 
		configtx.yaml           docker-compose-peer2.yml 

	
		=> previous certificate and channel related file and data

		ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer$ sudo rm -rf  channeliot1.tx    crypto-config   composer-		genesis.block

		ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer$ ls

		docker-compose.yml  crypto-config.yaml        howtobuild.sh 
		configtx.yaml           docker-compose-peer2.yml 

		ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer$ cd ..

	 
	
step4. Pull and tag the latest Hyperledger Fabric base image (1st Machine)

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host$ls

		bin                     endorsement-policy.json  stopFabric-Peer1.sh 
		bna                     iot-network@0.0.2.bna    stopFabric.sh 
		composer                README.md                teardownAllDocker.sh 
		createPeerAdminCard.sh  startFabric-Peer2.sh     teardownFabric.sh 
		downloadFabric.sh       startFabric.sh 


	=> run script for    downloadFabric.sh  (pull image fabric )
	
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host$ sudo ./ downloadFabric.sh
	
	=>after  download succefully fabric images







step5. Run script howtobuild.sh  (1st Machine)

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host$

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host$ cd  composer

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/composer$ ls
		docker-compose.yml  crypto-config.yaml        howtobuild.sh 
		configtx.yaml           docker-compose-peer2.yml 

	1)Replace the IP addresses in HOST1  with your own IPs or FQDNs ./configtx.sh  
		ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/composer$ 		sudo nano   configtx.yaml

		#   SECTION: Orderer
		line 83  Orderer: &OrdererDefaults
		line:89   Addresses:
				- <1st Machine-privateIp-address>:7050  //replace ip address

	2)Replace the IP addresses in HOST1 and HOST2 with your own IPs or 		FQDNs ./howtobuild.sh

		 
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer$ sudo nano howtobuild.sh 
			=> change two line ip address set 
			HOST1="<1st-machine-private-ip>" 
			HOST2="<2st-machine-private-ip>"

	=> after change ip then  close and save file 

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer$

	=>  run  script   howtobuild.sh 

		- Generate the Certificates for Organizations, Administrators and Users
		- We will first define some environment variables.
		- we generate the genesis block using profile OrdererGenesis
		- generating the Anchor Peer update file for each channel. In our d 			design, we will have all peers as anchor peers in each channel

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer$ sudo ./howtobuild.sh 
	
	=> after script run successfully 

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/composer$ls
	
		channeliot1.tx          crypto-config             docker-compose.yml 
		composer-genesis.block  crypto-config.yaml        howtobuild.sh 
		configtx.yaml           docker-compose-peer2.yml 

	
		
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/composer$cd ..

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host$
	



step5. services conatiner ca(ca.org1/2.iotblockchain.com)  change the  ca.keyfile  (1st Machine)

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host$
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host$ cd  composer


	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer$ls
	
		channeliot1.tx          crypto-config             docker-compose.yml 
		composer-genesis.block  crypto-config.yaml        howtobuild.sh 
		configtx.yaml           docker-compose-peer2.yml 







	1)Replace the org1 ca.keyfile  name  for docker-composer.yml(set path)
		
		ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer$ sudo nano ./docker-compose.yml 
		
		- services: 
  			ca.org1.iotblockchain.com:
		 	line:11	command:   _sk name replace
		- replace the ca.keyfile
		- get the file name location follow below command


		ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer/crypto-			config/peerOrganizations/org1.iotblockchain.com/ca$ ls 
		abc_sk 	ca.org1.iotblockchain.com-cert.pem 

	
	- copy the _sk file name and replace the docker-composer.yml for above 	location
			
        2)Replace the org2 ca.keyfile  name  for docker-composer-peer2.yml(set path)
		
		ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer$ sudo nano ./docker-compose-peer2.yml 

		- services: 
  			ca.org2.iotblockchain.com:
		 	line:11	command:   _sk name replace
		- replace the ca.keyfile
		- get the file name location follow below command


		ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host/composer/crypto-					config/peerOrganizations/org2.iotblockchain.com/ca$ ls 
			abc_sk 	ca.org2.iotblockchain.com-cert.pem 
		
		- copy the _sk file name and replace the docker-composer-peer2.yml for above 		location
			

step6. Replace HOST1 and 2 IP Address (1st Machine)
	
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/composer$ 

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ ls
	
		bin                     endorsement-policy.json  stopFabric-Peer1.sh 
		bna                     iot-network@0.0.2.bna    stopFabric.sh 
		composer                README.md                teardownAllDocker.sh 
		createPeerAdminCard.sh  startFabric-Peer2.sh     teardownFabric.sh 
		downloadFabric.sh       startFabric.sh 


	1)Replace the IP Host in startFabric-Peer2.sh  (ip-address-1st machine)
		ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host$ sudo nano  startFabric-Peer2.sh

		- replace the first machine ip address

		line:65,71,78 channel fetch config    <1st-machine-private-ip>:7050 
		total 3 line change ip 65,71,78     -c channeliot1

	2)Replace the IP Host in  createPeerAdminCard.sh


		ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-			2host$ sudo nano createPeerAdminCard.sh
		
		- replace the 2nd machine private ip address apply 
		- total 17 line change ip address (2nd machine private ip)





step7.  Copy the 1channel-2org-2peer-2host  folder 1st machine to 2nd machine 
	
	At this point, if you have done these instructions for one machine, either 	duplicate your VM at this time or prepare another environment with the same 	steps as described so far until you get to git cloning this repo. Instead of 	cloning the repo, scp -r the 1channel-2org-2peer-2host folder from the first 	machine to the second.


	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/composer$

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/composer$ cd ../..
	ubuntu@ip-<1st-ip-addresss>:~$ scp -i ec2.pem  1channel-2org-3peer-2host ubuntu@<2nd machine ec2 instace>:/




step8.  On the first machine run script  startFabric.sh
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host$
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ls
		bin                     endorsement-policy.json  stopFabric-Peer1.sh 
		bna                     iot-network@0.0.2.bna    stopFabric.sh 
		composer                README.md                teardownAllDocker.sh 
		createPeerAdminCard.sh  startFabric-Peer2.sh     teardownFabric.sh 
		downloadFabric.sh       startFabric.sh 
	
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ sudo ./ 	stopFabric.sh	
	 ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ sudo ./ 	teardownAllDocker.sh
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ sudo ./ 	startFabric.sh
	
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$sudo docker ps 
		- show the runing container


step9.  On the second machine run script  startFabric-Peer2.sh

	  -  please checkout the copy the first host machine folder 1channel-2org-3peer-		2host
	- after that following below command 
	ubuntu@ip-<2nd-ip-addresss>:
	ubuntu@ip-<2nd-ip-addresss>: cd  1channel-2org-3peer-2host
	ubuntu@ip-<2nd-ip-addresss>:~/1channel-2org-3peer-2host/$
	ubuntu@ip-<2nd-ip-addresss>:~/1channel-2org-3peer-2host/$ls
		bin                     endorsement-policy.json  stopFabric-Peer1.sh 
		bna                     iot-network@0.0.2.bna    stopFabric.sh 
		composer                README.md                teardownAllDocker.sh 
		createPeerAdminCard.sh  startFabric-Peer2.sh     teardownFabric.sh 
		downloadFabric.sh       startFabric.sh 

		=> run script for    downloadFabric.sh  (pull image fabric )
			notes: not every time run this scirpt (if not docker image not 				avaiable then run it sciprt)
	
			ubuntu@ip-<2nd-ip-addresss>:~/1channel-2org-3peer-					2host$ sudo ./ downloadFabric.sh
			
			=>after  download succefully fabric images
		=> run script for   startFabric-Peer2.sh (run docker  container )

			ubuntu@ip-<2nd-ip-addresss>:~/1channel-2org-3peer-2host/$ 				sudo ./ stopFabric-Peer1.sh
			
			ubuntu@ip-<2nd-ip-addresss>:~/1channel-2org-3peer-2host/$ 				sudo ./ teardownAllDocker.sh

			ubuntu@ip-<2nd-ip-addresss>:~/1channel-2org-3peer-2host/$ 				sudo ./ startFabric-Peer2.sh

			ubuntu@ip-<2nd-ip-addresss>:~/1channel-2org-3peer-2host/$sudo 			docker ps 
			- show the runing container

step10.  On the first machine run script  createPeerAdminCard.sh  (1st machine)

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ls
		bin                     endorsement-policy.json  stopFabric-Peer1.sh 
		bna                     iot-network@0.0.2.bna    stopFabric.sh 
		composer                README.md                teardownAllDocker.sh 
		createPeerAdminCard.sh  startFabric-Peer2.sh     teardownFabric.sh 
		downloadFabric.sh       startFabric.sh 

ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ sudo rm -fr ~/.composer
ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ sudo ./createPeerAdminCard.sh

	- show the composer create card successfully 


step11. Create the Composer profile on the First Machine and start Composer Playground and Blockchain Explorer

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ sudo chmod 755 	-R ~/.composer
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ cd ~
	ubuntu@ip-<1st-ip-addresss>:~/$ composer-playground


show the buness
<1st-ip-addresss>:8080

*************************************************

step12. Start nodejs Project (backend)  First Machine

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ 
		bin                     endorsement-policy.json  stopFabric-Peer1.sh 
		bna                     iot-network@0.0.2.bna    stopFabric.sh 
		composer                README.md                teardownAllDocker.sh 
		createPeerAdminCard.sh  startFabric-Peer2.sh     teardownFabric.sh 
		downloadFabric.sh       startFabric.sh  NodeJs 

	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/$ cd NodeJs
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/NodeJs/$ ls 
		app.js  blockchain  config.js  node_modules  
		package-lock.json  package.json  routes
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/NodeJs/$ npm i
	ubuntu@ip-<1st-ip-addresss>:~/1channel-2org-3peer-2host/NodeJs/$ nodemon or node app.js

