const config = require('../config')
const BusinessNetworkConnection = require('composer-client').BusinessNetworkConnection;
const bnc = new BusinessNetworkConnection();
const emailService = require('./email.service');
const networkConnectionService = require('./networkConnection.service');
const assetType = 'IOTTransaction';
let channel, peer;

networkConnectionService.connect(bnc).then(async(connection) => {
  console.log(connection);
  const fc = bnc.getNativeAPI();
  channel = fc.getChannel('channeliot1');
  org=await channel.getOrganizations();
  peer = fc.getPeer('peer0.org1.iotblockchain.com');
 // console.log("PP",peer);
})

async function saveDataInBlockchain(data) {
  return new Promise(async(resolve, reject) => {
    try {
      let chaincode = {
       idSens: data.idSens.toString(),
        type: data.type,
       idEVent: data.idEVent.toString(),
       buffer: data.buffer,
       criticality: data.criticality,
       payload: data.payload,
      };

      let factory = bnc.getBusinessNetwork().getFactory();
      let newTrack = factory.newTransaction(config.ns, assetType);
      newTrack = Object.assign(newTrack, chaincode);
      let res = await bnc.submitTransaction(newTrack);
      let event_hub = channel.newChannelEventHub(peer);
      let newEventCount=0;
      event_hub.connect();
      event_hub.registerBlockEvent(async (block) => {
        var transactionId = block.filtered_transactions[0].txid;
        let TransactionRegistry = await bnc.getTransactionRegistry(config.ns + '.' + assetType);
        if (transactionId) {
          transactions = await TransactionRegistry.get(transactionId);
          if (transactions.criticality > 5 && newEventCount==0) {
          // if(transactions.type =="hemant1" && newEventCount==0){
            let params = {
              email: "",
              subject:"Crticality Alert Mail"
            }
            newEventCount ++ ;
            emailService.sendEmail(params);
          }
        }
        resolve({"code": 201,"sucess": true,"data":block,"message": 'Data saved in blockchain Successfully' })
      });
    } catch (err) {
      console.log("err.message-------------------", err.message);
      errMessage = typeof err == 'string' ? err : err.message;
      reject({"code": 404,sucess: false, message: errMessage })
    }
  });
}

async function getBlockByNumber(data) {
  return new Promise(async(resolve, reject) => {
    try {
      let blockNumber = parseInt(data.block);
      let response_payload = await channel.queryBlock(blockNumber, peer);
      let transactionId = response_payload.data.data[0].payload.header.channel_header.tx_id;
      let TransactionRegistry = await bnc.getTransactionRegistry(config.ns + '.' + assetType);
      if (transactionId) {
        transactions = await TransactionRegistry.get(transactionId);
        let blockData = {
          tx_id: transactionId,
          idSens: transactions.idSens,
          type: transactions.type,
          idEVent: transactions.idEVent,
          buffer: transactions.buffer,
          criticality: transactions.criticality,
          payload: transactions.payload,
          timestamp:transactions.timestamp
        };
        let response = {
          "block_data": blockData, 
          "previous_hash": response_payload.header.previous_hash, 
          "current_hash": response_payload.header.data_hash, 
          "blockNumber": response_payload.header.number, 
          "tx_id": transactionId
        }
        resolve({"code": 200,"sucess": true,"payload":response })
      }
    } catch (err) {
      console.log("err.message-------------------", err.message);
      errMessage = typeof err == 'string' ? err : err.message;
      reject({"code": 404,"sucess": false,"message": 'Data Not Found'})
    }
  });
}

async function getAllBlockData() {
  return new Promise(async(resolve, reject) => {
    try {
      let TransactionRegistry = await bnc.getTransactionRegistry(config.ns + '.' + assetType);
        transactionList = await TransactionRegistry.getAll();
      let cnt=0,blockList=[];
        if(transactionList.length == 0){
          resolve({"code": 200,"sucess": true,"payload":blockList })
        }
      let getList =  await transactionList.map(async function(tran){
        let transactionDetails = {};
        transactionDetails.block_data={
          "tx_id":tran.transactionId,
          "idSens": tran.idSens,
          "type": tran.type,
          "idEVent": tran.idEVent,
          "buffer": tran.buffer,
          "criticality": tran.criticality,
          "payload": tran.payload,
          "timestamp":tran.timestamp
        }
        let response_payload = await channel.queryBlockByTxID(tran.transactionId, peer);
        transactionDetails.previous_hash= response_payload.header.previous_hash;
        transactionDetails.current_hash= response_payload.header.data_hash;
        transactionDetails.blockNumber= response_payload.header.number;
        blockList.push(transactionDetails);

        cnt++;
        if(transactionList.length == cnt){
          resolve({"code": 200,"sucess": true,"payload":blockList })
        }
      }); 
    } catch (err) {
      errMessage = typeof err == 'string' ? err : err.message;
      reject({"code": 404,"sucess": false,"message":"errMessage"})
    }
  })
}

module.exports = {
  saveDataInBlockchain,
  getBlockByNumber,
  getAllBlockData
}