const express = require('express');
const router = express.Router();
const { blockChainService } = require('../blockchain');

// routes

router.post('/add', async (req, res, next) => {
  let add = await blockChainService.saveDataInBlockchain(req.body);
  add ? 
    res.json(add) :
    res.json({"code": 404,"message": 'Data Not saved'})
});

router.get('/getBlockData/:block', async (req, res, next) => {
  let blockData = await blockChainService.getBlockByNumber(req.params);
  blockData ? 
    res.json(blockData) :
    res.json({"code": 404,"message": 'Data Not Found'})
});

router.get('/getAllBlockData', async (req, res, next) => {
  let blockData = await blockChainService.getAllBlockData();
  blockData ? 
    res.json(blockData) :
    res.json({"code": 404,"message": 'Data Not Found'})
});


router.get('/getTest', async (req, res, next) => {
  res.json({"code": 200,"message": 'api call sucesss'})
});
module.exports = router;
