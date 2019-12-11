cd "$(dirname "$0")"

HOST1="172.31.12.236"
HOST2="172.31.15.201"
sed -i -e "s/{IP-HOST-1}/$HOST1/g" configtx.yaml
sed -i -e "s/{IP-HOST-1}/$HOST1/g" ../startFabric-Peer2.sh
sed -i -e "s/{IP-HOST-2}/$HOST2/g" ../createPeerAdminCard.sh

../bin/cryptogen generate --config=./crypto-config.yaml
export FABRIC_CFG_PATH=$PWD
../bin/configtxgen -profile ComposerOrdererGenesis -outputBlock ./composer-genesis.block
../bin/configtxgen -profile ChannelIOT1 -outputCreateChannelTx ./channeliot1.tx -channelID channeliot1

ORG1KEY="$(ls crypto-config/peerOrganizations/org1.iotblockchain.com/ca/ | grep 'sk$')"
ORG2KEY="$(ls crypto-config/peerOrganizations/org2.iotblockchain.com/ca/ | grep 'sk$')"

sed -i -e "s/{ORG1-CA-KEY}/$ORG1KEY/g" docker-compose.yml
sed -i -e "s/{ORG2-CA-KEY}/$ORG2KEY/g" docker-compose-peer2.yml

