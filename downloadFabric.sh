#!/bin/bash

# Exit on first error, print all commands.
set -ev

# Set ARCH
ARCH=`uname -m`

# Grab the current directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Pull and tag the latest Hyperledger Fabric base image.
docker pull hyperledger/fabric-peer:$ARCH-1.0.4
docker pull hyperledger/fabric-ca:$ARCH-1.0.4
docker pull hyperledger/fabric-ccenv:$ARCH-1.0.4
docker pull hyperledger/fabric-orderer:$ARCH-1.0.4
docker pull hyperledger/fabric-couchdb:$ARCH-1.0.4



# set -e

# # Grab the current directory.
# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# pullFabricImage() {
#     local imageName="$1"
#     local imageTag="$2"
#     docker pull hyperledger/fabric-${imageName}:${imageTag}
#     #docker tag hyperledger/fabric-${imageName}:${imageTag} hyperledger/fabric-${imageName}
# }

# # Pull Hyperledger Fabric base images.
# for imageName in peer orderer ccenv; do
#     pullFabricImage ${imageName} 1.2.1
# done

# # Pull Hyperledger Fabric CA images.
# pullFabricImage ca 1.2.1

# # Pull Hyperledger third-party images.
# pullFabricImage couchdb 0.4.10