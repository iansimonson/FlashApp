var express = require('express');
var configDB = require('./config/database');
var http = require('http');

// var bodyParser = require('body-parser');
// var mysql = require('mysql');


var passThrough = require('./passThrough');


var app = express();





var port = 3000;

var router = express.Router();

// Twilio Credentials 
var accountSid = require('./config/twilio.js');
var authToken = '[AuthToken]'; 
 
//require the Twilio module and create a REST client 
var client = require('twilio')(accountSid, authToken); 


app.use('/FlashApp/api',router);

function findMatches(req, res){

	console.log('GET /keywords/' + req.params.usertype);

	options = {
		host: configDB.host,
		path: configDB.basePath + '/keywords/' + req.params.usertype,
		method: 'GET'
	};

	http.request(options, function(response){
      var str = '';

      response.on('data', function (chunk){
        str += chunk;
      });

      response.on('end', function(chunk){
        console.log(str);
        res.end(str);

        client.messages.create({ 
					to: "3013182863", 
					from: "+14108340219", 
					body: "Hey Ian, you have a new match for your job posting!",   
				}, function(err, message) { 
					console.log(message.sid); 
				});
      });
    }).end();
};



router.post('/user/login', passThrough.passThroughUserID);
router.get('/user/usertypes', passThrough.passThroughUserTypes);
router.post('/user/register', passThrough.passThroughUserRegister);
router.get('/user/logout', passThrough.passThroughUserLogout);
router.post('/user/aboutMe', passThrough.passThroughUserAboutMePOST);
router.get('/user/aboutMe', passThrough.passThroughUserAboutMeGET);
router.post('/user/setUserType', passThrough.passThroughUserSetUserType);

router.post('/location/addLocation', passThrough.passThroughAddLocation);
router.get('/location/location/:id', passThrough.passThroughGetLocation);

router.post('/jobs/addJob', passThrough.passThroughAddJob);
router.get('/jobs/getJobs', passThrough.passThroughGetJobs);

router.post('/keywords/addUserKeyword', passThrough.passThroughAddUserKeyword);
router.post('/keywords/addJobKeyword', passThrough.passThroughAddJobKeyword);
router.get('/keywords/user', passThrough.passThroughGetUserKeywords);
router.get('/keywords/job/:jobid',passThrough.passThroughGetJobKeywords);

router.get('/keywords/:usertype', findMatches);

app.listen(port)
