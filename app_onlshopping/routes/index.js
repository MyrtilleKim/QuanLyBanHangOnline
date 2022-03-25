var express = require('express');
var router = express.Router();
const sql = require('mssql');
const app = require('../app');

const array = [];
const array2 = [];

// var config = {  
//   server: '127.0.0.1',
//   port: 1433,  //update me
//   authentication: {
//       type: 'default',
//       options: {
//           userName: 'kubi', //update me
//           password: '28112001'  //update me
//       }
//   },
//   options: {
//       // If you are on Microsoft Azure, you need encryption:
//       encrypt: true,
//       database: 'qlbh_onl'  //update me
//   },
//   debug: {
//     packet: true,
//     data: true,
//     payload: true,
//     token: true
//   }
// };  

// var Connection = require('tedious').Connection;  
// var connection = new Connection(config);  
// connection.on("connect", err => {
//   if (err) {
//     console.error(err.message);
//     // console.log("hello");
//   } else {
//     console.log("hello");
//     getTenSP();
//     // getDonGia();
//   }
// });

// connection.connect();

// var Request = require('tedious').Request;  
// var TYPES = require('tedious').TYPES;  
// function getTenSP(){
//   request = new Request("SELECT * FROM SANPHAM;", function(err) {  
//       if (err) {console.log(err);}});  
  
//   var result = "";  
//   request.on('row', function(columns) {  
//       columns.forEach(function(column) {  
//         if (column.value === null) {  
//           console.log('NULL');  
//         } 
//         else {  
//           result+= column.value + " ";  
//         }  
//       });  
//       console.log(result);  
//       array.push(result);
//       result ="";  
//   });
//     request.on("requestCompleted", function (rowCount, more) {
//             connection.close();
//         });
//   connection.execSql(request); 
// }

// module.exports = function(req, res) {
//   req.locals.db.query('SELECT * FROM SANPHAM', function(err, recordset) {
//     if (err) {
//       console.error(err)
//       res.status(500).send('SERVER ERROR')
//       return
//     }
//     res.status(200).json({ message: 'success' })
//   })
// }
var config = {  
  server: '127.0.0.1',
  port: 1433,  //update me
  authentication: {
      type: 'default',
      options: {
          userName: 'kubi', //update me
          password: '28112001'  //update me
      }
  },
  options: {
      // If you are on Microsoft Azure, you need encryption:
      encrypt: true,
      database: 'qlbh_onl'  //update me
  },
  debug: {
    packet: true,
    data: true,
    payload: true,
    token: true
  }
};  
var Connection = require('tedious').Connection;  
var connection = new Connection(config);  
connection.on("connect", err => {
    if (err) {
      console.error(err.message);
      // console.log("hello");
    } else {
      console.log("hello");
      getTenSP();
      // getDonGia();
    }
  });  
  
connection.connect();

var Request = require('tedious').Request;  
var TYPES = require('tedious').TYPES;  

function getTenSP(){
  request = new Request("SELECT TenSP FROM SANPHAM;", function(err) {  
      if (err) {console.log(err);}});  
  
  var result = "";  
  request.on('row', function(columns) {  
      columns.forEach(function(column) {  
        if (column.value === null) {  
          console.log('NULL');  
        } 
        else {  
          result+= column.value + " ";  
        }  
      });  
      console.log(result);  
      array.push(result);
      result ="";  
  });
    request.on("requestCompleted", function (rowCount, more) {
            connection.close();
        });
  connection.execSql(request); 
}

function getDonGia(){
request = new Request("SELECT DonGia FROM SANPHAM;", function(err) {  
    if (err) {console.log(err);}});  

var result = "";  
request.on('row', function(columns) {  
    columns.forEach(function(column) {  
      if (column.value === null) {  
        console.log('NULL');  
      } 
      else {  
        result+= column.value + " ";  
      }  
    });  
    console.log(result);  
    array.push(result);
    result ="";  
});
request.on("requestCompleted", function (rowCount, more) {
        connection.close();
    });
connection.execSql(request); 
}
/* GET home page. */
router.get('/', function(req, res, next) {
  // let arr = ["gia", "minh"];
  // res.json(array);
  
  res.render('index', {result: array});
});

module.exports = router;
