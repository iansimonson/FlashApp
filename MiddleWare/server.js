var express = require('express');
// var bodyParser = require('body-parser');
var mysql = require('mysql');


var passThrough = require('./passThrough');


var app = express();





var port = 3000;

var router = express.Router();


app.use('/FlashApp/api',router);




router.post('/user/login', passThrough.passThroughUserID);
router.get('/user/usertypes', passThrough.passThroughUserTypes);
router.post('/user/register', passThrough.passThroughUserRegister);
router.get('/user/logout', passThrough.passThroughUserLogout);
router.post('/user/aboutme', passThrough.passThroughUserAboutMePOST);
router.get('/user/aboutme', passThrough.passThroughUserAboutMeGET);
router.post('/user/setUserType', passThrough.passThroughUserSetUserType);

router.post('/location/addLocation', passThrough.passThroughAddLocation);
router.get('/location/location/:id', passThrough.passThroughGetLocation);

router.post('/jobs/addJob', passThrough.passThroughAddJob);
router.get('/jobs/getJobs', passThrough.passThroughGetJobs);

router.post('/keywords/addUserKeyword', passThrough.passThroughAddUserKeyword);
router.post('/keywords/addJobKeyword', passThrough.passThroughAddJobKeyword);
router.get('/keywords/user', passThrough.passThroughGetUserKeywords);
router.get('/keywords/job/:jobid',passThrough.passThroughGetJobKeywords);

app.listen(port)
