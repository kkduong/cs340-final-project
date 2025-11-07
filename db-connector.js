let mysql = require('mysql2')

const pool = mysql.createPool({
    waitForConnections: true,
    connectionLimit   : 10,
    host              : 'classmysql.engr.oregonstate.edu',
    user              : 'cs340_duongkae',
    password          : '6989',
    database          : 'cs340_duongkae'
}).promise(); 

module.exports = pool;