require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser')

const port = process.env.PORT || 8082
const cors = require('cors')

var app = express();
    app.use(bodyParser.urlencoded({ extended: false }))
    app.use(bodyParser.json());
    const corsOptions = {
      origin: true,
      credentials: true,
      // origin: 'http://localhost:3000'
    }
    // app.use(cors(corsOptions));
    // app.options('*', cors(corsOptions));
    var enableCORS = function (req, res, next) {
        console.log("call methode----------------------");
        res.header('Access-Control-Allow-Origin', '*');
        res.header("Access-Control-Allow-Credentials", true);
        res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
        res.header('Access-Control-Allow-Headers', 'Origin, Accept,Content-Type, token,authorization, Content-Length, X-Requested-With, *');
        if ('OPTIONS' === req.method) {
            res.sendStatus(200);
        } else {
            next();
        }
    };
    
    app.all("/*", function (req, res, next) {
        res.header('Access-Control-Allow-Origin', '*');
        res.header("Access-Control-Allow-Credentials", true);
        res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
        res.header('Access-Control-Allow-Headers', 'Content-Type, token,authorization, Content-Length, X-Requested-With, *');
        next();
    });
    // app.use(enableCORS);  
    app.use('/rest', require('./routes/index'));

    app.listen(port, () => {
        console.log(`The IOT app is up on port ${port}`);
    })

