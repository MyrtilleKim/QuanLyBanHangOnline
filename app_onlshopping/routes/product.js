var express = require('express');
var router = express.Router();
var Connection = require('tedious').Connection;  
const array = [];

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

// var connection = new Connection(config);  
// connection.on("connect", err => {
//   if (err) {
//     console.error(err.message);
//     // console.log("hello");
//   } else {
//     // getTenSP();
//     getDonGia();
//     console.log("hello2");
//   }
// });

// function getDonGia(){
//   request = new Request("SELECT DonGia FROM SANPHAM;", function(err) {  
//       if (err) {  
//           console.log(err);}  
//       });  
//       var result = "";  
//       request.on('row', function(columns) {  
//           columns.forEach(function(column) {  
//             if (column.value === null) {  
//               console.log('NULL');  
//             } else {  
//               result+= column.value + " ";  
//             }  
//           });  
//           console.log(result);  
//           array.push(result);
//           result ="";  
//       });

//       request.on("requestCompleted", function (rowCount, more) {
//               connection.close();
//           });
//           connection.execSql(request); 
// }

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('product', {result: array});
});

module.exports = router;