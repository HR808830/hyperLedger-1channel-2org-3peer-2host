const nodemailer = require("nodemailer");
const config = require('../config')
var transporter = nodemailer.createTransport({
    host:config.mail.host,
    auth: {
      user: config.mail.user,
      pass: config.mail.password
    },
    port: 465, 
    secure: true
  });

async function sendEmail(params) {
  return new Promise((resolve, reject) => {
    transporter.sendMail({
      from: config.mail.user, // Email address on which request form gets submitted on
      to: params.email, // Email address from id 
      subject:params.subject,
      html: "Your Crticality is above 5"
    }).then((message) => {
      console.log('mail sent then return val..', message);
    })
      .catch((error) => {
        console.log('email send error.......', error);
      })
  })
}


module.exports = {
    sendEmail
}