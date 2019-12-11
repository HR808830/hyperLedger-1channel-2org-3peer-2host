const config = require('../config')
let connect = (bnc) => {
    return new Promise(async function (resolve, reject) {
        await bnc.connect(config.networkAdminCard);
        resolve("Network Connection Done")
    })
}


module.exports = {
    connect
}