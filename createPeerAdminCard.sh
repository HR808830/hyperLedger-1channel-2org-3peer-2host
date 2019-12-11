#!/bin/bash

# Exit on first error
set -e
# Grab the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Grab the file names of the keystore keys
ORG1KEY="$(ls composer/crypto-config/peerOrganizations/org1.iotblockchain.com/users/Admin@org1.iotblockchain.com/msp/keystore/)"
ORG2KEY="$(ls composer/crypto-config/peerOrganizations/org2.iotblockchain.com/users/Admin@org2.iotblockchain.com/msp/keystore/)"

echo
# check that the composer command exists at a version >v0.14
if hash composer 2>/dev/null; then
    composer --version | awk -F. '{if ($2<15) exit 1}'
    if [ $? -eq 1 ]; then
        echo 'Sorry, Use createConnectionProfile for versions before v0.15.0' 
        exit 1
    else
        echo Using composer-cli at $(composer --version)
    fi
else
    echo 'Need to have composer-cli installed at v0.15 or greater'
    exit 1
fi
# need to get the certificate

cat << EOF > org1onlyconnection.json
{
   "name": "iot-network-org1-only",
    "x-type": "hlfv1",
    "x-commitTimeout": 300,
    "version": "1.0.0",
    "client": {
        "organization": "Org1",
        "connection": {
            "timeout": {
                "peer": {
                    "endorser": "300",
                    "eventHub": "300",
                    "eventReg": "300"
                },
                "orderer": "300"
            }
        }
    },
    "channels": {
        "channeliot1": {
            "orderers": [
                "orderer.iotblockchain.com"
            ],
            "peers": {
                "peer0.org1.iotblockchain.com": {},
                "peer1.org1.iotblockchain.com": {},
                "peer2.org1.iotblockchain.com": {}
            }
        }
    },
    "organizations": {
        "Org1": {
            "mspid": "Org1MSP",
            "peers": [
                "peer0.org1.iotblockchain.com",
                "peer1.org1.iotblockchain.com",
                "peer2.org1.iotblockchain.com"
            ],
            "certificateAuthorities": [
                "ca.org1.iotblockchain.com"
            ]
        }
    },
    "orderers": {
        "orderer.iotblockchain.com": {
            "url": "grpc://localhost:7050",
            "hostnameOverride" : "orderer.iotblockchain.com"
        }
    },
    "certificateAuthorities": {
        "ca.org1.iotblockchain.com": {
            "url": "http://localhost:7054",
            "name": "ca.org1.iotblockchain.com",
            "hostnameOverride": "ca.org1.iotblockchain.com"
        }
    },
    "peers": {
        "peer0.org1.iotblockchain.com": {
            "url": "grpc://localhost:7051",
            "eventUrl": "grpc://localhost:7053",
            "hostnameOverride": "peer0.org1.iotblockchain.com"
        },
        "peer1.org1.iotblockchain.com": {
            "url": "grpc://localhost:8051",
            "eventUrl": "grpc://localhost:8053",
            "hostnameOverride": "peer1.org1.iotblockchain.com"
        },
        "peer2.org1.iotblockchain.com": {
            "url": "grpc://localhost:9051",
            "eventUrl": "grpc://localhost:9053",
            "hostnameOverride": "peer2.org1.iotblockchain.com"
        }
    }
}
EOF

cat << EOF > org1connection.json
{
    "name": "iot-network-org1",
    "x-type": "hlfv1",
    "x-commitTimeout": 300,
    "version": "1.0.0",
    "client": {
        "organization": "Org1",
        "connection": {
            "timeout": {
                "peer": {
                    "endorser": "300",
                    "eventHub": "300",
                    "eventReg": "300"
                },
                "orderer": "300"
            }
        }
    },
    "channels": {
        "channeliot1": {
            "orderers": [
                "orderer.iotblockchain.com"
            ],
            "peers": {
                "peer0.org1.iotblockchain.com": {},
                "peer1.org1.iotblockchain.com": {},
                "peer2.org1.iotblockchain.com": {},
                "peer0.org2.iotblockchain.com": {},
                "peer1.org2.iotblockchain.com": {},
                "peer2.org2.iotblockchain.com": {}
            }
        }
    },
    "organizations": {
        "Org1": {
            "mspid": "Org1MSP",
            "peers": [
                "peer0.org1.iotblockchain.com",
                "peer1.org1.iotblockchain.com",
                "peer2.org1.iotblockchain.com",
                "peer0.org2.iotblockchain.com",
                "peer1.org2.iotblockchain.com",
                "peer2.org2.iotblockchain.com"
            ],
            "certificateAuthorities": [
                "ca.org1.iotblockchain.com"
            ]
        }
    },
    "orderers": {
        "orderer.iotblockchain.com": {
            "url": "grpc://localhost:7050",
            "hostnameOverride" : "orderer.iotblockchain.com"
        }
    },
    "certificateAuthorities": {
        "ca.org1.iotblockchain.com": {
            "url": "http://localhost:7054",
            "caName": "ca.org1.iotblockchain.com",
            "hostnameOverride": "ca.org1.iotblockchain.com"
        }
    },
    "peers": {
        "peer0.org1.iotblockchain.com": {
            "url": "grpc://localhost:7051",
            "eventUrl": "grpc://localhost:7053",
            "hostnameOverride": "peer0.org1.iotblockchain.com"
        },
        "peer1.org1.iotblockchain.com": {
            "url": "grpc://localhost:8051",
            "eventUrl": "grpc://localhost:8053",
            "hostnameOverride": "peer1.org1.iotblockchain.com"
        },
        "peer2.org1.iotblockchain.com": {
            "url": "grpc://localhost:9051",
            "eventUrl": "grpc://localhost:9053",
            "hostnameOverride": "peer2.org1.iotblockchain.com"
        },
        "peer0.org2.iotblockchain.com": {
            "url": "grpc://{IP-HOST-2}:10051",
            "hostnameOverride": "peer0.org2.iotblockchain.com"
        },
        "peer1.org2.iotblockchain.com": {
            "url": "grpc://{IP-HOST-2}:11051",
            "hostnameOverride": "peer1.org2.iotblockchain.com"
        },
        "peer2.org2.iotblockchain.com": {
            "url": "grpc://{IP-HOST-2}:12051",
            "hostnameOverride": "peer2.org2.iotblockchain.com"
        }
    }
}
EOF

PRIVATE_KEY="${DIR}"/composer/crypto-config/peerOrganizations/org1.iotblockchain.com/users/Admin@org1.iotblockchain.com/msp/keystore/"${ORG1KEY}"
CERT="${DIR}"/composer/crypto-config/peerOrganizations/org1.iotblockchain.com/users/Admin@org1.iotblockchain.com/msp/signcerts/Admin@org1.iotblockchain.com-cert.pem

if composer card list -n @iot-network-org1-only > /dev/null; then
    composer card delete -n @iot-network-org1-only
fi

if composer card list -n @iot-network-org1 > /dev/null; then
    composer card delete -n @iot-network-org1
fi

composer card create -p org1onlyconnection.json -u PeerAdmin -c "${CERT}" -k "${PRIVATE_KEY}" -r PeerAdmin -r ChannelAdmin --file /tmp/PeerAdmin@iot-network-org1-only.card
composer card import --file /tmp/PeerAdmin@iot-network-org1-only.card

composer card create -p org1connection.json -u PeerAdmin -c "${CERT}" -k "${PRIVATE_KEY}" -r PeerAdmin -r ChannelAdmin --file /tmp/PeerAdmin@iot-network-org1.card
composer card import --file /tmp/PeerAdmin@iot-network-org1.card

rm -rf org1onlyconnection.json

cat << EOF > org2onlyconnection.json
{
    "name": "iot-network-org2-only",
    "x-type": "hlfv1",
    "x-commitTimeout": 300,
    "version": "1.0.0",
    "client": {
        "organization": "Org2",
        "connection": {
            "timeout": {
                "peer": {
                    "endorser": "300",
                    "eventHub": "300",
                    "eventReg": "300"
                },
                "orderer": "300"
            }
        }
    },
    "channels": {
        "channeliot1": {
            "orderers": [
                "orderer.iotblockchain.com"
            ],
            "peers": {
                "peer0.org2.iotblockchain.com": {},
                "peer1.org2.iotblockchain.com": {},
                "peer2.org2.iotblockchain.com": {}
            }
        }
    },
    "organizations": {
        "Org2": {
            "mspid": "Org2MSP",
            "peers": [
                "peer0.org2.iotblockchain.com",
                "peer1.org2.iotblockchain.com",
                "peer2.org2.iotblockchain.com"
            ],
            "certificateAuthorities": [
                "ca.org2.iotblockchain.com"
            ]
        }
    },
    "orderers": {
        "orderer.iotblockchain.com": {
            "url": "grpc://localhost:7050",
            "hostnameOverride" : "orderer.iotblockchain.com"
        }
    },
    "certificateAuthorities": {
        "ca.org2.iotblockchain.com": {
            "url": "http://{IP-HOST-2}:7054",
            "name": "ca.org2.iotblockchain.com",
            "hostnameOverride": "ca.org2.iotblockchain.com"
        }
    },
    "peers": {
        "peer0.org2.iotblockchain.com": {
            "url": "grpc://{IP-HOST-2}:10051",
            "eventUrl": "grpc://{IP-HOST-2}:10053",
            "hostnameOverride": "peer0.org2.iotblockchain.com"
        },
        "peer1.org2.iotblockchain.com": {
            "url": "grpc://{IP-HOST-2}:11051",
            "eventUrl": "grpc://{IP-HOST-2}:11053",
            "hostnameOverride": "peer1.org2.iotblockchain.com"
        },
        "peer2.org2.iotblockchain.com": {
            "url": "grpc://{IP-HOST-2}:12051",
            "eventUrl": "grpc://{IP-HOST-2}:12053",
            "hostnameOverride": "peer2.org2.iotblockchain.com"
        }
    }
}
EOF

cat << EOF > org2connection.json
{
    "name": "iot-network-org2",
    "x-type": "hlfv1",
    "x-commitTimeout": 300,
    "version": "1.0.0",
    "client": {
        "organization": "Org2",
        "connection": {
            "timeout": {
                "peer": {
                    "endorser": "300",
                    "eventHub": "300",
                    "eventReg": "300"
                },
                "orderer": "300"
            }
        }
    },
    "channels": {
        "channeliot1": {
            "orderers": [
                "orderer.iotblockchain.com"
            ],
            "peers": {
                "peer0.org1.iotblockchain.com": {},
                "peer1.org1.iotblockchain.com": {},
                "peer2.org1.iotblockchain.com": {},
                "peer0.org2.iotblockchain.com": {},
                "peer1.org2.iotblockchain.com": {},
                "peer2.org2.iotblockchain.com": {}
            }
        }
    },
    "organizations": {
        "Org2": {
            "mspid": "Org2MSP",
            "peers": [
                "peer0.org1.iotblockchain.com",
                "peer1.org1.iotblockchain.com",
                "peer2.org1.iotblockchain.com",
                "peer0.org2.iotblockchain.com",
                "peer1.org2.iotblockchain.com",
                "peer2.org2.iotblockchain.com"
            ],
            "certificateAuthorities": [
                "ca.org2.iotblockchain.com"
            ]
        }
    },
    "orderers": {
        "orderer.iotblockchain.com": {
            "url": "grpc://localhost:7050",
            "hostnameOverride" : "orderer.iotblockchain.com"
        }
    },
    "certificateAuthorities": {
        "ca.org2.iotblockchain.com": {
            "url": "http://{IP-HOST-2}:7054",
            "name": "ca.org2.iotblockchain.com",
            "hostnameOverride": "ca.org2.iotblockchain.com"
        }
    },
    "peers": {
        "peer0.org1.iotblockchain.com": {
            "url": "grpc://localhost:7051",
            "hostnameOverride": "peer0.org1.iotblockchain.com"
        },
        "peer1.org1.iotblockchain.com": {
            "url": "grpc://localhost:8051",
            "hostnameOverride": "peer1.org1.iotblockchain.com"
        },
        "peer2.org1.iotblockchain.com": {
            "url": "grpc://localhost:9051",
            "hostnameOverride": "peer2.org1.iotblockchain.com"
        },
        "peer0.org2.iotblockchain.com": {
            "url": "grpc://{IP-HOST-2}:10051",
            "eventURL": "grpc://{IP-HOST-2}:10053",
            "hostnameOverride": "peer0.org2.iotblockchain.com"
        },
        "peer1.org2.iotblockchain.com": {
            "url": "grpc://{IP-HOST-2}:11051",
            "eventURL": "grpc://{IP-HOST-2}:11053",
            "hostnameOverride": "peer1.org2.iotblockchain.com"
        },
        "peer2.org2.iotblockchain.com": {
            "url": "grpc://{IP-HOST-2}:12051",
            "eventURL": "grpc://{IP-HOST-2}:12053",
            "hostnameOverride": "peer2.org2.iotblockchain.com"
        }
    }
}
EOF

PRIVATE_KEY="${DIR}"/composer/crypto-config/peerOrganizations/org2.iotblockchain.com/users/Admin@org2.iotblockchain.com/msp/keystore/"${ORG2KEY}"
CERT="${DIR}"/composer/crypto-config/peerOrganizations/org2.iotblockchain.com/users/Admin@org2.iotblockchain.com/msp/signcerts/Admin@org2.iotblockchain.com-cert.pem


if composer card list -n @iot-network-org2-only > /dev/null; then
    composer card delete -n @iot-network-org2-only
fi

if composer card list -n @iot-network-org2 > /dev/null; then
    composer card delete -n @iot-network-org2
fi

composer card create -p org2onlyconnection.json -u PeerAdmin -c "${CERT}" -k "${PRIVATE_KEY}" -r PeerAdmin -r ChannelAdmin --file /tmp/PeerAdmin@iot-network-org2-only.card
composer card import --file /tmp/PeerAdmin@iot-network-org2-only.card

composer card create -p org2connection.json -u PeerAdmin -c "${CERT}" -k "${PRIVATE_KEY}" -r PeerAdmin -r ChannelAdmin --file /tmp/PeerAdmin@iot-network-org2.card
composer card import --file /tmp/PeerAdmin@iot-network-org2.card

rm -rf org2onlyconnection.json

echo "Hyperledger Composer PeerAdmin card has been imported"
composer card list


echo "Hyperledger Composer PeerAdmin card Install"

composer network install --card PeerAdmin@iot-network-org1-only --archiveFile iot-network@0.0.3.bna
composer network install --card PeerAdmin@iot-network-org2-only --archiveFile iot-network@0.0.3.bna


# composer runtime install -c PeerAdmin@iot-network-org1-only -n iot-network
# composer runtime install -c PeerAdmin@iot-network-org2-only -n iot-network
composer identity request -c PeerAdmin@iot-network-org1-only -u admin -s adminpw -d iotnode1
composer identity request -c PeerAdmin@iot-network-org2-only -u admin -s adminpw -d iotnode2
composer network start --networkName iot-network --networkVersion 0.0.3 -c PeerAdmin@iot-network-org1 -A iotnode1 -C iotnode1/admin-pub.pem -A iotnode2 -C iotnode2/admin-pub.pem


composer card create -p org1connection.json -u iotnode1 -n iot-network -c iotnode1/admin-pub.pem -k iotnode1/admin-priv.pem
composer card import -f iotnode1@iot-network.card
composer card create -p org2connection.json -u iotnode2 -n iot-network -c iotnode2/admin-pub.pem -k iotnode2/admin-priv.pem
composer card import -f iotnode2@iot-network.card
