/*
ECLIPSE Crew Management System
Group 79 - Jenna Rivera and Kaelee Duong
DML SQL Statements 
*/

--
-- Dancer Queries 
--

-- Create: new Dancer
INSERT INTO Dancers (firstName, lastName, email)
VALUES (@firstNameInput, @lastNameInput, @emailInput);

-- Read: all Dancers info for page
SELECT dancerID, firstName, lastName, email
FROM Dancers;

-- Update: edit a Dancer's info
UPDATE Dancers
SET
    firstName = @firstNameInput,
    lastName = @lastNameInput,
    email = @email
WHERE dancerID = @dancerIDInput;

-- Delete: delete a dancer
DELETE FROM Dancers
WHERE dancerID = @dancerIDInput; 

--
-- Locations Queries
--

-- Create: new location
INSERT INTO Locations (name, address)
VALUES (@nameInput, @addressInput);

-- Read: all Location info
SELECT locationID, name, address
FROM Locations;

-- Update: edit a Location's info
UPDATE Locations
SET
    name = @nameInput,
    address = @addressInput
WHERE locationID = @locationIDInput;

-- Delete: delete a Location
DELETE FROM Locations
WHERE locationID = @locationIDInput;

--
-- Performances Queries 
--

-- Create: new Performance
INSERT INTO Performances (name, date, locationID)
VALUES (@nameInput, @dateInput, @locationIDInput);

-- Read: all Performance info
SELECT
    Performances.performanceID,
    Performances.name,
    Performances.date,
    Locations.name AS "Location Name"
FROM Performances
LEFT JOIN Locations ON Performances.locationID = Locations.locationID;

-- Update: edit a Performance's info
UPDATE Performances
SET
    name = @nameInput,
    date = @dateInput
    locationID = @locationIDInput
WHERE performanceID = @performanceIDInput;

-- Delete: delete a Performance
DELETE FROM Performances
WHERE performanceID = @performanceIDInput;

--
-- Practices Queries 
--

-- Create: new practice
INSERT INTO Practices (date, performanceID, locationID)
VALUES (@dateInput, @performanceIDInput, @locationIDInput);

-- Read: all Practices info
SELECT
    Practices.practiceID,
    Practices.date,
    Performances.name AS "Perfomance Name",
    Locations.name AS "Location Name"
FROM Practices
LEFT JOIN Performances ON Practices.performanceID = Performances.performanceID
LEFT JOIN Locations ON Practices.locationID = Locations.locationID;

-- Update: edit a Practice's info
UPDATE
SET
    date = @dateInput,
    performanceID = @performanceIDInput,
    locationID = @locationIDInput
WHERE practiceID = @practiceIDInput;

-- Delete: delete a Practice
DELETE FROM Practices
WHERE practiceID = @practiceIDInput;

--
-- Performers Queries 
--

-- Create: assign a dancer to a performance 
INSERT INTO Performers (dancerID, performanceID)
VALUES (@dancerIDInput, @performanceIDInput);

-- Read: all dancers in a performance 
SELECT
    Performers.performerID,
    Dancers.firstName,
    Dancers.lastName,
    Performances.name AS "Performance Name"
FROM Performers
INNER JOIN Dancers ON Performers.dancerID = Dancers.dancerID,
INNER JOIN Performances ON Performers.performanceID = Performances.performanceID
WHERE Performers.performanceID = @performanceIDInput;

-- Update: edit the link between a dancer and a performance
UPDATE Performers
SET
    dancerID = @dancerIDInput,
    performanceID = @performanceIDInput
WHERE performerID = @performerIDInput;

-- Delete: delete a dancer from a performance
DELETE FROM Performers
WHERE performerID = @performerIDInput;

--
-- Dancer_Practices Queries 
--

-- Create: assign a dancer to a practice
INSERT INTO Dancer_Practices (mandatory, dancerID, practiceID)
VALUES (@mandatoryInput, @dancerIDInput, @practiceIDInput);

-- Read: show all practices a dancer is assigned to 
SELECT
    Dancer_Practices.dancerPracticeID,
    Dancers.firstName,
    Dancers.lastName,
    Practices.date,
    Locations.name AS "Location Name",
    Dancer_Practices.mandatory
FROM Dancer_Practices
INNER JOIN Dancers ON Dancer_Practices.dancerID = Dancers.dancerID
INNER JOIN Practices ON Dancer_Practices.practiceID = Practices.practiceID
INNER JOIN Locations ON Practices.locationID = Locations.locationID
WHERE Dancer_Practices.dancerID = @dancerIDInput;

-- Update: change status
UPDATE Dancer_Practices
SET
    mandatory = @mandatoryInput,
    dancerID = @dancerIDInput,
    practiceID = @practiceIDInput
WHERE dancerPracticeID = @dancerPracticeIDInput;

-- Delete: delete a dancer from a practice
DELETE FROM Dancer_Practices
WHERE dancerPracticeID = @dancerPracticeIDInput;


