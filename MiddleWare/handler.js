var http = require('http');
var formidable = require('formidable');
var util = require('util');
var querystring = require('querystring');

var configTwilio = require('./config/twilio');
var configDB = require('./config/database');


// Twilio Credentials 
var accountSid = configTwilio.accountSid;
var authToken = configTwilio.authToken; 

var client = require('twilio')(accountSid, authToken); 


function filterMatches(req, res, data) {

  dataJSON = JSON.parse(data);  

  var response;
  if(dataJSON.success != true){
    response = {
      success: false,
      jobs:[]
    };
  } else {
     response = {
      success: true,
    };

    var jobs = dataJSON.jobs;
    var keywords = dataJSON.mykeywords;

    var jobsFinal = [];

    for(var i = 0; i < jobs.length; ++i){
      if(keywords.indexOf(jobs[i].keyword) > -1){
        jobsFinal.push(jobs[i]);
      } else {
        continue;
      }
    }

    response.jobs = jobsFinal;

  }
  

  res.end(JSON.stringify(response));
  




  client.messages.create({ 
    to: configTwilio.toPhone, 
    from: configTwilio.fromPhone, 
    body: "Hey Ian, you have a new match for your job posting - Programmer!",   
  }, function(err, message) { 
    console.log("Message SID: " + message.sid); 
  });

};




module.exports = {
  findMatches: function (req, res){

    console.log('GET /keywords/keywords/' + req.params.usertype);

    options = {
      host: configDB.host,
      path: configDB.basePath + '/keywords/keywords/' + req.params.usertype,
      method: 'GET'
    };

    http.request(options, function(response){
        var str = '';

        response.on('data', function (chunk){
          str += chunk;
        });

        response.on('end', function(chunk){

          filterMatches(req, res, str);
        });
      }).end();
  }
};