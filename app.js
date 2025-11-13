var path = require('path')
var express = require('express')
var exphbs = require('express-handlebars')
var fs = require('fs')

const app = express();
const PORT = 9779; 

// database
const db = require('./db-connector');

// set up middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

// set up handlebars
app.engine('hbs', exphbs.engine({ extname: '.hbs' }));
app.set('view engine', 'hbs');


// routes

// ===== home =====
app.get('/', async (req, res) => {
  res.render('home', { title: 'ECLIPSE Crew Management System' });
});

// ===== dancers =====
app.get('/dancers', async (req, res) => {
  try {
    const [results] = await db.query("SELECT * FROM Dancers;");
    res.render('dancers', { title: 'Dancers', dancers: results });
  } catch (err) {
    console.error(err);
    res.status(500).send("Database query error");
  }
});

// ===== performances =====
app.get('/performances', async (req, res) => {
  try {
    const [performances] = await db.query("SELECT Performances.performanceID, Performances.name, Performances.date, Locations.name AS locationName FROM Performances JOIN Locations ON Performances.locationID = Locations.locationID;");

    const [locations] = await db.query("SELECT locationID, name FROM Locations;");

    res.render('performances', { title: 'Performances', performances, locations});
  } catch (err) {
    console.error(err);
    res.status(500).send("Database query error");
  }
});


// ===== practices =====
app.get('/practices', async (req, res) => {
    try {
    const [practices] = await db.query("SELECT Practices.practiceID, Practices.date, Locations.name AS locationName, Performances.name AS performanceName FROM Practices JOIN Locations ON Practices.locationID = Locations.locationID JOIN Performances ON Practices.performanceID = Performances.performanceID;");
    
    const [performances] = await db.query("SELECT performanceID, name FROM Performances;");

    const [locations] = await db.query("SELECT locationID, name FROM Locations;");
    
    res.render('practices', { title: 'Practices', practices, performances, locations });

  } catch (err) {
    console.error(err);
    res.status(500).send("Database query error");
  }
});

// ===== locations =====
app.get('/locations', async (req, res) => {
  try {
    const [results] = await db.query("SELECT * FROM Locations;");
    res.render('locations', { title: 'Locations', locations: results });
  } catch (err) {
    console.error(err);
    res.status(500).send("Database query error");
  }
});

// ===== dancer_practices =====
app.get('/dancerpractices', async (req, res) => {
  try {
    const [dancerpractices] = await db.query("SELECT Dancer_Practices.dancerPracticeID, Dancer_Practices.mandatory, Dancers.firstName, Dancers.lastName, Practices.date AS practiceDate FROM Dancer_Practices JOIN Dancers ON Dancer_Practices.dancerID = Dancers.dancerID JOIN Practices ON Dancer_Practices.practiceID = Practices.practiceID;");

    const [dancers] = await db.query("SELECT dancerID, firstName, lastName FROM Dancers;");

    const [practices] = await db.query("SELECT practiceID, date FROM Practices;");

    res.render('dancerpractices', { title: 'Dancer Practices', dancerpractices, dancers, practices});
  } catch (err) {
    console.error(err);
    res.status(500).send("Database query error");
  }
});

// ===== performers =====
app.get('/performers', async (req, res) => {
  try {
    const [performers] = await db.query("SELECT Performers.performerID, Dancers.firstName, Dancers.lastName, Performances.name AS performanceName FROM Performers JOIN Dancers ON Performers.dancerID = Dancers.dancerID JOIN Performances ON Performers.performanceID = Performances.performanceID;");

    const [dancers] = await db.query("SELECT dancerID, firstName, lastName FROM Dancers;");

    const [performances] = await db.query("SELECT performanceID, name FROM Performances;");

    res.render('performers', { title: 'Performers', performers, dancers, performances});

  } catch (err) {
    console.error(err);
    res.status(500).send("Database query error");
  }
});


// start server
app.listen(PORT, () => {
  console.log(`Server running at http://classwork.engr.oregonstate.edu:${PORT}`);
});