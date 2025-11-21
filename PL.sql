/*
Reset Procedure and Delete Operation by Jenna Rivera and Kaelee Duong
Group 79 Project Step 4 Draft
CS340 Fall 2025
*/

----------------------------------------------
-- Reset Procedure: drop tables, recreate tables, and add data
----------------------------------------------
DELIMITER //

CREATE PROCEDURE ResetProd()
BEGIN

    DROP TABLE IF EXISTS Dancers;
    DROP TABLE IF EXISTS Locations;
    DROP TABLE IF EXISTS Performances;
    DROP TABLE IF EXISTS Practices;
    DROP TABLE IF EXISTS Performers;
    DROP TABLE IF EXISTS Dancer_Practices;

    --
    -- Dancers table
    --
    CREATE TABLE Dancers (
        dancerID int(11) NOT NULL UNIQUE AUTO_INCREMENT,
        firstName varchar(255) NOT NULL,
        lastName varchar(255) NOT NULL,
        email varchar(255) NOT NULL,
        PRIMARY KEY (dancerID)
    );

    -- data for Dancers table
    INSERT INTO Dancers (
        firstName,
        lastName,
        email
    )
    VALUES
    ("Kaelee", "Duong", "kd@hello.com"),
    ("Jenna", "Rivera", "jr@hello.com"),
    ("Cool", "Dude", "cd@hello.com");

    --
    -- Locations table
    --
    CREATE TABLE Locations (
        locationID int(11) NOT NULL UNIQUE AUTO_INCREMENT,
        name varchar(255) NOT NULL,
        address varchar(255) NOT NULL,
        PRIMARY KEY (locationID)
    );

    -- data for Locations table
    INSERT INTO Locations (
        name,
        address
    )
    VALUES
    ("Memorial Union", "2501 SW Jefferson Way, Corvallis, OR 97331"),
    ("Frosty Fox", "2043 NW Monroe Ave, Corvallis, OR 97330"),
    ("Some Building","1234 Cool Blvd, Corvallis, OR 97330");

    --
    -- Performances table
    --
    CREATE TABLE Performances (
        performanceID int(11) NOT NULL UNIQUE AUTO_INCREMENT,
        name varchar(255) NOT NULL,
        date datetime NOT NULL,
        locationID int(11),
        PRIMARY KEY (performanceID),
        FOREIGN KEY (locationID) REFERENCES Locations(locationID)
            ON DELETE CASCADE
    );

    -- data for Performances table
    INSERT INTO Performances (
        name,
        date,
        locationID
    )
    VALUES
    ("Warm Performance", "2025-02-24", 1),
    ("Hot Performance", "2025-06-18", 2),
    ("Cool Performance", "2025-10-30", 3);

    --
    -- Practices table
    --

    CREATE TABLE Practices (
        practiceID int(11) NOT NULL UNIQUE AUTO_INCREMENT,
        date datetime NOT NULL,
        performanceID int(11),
        locationID int(11),
        PRIMARY KEY (practiceID),
        FOREIGN KEY (performanceID) REFERENCES Performances(performanceID)
            ON DELETE CASCADE,
        FOREIGN KEY (locationID) REFERENCES Locations(locationID)
            ON DELETE CASCADE
    );

    -- data for Practices table
    INSERT INTO Practices (
        date,
        performanceID,
        locationID
    )
    VALUES
    ("2025-01-30", 1, 1),
    ("2025-02-14", 2, 2),
    ("2025-04-24", 2, 2),
    ("2025-10-18", 3, 3);

    --
    -- Performers table
    --
    CREATE TABLE Performers (
        performerID int(11) NOT NULL UNIQUE AUTO_INCREMENT,
        dancerID int(11),
        performanceID int(11),
        PRIMARY KEY (performerID),
        FOREIGN KEY (dancerID) REFERENCES Dancers(dancerID)
            ON DELETE CASCADE,
        FOREIGN KEY (performanceID) REFERENCES Performances(performanceID)
            ON DELETE CASCADE
    );

    -- data Performers table
    INSERT INTO Performers (
        dancerID,
        performanceID
    )
    VALUES
    (1, 1),
    (1, 2),
    (2, 3);

    --
    -- Dancer_Practices table
    --
    CREATE TABLE Dancer_Practices (
        dancerPracticeID int(11) NOT NULL UNIQUE AUTO_INCREMENT,
        mandatory BOOLEAN DEFAULT TRUE,
        dancerID int(11),
        practiceID int(11),
        PRIMARY KEY (dancerPracticeID),
        FOREIGN KEY (dancerID) REFERENCES Dancers(dancerID)
            ON DELETE CASCADE,
        FOREIGN KEY (practiceID) REFERENCES Practices(practiceID)
            ON DELETE CASCADE
    );

    -- data for Dancer_Practices table
    INSERT INTO Dancer_Practices (
        mandatory,
        dancerID,
        practiceID
    )
    VALUES
    (TRUE, 1, 1),
    (TRUE, 2, 2),
    (FALSE, 3, 2),
    (FALSE, 3, 3);

END //
DELIMITER;

----------------------------------------------
-- Delete operations
----------------------------------------------

-- delete dancer
DELIMITER //

CREATE PROCEDURE DeleteDancer(IN dancerIDInput INT)
BEGIN
    DELETE FROM Dancers
    WHERE dancerID = dancerIDInput;
END //

DELIMITER;

-- delete location
DELIMITER //

CREATE PROCEDURE DeleteLocation(IN locationIDInput INT)
BEGIN
    DELETE FROM Locations
    WHERE locationID = locationIDInput;
END //

DELIMITER;

-- delete performance
DELIMITER //

CREATE PROCEDURE DeletePerformance(IN performanceIDInput INT)
BEGIN
    DELETE FROM Performances
    WHERE performanceID = performanceIDInput;
END //

DELIMITER;

-- delete practice
DELIMITER //

CREATE PROCEDURE DeletePractice(IN practiceIDInput INT)
BEGIN
    DELETE FROM Practices
    WHERE practiceID = practiceIDInput;
END //

DELIMITER;

-- delete performer
DELIMITER //

CREATE PROCEDURE DeletePerformer(IN performerIDInput INT)
BEGIN
    DELETE FROM Performers
    WHERE performerID = performerIDInput;
END //

DELIMITER;

-- delete dancer_practice
DELIMITER //

CREATE PROCEDURE DeleteDancerPractice(IN dancerPracticeIDInput INT)
BEGIN
    DELETE FROM Dancer_Practices
    WHERE dancerPracticeID = dancerPracticeIDInput;
END //

DELIMITER;
