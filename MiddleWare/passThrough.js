var configDB = require('./config/database');
var http = require('http');
var formidable = require('formidable');
var util = require('util');
var request = require('request');
var querystring = require('querystring');

/* function: passData()
* makes an HTTP request. Takes in the Request/response
* vairables and options from calling function and after
* getting data from other api, passes data back
* to caller
*/
function passData(req, res, options){
  http.request(options, function(response){
      var str = '';

      response.on('data', function (chunk){
        str += chunk;
      });

      response.on('end', function(chunk){
        console.log(str);
        res.end(str);
      });
    }).end();
};

function parsePOST(req, res, options){
  var form = new formidable.IncomingForm();

    form.parse(req, function(err, fields, files) {

      var values = {};

      for(field in fields){
        values[field] = fields[field];
      }


      var qs = querystring.stringify(values);
      var qslength = qs.length;

      options.headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': qslength
      }
      console.log(options);

      var postReq = http.request(options, function(response){
        var str = '';

        response.on('data', function (chunk){
          str += chunk;
        });

        response.on('end', function(chunk){
          console.log(str);
          res.end(str);
        });
      });

      postReq.end(qs);
    });
}


module.exports = {

  /* function: passThroughUserID: 
 * this function passes through the user id and password
 * provided to the middleware in order to log into the database
 */
  passThroughUserID: function(req,res){
    console.log('POST /user/login');

    var options = {
      host: configDB.host,
      path: "/FlashApp/api/user/login",
      method: 'POST'
    };

    // passData(req, res, options);
    parsePOST(req, res, options);
    
  },

  /* function PassThroughUserTypes
   * a passthrough function for when 
   * user types is requested from the database
   */

  passThroughUserTypes: function (req, res) {
    console.log('GET  /user/usertype');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/user/usertypes',
      method: 'GET',
    };

    passData(req, res, options);

  },

  /* function passThroughUserRegister
   * passes through the user/register
   * api end point from the front end to
   * the backend
   */

  passThroughUserRegister: function (req, res){
    console.log('POST /user/register');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/user/register',
      method: 'POST'
    };

    parsePOST(req, res, options);
  },

  passThroughUserLogout: function(req, res){
    console.log('GET /user/logout');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/user/logout',
      method: 'GET'
    };

    passData(req, res, options);
  },

  passThroughUserAboutMePOST: function(req, res){
    console.log('POST /user/aboutme');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/user/aboutme',
      method: 'POST'
    };

    parsePOST(req, res, options);
  },

  passThroughUserAboutMeGET: function(req, res){
    console.log('GET /user/aboutme');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/user/aboutme',
      method: 'GET'
    };

    passData(req, res, options);
  },

  passThroughUserSetUserType: function(req,res){
    console.log('POST /user/setUserType');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/user/aboutme',
      method: 'POST'
    };

    parsePOST(req, res, options);
  },


  //address, latitude, longitude 
  passThroughAddLocation: function(req, res){
    console.log('POST /location/addLocation');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/location/addLocation',
      method: 'POST'
    };

    parsePOST(req, res, options);
  },

  passThroughGetLocation: function(req, res){
    console.log('GET /location/location/:id');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/location/location/' + req.params.id,
      method: 'GET'
    }

    passData(req, res, options);
  },

  passThroughAddJob: function(req, res){
    console.log('POST /jobs/addJob');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/jobs/addJob',
      method: 'POST'
    };

    parsePOST(req, res, options);
  },

  passThroughGetJobs: function(req, res){
    console.log('GET /jobs/getJobs');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/jobs/getJobs',
      method: 'GET'
    };

    passData(req, res, options);
  },

  passThroughAddUserKeyword: function(req, res){
    console.log('POST /keywords/addUserKeyword');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/keywords/addUserKeyword',
      method: 'POST'
    };    

    parsePOST(req, res, options);
  },

  passThroughAddJobKeyword: function(req, res){
    console.log('POST /keywords/addJobKeyword');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/keywords/addJobKeyword',
      method: 'POST'
    };    

    parsePOST(req, res, options);
  },

  passThroughGetUserKeywords: function(req, res){
    console.log('GET /keywords/user');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/keywords/user',
      method: 'GET'
    };    

    passData(req, res, options);
  },

  passThroughGetJobKeywords: function(req, res){
    console.log('GET /keywords/job/:jobid');

    var options = {
      host: configDB.host,
      path: configDB.basePath + '/keywords/job/' + req.params.jobid,
      method: 'GET'
    }

    passData(req, res, options);
  }
};