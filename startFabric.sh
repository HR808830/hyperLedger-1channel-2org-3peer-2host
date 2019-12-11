#!/bin/bash

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Exit on first error, print all commands.
set -e

Usage() {
	echo ""
	echo "Usage: ./startFabric.sh [-d || --dev]"
	echo ""
	echo "Options:"
	echo -e "\t-d or --dev: (Optional) enable fabric development mode"
	echo ""
	echo "Example: ./startFabric.sh"
	echo ""
	exit 1
}

Parse_Arguments() {
	while [ $# -gt 0 ]; do
		case $1 in
			--help)
				HELPINFO=true
				;;
            --dev | -d)
				FABRIC_DEV_MODE=true
				;;
		esac
		shift
	done
}

Parse_Arguments $@

if [ "${HELPINFO}" == "true" ]; then
    Usage
fi

# Grab the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


DOCKER_FILE="${DIR}"/composer/docker-compose.yml


docker-compose -f "${DOCKER_FILE}" down
docker-compose -f "${DOCKER_FILE}" up -d

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=15

echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

# Create the channel
echo "channel1 with peer 0 -------------------"
docker exec peer0.org1.iotblockchain.com peer channel create -o orderer.iotblockchain.com:7050 -c channeliot1 -f /etc/hyperledger/configtx/channeliot1.tx

# Join peer0.org1.iotblockchain.com to the channel.
docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.iotblockchain.com/msp" peer0.org1.iotblockchain.com peer channel join -b channeliot1.block


# # Create the channel
echo "channel1 with peer 1 -------------------"

docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.iotblockchain.com/msp" peer1.org1.iotblockchain.com peer channel fetch config -o orderer.iotblockchain.com:7050 -c channeliot1
# docker exec peer1.org1.iotblockchain.com peer channel create -o orderer.iotblockchain.com:7050 -c channeliot1 -f /etc/hyperledger/configtx/channeliot1.tx

# # Join peer1.org1.iotblockchain.com to the channel.
docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.iotblockchain.com/msp" peer1.org1.iotblockchain.com peer channel join -b channeliot1_config.block

# # Create the channel
echo "channel1 with peer 2 -------------------"

docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.iotblockchain.com/msp" peer2.org1.iotblockchain.com peer channel fetch config -o orderer.iotblockchain.com:7050 -c channeliot1
# docker exec peer1.org1.iotblockchain.com peer channel create -o orderer.iotblockchain.com:7050 -c channeliot1 -f /etc/hyperledger/configtx/channeliot1.tx

# # Join peer1.org1.iotblockchain.com to the channel.
docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.iotblockchain.com/msp" peer2.org1.iotblockchain.com peer channel join -b channeliot1_config.block

