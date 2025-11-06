var path = require('path')
var express = require('express')
var exphbs = require('express-handlebars')
var fs = require('fs')

var app = express()
var PORT = process.env.PORT || 3000

app.engine('handlebars', exphbs.engine({
    defaultLayout: 'home'
}))

app.set('view engine', 'handlebars')
app.use(express.static('static'));

app.get('/', function(req, res) {
    res.render('home')
})


