 -- Step 1: Create the database for the Event Management System
CREATE DATABASE EventManagement2;  -- Creates a new database named 'EventManagement2'

-- Step 2: Use the created database
USE EventManagement2;  -- Switches to the 'EventManagement2' database to execute further commands

-- Step 3: Create a table for venues
CREATE TABLE Venues (  -- Starts the definition of the 'Venues' table
    VenueID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each venue, auto-incrementing
    VenueName VARCHAR(100) NOT NULL,  -- Name of the venue, cannot be NULL
    Location VARCHAR(255) NOT NULL,  -- Location of the venue, cannot be NULL
    Capacity INT NOT NULL,  -- Maximum capacity of the venue, cannot be NULL
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Timestamp of when the venue record was created
);  

-- Step 4: Create a table for sponsors
CREATE TABLE Sponsors (  -- Starts the definition of the 'Sponsors' table
    SponsorID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each sponsor, auto-incrementing
    SponsorName VARCHAR(100) NOT NULL,  -- Name of the sponsor, cannot be NULL
    ContactEmail VARCHAR(100),  -- Email of the sponsor for contact, optional
    Phone VARCHAR(15),  -- Phone number of the sponsor, optional
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Timestamp of when the sponsor record was created
);  

-- Step 5: Create a table for events
CREATE TABLE Events (  -- Starts the definition of the 'Events' table
    EventID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each event, auto-incrementing
    EventName VARCHAR(100) NOT NULL,  -- Name of the event, cannot be NULL
    VenueID INT,  -- ID of the venue where the event takes place, optional
    EventDate DATETIME NOT NULL,  -- Date and time of the event, cannot be NULL
    Description TEXT,  -- Detailed description of the event, optional
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of when the event record was created
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID)  -- Foreign key relationship with Venues table
);  

-- Step 6: Create a table for attendees
CREATE TABLE Attendees (  -- Starts the definition of the 'Attendees' table
    AttendeeID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each attendee, auto-incrementing
    FirstName VARCHAR(50) NOT NULL,  -- Attendee's first name, cannot be NULL
    LastName VARCHAR(50) NOT NULL,  -- Attendee's last name, cannot be NULL
    Email VARCHAR(100) NOT NULL UNIQUE,  -- Attendee's email, must be unique, cannot be NULL
    Phone VARCHAR(15),  -- Attendee's phone number, optional
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Timestamp of when the attendee record was created
);  

-- Step 7: Create a table for event registrations (linking attendees and events)
CREATE TABLE EventRegistrations (  -- Starts the definition of the 'EventRegistrations' table
    RegistrationID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each registration, auto-incrementing
    EventID INT,  -- ID of the event for which the registration is made, optional
    AttendeeID INT,  -- ID of the attendee making the registration, optional
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of when the registration was made
    FOREIGN KEY (EventID) REFERENCES Events(EventID),  -- Foreign key relationship with Events table
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)  -- Foreign key relationship with Attendees table
);  

-- Step 8: Insert sample data into the Venues table
INSERT INTO Venues (VenueName, Location, Capacity) VALUES  -- Inserts sample records into the 'Venues' table
('Conference Hall', '123 Main St, City A', 500),  -- First venue entry
('Outdoor Stadium', '456 Park Ave, City B', 2000),  -- Second venue entry
('Meeting Room', '789 Elm St, City C', 100);  -- Third venue entry

-- Step 9: Insert sample data into the Sponsors table
INSERT INTO Sponsors (SponsorName, ContactEmail, Phone) VALUES  -- Inserts sample records into the 'Sponsors' table
('Company A', 'contact@companya.com', '123-456-7890'),  -- First sponsor entry
('Company B', 'contact@companyb.com', '234-567-8901');  -- Second sponsor entry

-- Step 10: Insert sample data into the Events table
INSERT INTO Events (EventName, VenueID, EventDate, Description) VALUES  -- Inserts sample records into the 'Events' table
('Tech Conference 2024', 1, '2024-05-15 09:00:00', 'A conference for tech enthusiasts.'),  -- First event entry
('Sports Day 2024', 2, '2024-06-20 10:00:00', 'A day full of sports activities.'),  -- Second event entry
('Monthly Meeting', 3, '2024-07-01 14:00:00', 'A meeting for all staff members.');  -- Third event entry

-- Step 11: Insert sample data into the Attendees table
INSERT INTO Attendees (FirstName, LastName, Email, Phone) VALUES  -- Inserts sample records into the 'Attendees' table
('John', 'Doe', 'john.doe@example.com', '111-222-3333'),  -- First attendee entry
('Jane', 'Smith', 'jane.smith@example.com', '444-555-6666');  -- Second attendee entry

-- Step 12: Insert sample data into EventRegistrations table
INSERT INTO EventRegistrations (EventID, AttendeeID) VALUES  -- Inserts sample records into the 'EventRegistrations' table
(1, 1),  -- Registering attendee 1 for event 1
(1, 2),  -- Registering attendee 2 for event 1
(2, 1);  -- Registering attendee 1 for event 2

-- Step 13: Select all venues
SELECT * FROM Venues;  -- Retrieves and displays all records from the 'Venues' table

-- Step 14: Select all sponsors
SELECT * FROM Sponsors;  -- Retrieves and displays all records from the 'Sponsors' table

-- Step 15: Select all events
SELECT * FROM Events;  -- Retrieves and displays all records from the 'Events' table

-- Step 16: Select all attendees
SELECT * FROM Attendees;  -- Retrieves and displays all records from the 'Attendees' table

-- Step 17: Select all event registrations
SELECT * FROM EventRegistrations;  -- Retrieves and displays all records from the 'EventRegistrations' table

-- Step 18: Get events scheduled in a specific month (e.g., May 2024)
SELECT * FROM Events WHERE MONTH(EventDate) = 5 AND YEAR(EventDate) = 2024;  -- Filters events occurring in May 2024

-- Step 19: Count total attendees for each event
SELECT EventID, COUNT(AttendeeID) AS TotalAttendees  -- Selects EventID and counts the number of attendees
FROM EventRegistrations  -- From the 'EventRegistrations' table
GROUP BY EventID;  -- Groups results by EventID

-- Step 20: Find events with no attendees
SELECT EventID, EventName  -- Selects EventID and EventName
FROM Events  -- From the 'Events' table
WHERE EventID NOT IN (SELECT EventID FROM EventRegistrations);  -- Where the EventID is not in the list of registered events

-- Step 21: Update an event's venue
UPDATE Events  -- Begins an update on the 'Events' table
SET VenueID = 2  -- Sets the VenueID to 2
WHERE EventID = 1;  -- Only for the event with EventID 1

-- Step 22: Get a report of all events with their venues
SELECT E.EventName, V.VenueName, E.EventDate  -- Selects EventName, VenueName, and EventDate
FROM Events E  -- From the 'Events' table, aliased as E
JOIN Venues V ON E.VenueID = V.VenueID;  -- Joins with the 'Venues' table on VenueID

-- Step 23: Get a report of all attendees with their registrations
SELECT A.FirstName, A.LastName, E.EventName  -- Selects attendee names and event names
FROM Attendees A  -- From the 'Attendees' table, aliased as A
JOIN EventRegistrations ER ON A.AttendeeID = ER.AttendeeID  -- Joins with 'EventRegistrations' on AttendeeID
JOIN Events E ON ER.EventID = E.EventID;  -- Joins with 'Events' on EventID

-- Step 24: Get upcoming events sorted by date
SELECT EventName, EventDate  -- Selects EventName and EventDate
FROM Events  -- From the 'Events' table
WHERE EventDate > NOW()  -- Filters events that are in the future
ORDER BY EventDate;  -- Orders results by EventDate in ascending order

-- Step 25: Create an index on EventDate in Events table
CREATE INDEX idx_event_date ON Events(EventDate);  -- Creates an index on the EventDate column for faster queries

-- Step 26: Add a column for event status in Events table
ALTER TABLE Events  -- Begins alteration of the 'Events' table
ADD COLUMN Status ENUM('Scheduled', 'Cancelled', 'Completed') DEFAULT 'Scheduled';  -- Adds a status column with default value

-- Step 27: Update the status of an event
UPDATE Events  -- Begins an update on the 'Events' table
SET Status = 'Completed'  -- Sets the Status to 'Completed'
WHERE EventID = 2;  -- Only for the event with EventID 2

-- Step 28: Create a view for upcoming events
CREATE VIEW UpcomingEvents AS  -- Creates a view called 'UpcomingEvents'
SELECT EventName, EventDate  -- Selects EventName and EventDate
FROM Events  -- From the 'Events' table
WHERE EventDate > NOW();  -- Filters events that are in the future

-- Step 29: Select from the created view
SELECT * FROM UpcomingEvents;  -- Retrieves all records from the 'UpcomingEvents' view

-- Step 30: Drop a specific event (event with ID 3)
DELETE FROM Events WHERE EventID = 3;  -- Deletes the event with EventID 3

-- Step 31: Optimize all tables
OPTIMIZE TABLE Venues, Sponsors, Events, Attendees, EventRegistrations;  -- Optimizes all specified tables

-- Step 32: Show the database schema
SHOW TABLES;  -- Lists all tables in the current database

-- Step 33: Create a table for event categories
CREATE TABLE EventCategories (  -- Starts the definition of the 'EventCategories' table
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each category, auto-incrementing
    CategoryName VARCHAR(100) NOT NULL UNIQUE,  -- Name of the category, must be unique and cannot be NULL
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Timestamp of when the category record was created
);  

-- Step 34: Insert sample categories into the EventCategories table
INSERT INTO EventCategories (CategoryName) VALUES  -- Inserts sample records into the 'EventCategories' table
('Conference'),  -- First category entry
('Workshop'),  -- Second category entry
('Seminar');  -- Third category entry

-- Step 35: Add a foreign key for categories in the Events table
ALTER TABLE Events  -- Begins alteration of the 'Events' table
ADD COLUMN CategoryID INT,  -- Adds CategoryID column to link events to their categories
ADD FOREIGN KEY (CategoryID) REFERENCES EventCategories(CategoryID);  -- Establishes foreign key relationship with EventCategories table

-- Step 36: Update existing events to assign categories
UPDATE Events  -- Begins an update on the 'Events' table
SET CategoryID = 1  -- Assigns CategoryID of 1 (Conference) to the first event
WHERE EventID = 1;  -- Only for the event with EventID 1

UPDATE Events  -- Begins an update on the 'Events' table
SET CategoryID = 2  -- Assigns CategoryID of 2 (Workshop) to the second event
WHERE EventID = 2;  -- Only for the event with EventID 2

UPDATE Events  -- Begins an update on the 'Events' table
SET CategoryID = 3  -- Assigns CategoryID of 3 (Seminar) to the third event
WHERE EventID = 3;  -- Only for the event with EventID 3

-- Step 37: Create a table for feedback on events
CREATE TABLE EventFeedback (  -- Starts the definition of the 'EventFeedback' table
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each feedback entry, auto-incrementing
    EventID INT NOT NULL,  -- ID of the event for which the feedback is provided, cannot be NULL
    AttendeeID INT NOT NULL,  -- ID of the attendee giving the feedback, cannot be NULL
    Rating INT CHECK (Rating BETWEEN 1 AND 5),  -- Rating of the event, must be between 1 and 5
    Comments TEXT,  -- Optional comments from the attendee
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of when the feedback record was created
    FOREIGN KEY (EventID) REFERENCES Events(EventID),  -- Foreign key relationship with Events table
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)  -- Foreign key relationship with Attendees table
);  

-- Step 38: Insert sample feedback into the EventFeedback table
INSERT INTO EventFeedback (EventID, AttendeeID, Rating, Comments) VALUES  -- Inserts sample records into the 'EventFeedback' table
(1, 1, 5, 'Excellent event! Very informative.'),  -- Feedback for event 1 from attendee 1
(2, 2, 4, 'Great activities, but could be better organized.');  -- Feedback for event 2 from attendee 2

-- Step 39: Retrieve all feedback for a specific event
SELECT * FROM EventFeedback WHERE EventID = 1;  -- Retrieves all feedback records for event with ID 1

-- Step 40: Retrieve average rating for each event
SELECT EventID, AVG(Rating) AS AverageRating  -- Selects EventID and calculates average rating
FROM EventFeedback  -- From the 'EventFeedback' table
GROUP BY EventID;  -- Groups results by EventID

-- Step 41: Create a table for sponsors' events
CREATE TABLE SponsorEvents (  -- Starts the definition of the 'SponsorEvents' table
    SponsorEventID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each sponsor-event relationship, auto-incrementing
    SponsorID INT NOT NULL,  -- ID of the sponsor, cannot be NULL
    EventID INT NOT NULL,  -- ID of the event, cannot be NULL
    FOREIGN KEY (SponsorID) REFERENCES Sponsors(SponsorID),  -- Foreign key relationship with Sponsors table
    FOREIGN KEY (EventID) REFERENCES Events(EventID)  -- Foreign key relationship with Events table
); 

-- Step 42: Insert sample sponsor-event relationships
INSERT INTO SponsorEvents (SponsorID, EventID) VALUES  -- Inserts sample records into the 'SponsorEvents' table
(1, 1),  -- Sponsor 1 is sponsoring event 1
(2, 2);  -- Sponsor 2 is sponsoring event 2

-- Step 43: Get a report of events with their sponsors
SELECT E.EventName, S.SponsorName  -- Selects EventName and SponsorName
FROM Events E  -- From the 'Events' table, aliased as E
JOIN SponsorEvents SE ON E.EventID = SE.EventID  -- Joins with 'SponsorEvents' on EventID
JOIN Sponsors S ON SE.SponsorID = S.SponsorID;  -- Joins with 'Sponsors' on SponsorID

-- Step 44: Create a stored procedure for adding new events
DELIMITER $$  -- Change the delimiter to allow multi-line commands

CREATE PROCEDURE AddEvent (  -- Defines a new stored procedure named 'AddEvent'
    IN p_EventName VARCHAR(100),  -- Input parameter for event name
    IN p_VenueID INT,  -- Input parameter for venue ID
    IN p_EventDate DATETIME,  -- Input parameter for event date
    IN p_Description TEXT,  -- Input parameter for event description
    IN p_CategoryID INT  -- Input parameter for category ID
)
BEGIN
    -- Insert the new event using the provided input parameters
    INSERT INTO Events (EventName, VenueID, EventDate, Description, CategoryID) 
    VALUES (p_EventName, p_VenueID, p_EventDate, p_Description, p_CategoryID);
END $$  -- Ends the procedure and returns to the original delimiter

DELIMITER ;  -- Revert the delimiter back to the default

-- Step 45: Create a trigger for logging event registrations
DELIMITER $$  -- Changes the delimiter for the trigger definition

CREATE TRIGGER LogEventRegistration  -- Defines a new trigger named 'LogEventRegistration'
AFTER INSERT ON EventRegistrations  -- Specifies that it triggers after a new registration
FOR EACH ROW  -- For each new row inserted

BEGIN  -- Begins the trigger body
    INSERT INTO EventFeedback (EventID, AttendeeID, Rating) VALUES  -- Inserts a log entry into 'EventFeedback'
    (NEW.EventID, NEW.AttendeeID, NULL);  -- Uses values from the new row for EventID and AttendeeID

END $$  -- Ends the trigger definition

-- Step 46: Retrieve all upcoming events with their venues and sponsors
SELECT E.EventName, V.VenueName, S.SponsorName, E.EventDate  -- Selects event name, venue name, sponsor name, and event date
FROM Events E  -- From the 'Events' table, aliased as E
JOIN Venues V ON E.VenueID = V.VenueID  -- Joins with 'Venues' on VenueID
LEFT JOIN SponsorEvents SE ON E.EventID = SE.EventID  -- Left join to include events without sponsors
LEFT JOIN Sponsors S ON SE.SponsorID = S.SponsorID  -- Left join to include sponsors if available
WHERE E.EventDate > NOW()  -- Filters for events that are in the future
ORDER BY E.EventDate;  -- Orders results by EventDate

-- Step 47: Create an index on the Email field in the Attendees table
CREATE INDEX idx_attendee_email ON Attendees(Email);  -- Creates an index on the Email column for faster lookups

-- Step 48: Add a column for social media handles in the Attendees table
ALTER TABLE Attendees  -- Begins alteration of the 'Attendees' table
ADD COLUMN SocialMediaHandle VARCHAR(100);  -- Adds a column for social media handles

-- Step 49: Update the social media handle for an attendee
UPDATE Attendees  -- Begins an update on the 'Attendees' table
SET SocialMediaHandle = '@johndoe'  -- Sets the social media handle for the attendee
WHERE AttendeeID = 1;  -- Only for the attendee with AttendeeID 1

-- Step 50: Create a report showing all attendees and their events
SELECT A.FirstName, A.LastName, E.EventName  -- Selects attendee names and event names
FROM Attendees A  -- From the 'Attendees' table, aliased as A
JOIN EventRegistrations ER ON A.AttendeeID = ER.AttendeeID  -- Joins with 'EventRegistrations' on AttendeeID
JOIN Events E ON ER.EventID = E.EventID  -- Joins with 'Events' on EventID
ORDER BY A.LastName;  -- Orders results by the last name of attendees

-- Step 51: Create a table for event sponsors' feedback
CREATE TABLE SponsorFeedback (  -- Starts the definition of the 'SponsorFeedback' table
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each feedback entry, auto-incrementing
    SponsorID INT NOT NULL,  -- ID of the sponsor providing feedback, cannot be NULL
    EventID INT NOT NULL,  -- ID of the event related to the feedback, cannot be NULL
    Rating INT CHECK (Rating BETWEEN 1 AND 5),  -- Rating given by the sponsor, must be between 1 and 5
    Comments TEXT,  -- Optional comments from the sponsor
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of when the feedback record was created
    FOREIGN KEY (SponsorID) REFERENCES Sponsors(SponsorID),  -- Foreign key relationship with Sponsors table
    FOREIGN KEY (EventID) REFERENCES Events(EventID)  -- Foreign key relationship with Events table
);  

-- Step 52: Insert sample sponsor feedback
INSERT INTO SponsorFeedback (SponsorID, EventID, Rating, Comments) VALUES  -- Inserts sample records into the 'SponsorFeedback' table
(1, 1, 5, 'Proud to sponsor such an important event!'),  -- Feedback for event 1 from sponsor 1
(2, 2, 4, 'Good experience but need better communication.');  -- Feedback for event 2 from sponsor 2

-- Step 53: Generate a summary report of all events with total attendees and average feedback rating
SELECT E.EventName, COUNT(ER.AttendeeID) AS TotalAttendees, AVG(EF.Rating) AS AverageFeedbackRating  -- Selects event name, total attendees, and average feedback rating
FROM Events E  -- From the 'Events' table, aliased as E
LEFT JOIN EventRegistrations ER ON E.EventID = ER.EventID  -- Left join with 'EventRegistrations' to get total attendees
LEFT JOIN EventFeedback EF ON E.EventID = EF.EventID  -- Left join with 'EventFeedback' to get average feedback rating
GROUP BY E.EventID;  -- Groups results by EventID

-- Step 54: Create a table for event reminders
CREATE TABLE EventReminder (  -- Starts the definition of the 'EventReminders' table
    ReminderID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each reminder entry, auto-incrementing
    EventID INT NOT NULL,  -- ID of the event for which the reminder is set, cannot be NULL
    AttendeeID INT NOT NULL,  -- ID of the attendee to whom the reminder is sent, cannot be NULL
    ReminderDate DATETIME NOT NULL,  -- Date and time when the reminder should be sent, cannot be NULL
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of when the reminder record was created
    FOREIGN KEY (EventID) REFERENCES Events(EventID),  -- Foreign key relationship with Events table
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)  -- Foreign key relationship with Attendees table
);  

-- Step 55: Insert sample reminders into the EventReminders table
DESCRIBE EventReminder;

ALTER TABLE EventReminder
MODIFY COLUMN AttendeeID INT;

INSERT INTO EventReminder (EventID, AttendeeID, ReminderDate) 
VALUES  
(1, 1, '2024-05-14 09:00:00'),  -- Reminder for attendee 1 about event 1
(2, 2, '2024-06-19 10:00:00');  -- Reminder for attendee 2 about event 2

CREATE TABLE EventReminder (
    ReminderID INT AUTO_INCREMENT PRIMARY KEY,
    EventID INT,
    AttendeeID INT,
    ReminderDate DATETIME
);

-- Step 56: Retrieve reminders for a specific attendee
SELECT ER.ReminderID, E.EventName, ER.ReminderDate  -- Selects reminder ID, event name, and reminder date
FROM EventReminder ER  -- From the 'EventReminders' table, aliased as ER
JOIN Events E ON ER.EventID = E.EventID  -- Joins with 'Events' on EventID
WHERE ER.AttendeeID = 1;  -- Retrieves reminders for attendee with ID 1

-- Step 57: Create a stored procedure for sending reminders
DELIMITER $$  -- Change the delimiter to allow multi-line commands

CREATE PROCEDURE SendReminder (  -- Defines a new stored procedure named 'SendReminder'
    IN p_ReminderID INT  -- Input parameter for reminder ID
)
BEGIN
    DECLARE v_EventName VARCHAR(100);  -- Variable to hold the event name
    DECLARE v_AttendeeEmail VARCHAR(100);  -- Variable to hold the attendee's email

    -- Retrieve the event name and attendee's email for the reminder
    SELECT E.EventName, A.Email INTO v_EventName, v_AttendeeEmail
    FROM EventReminder ER
    JOIN Events E ON ER.EventID = E.EventID
    JOIN Attendees A ON ER.AttendeeID = A.AttendeeID
    WHERE ER.ReminderID = p_ReminderID;

    -- Here, you would normally send the email reminder (pseudocode):
    -- CALL SendEmail(v_AttendeeEmail, v_EventName);

    -- For demonstration, we will just select the values:
    SELECT CONCAT('Reminder sent to ', v_AttendeeEmail, ' for event: ', v_EventName) AS ReminderStatus;
END $$  -- Ends the procedure and returns to the original delimiter

DELIMITER ;  -- Revert the delimiter back to the default

-- Step 58: Schedule regular reminder checks (this would depend on your DBMS)
-- In practice, you would set up an event or a scheduled job depending on your database capabilities.

-- Step 59: Create a report showing all reminders and their respective events
SELECT E.EventName, A.FirstName, A.LastName, ER.ReminderDate  -- Selects event name, attendee names, and reminder date
FROM EventReminder ER  -- From the 'EventReminders' table
JOIN Events E ON ER.EventID = E.EventID  -- Joins with 'Events' on EventID
JOIN Attendees A ON ER.AttendeeID = A.AttendeeID  -- Joins with 'Attendees' on AttendeeID
ORDER BY ER.ReminderDate;  -- Orders results by the reminder date

-- Step 60: Optimize the EventReminders table
OPTIMIZE TABLE EventReminders;  -- Optimizes the 'EventReminders' table for performance

-- Step 61: Generate a report of events along with their feedback ratings and comments
SELECT E.EventName, AVG(EF.Rating) AS AverageRating, GROUP_CONCAT(EF.Comments SEPARATOR '; ') AS Comments  -- Selects event name, average rating, and concatenated comments
FROM Events E  -- From the 'Events' table
LEFT JOIN EventFeedback EF ON E.EventID = EF.EventID  -- Left join to include events with no feedback
GROUP BY E.EventID;  -- Groups results by EventID

-- Step 62: Create a view for event statistics
CREATE VIEW EventStatistics AS  -- Creates a view called 'EventStatistics'
SELECT E.EventID, E.EventName, COUNT(ER.AttendeeID) AS TotalAttendees, AVG(EF.Rating) AS AverageFeedback  -- Selects event ID, event name, total attendees, and average feedback
FROM Events E  -- From the 'Events' table
LEFT JOIN EventRegistrations ER ON E.EventID = ER.EventID  -- Left join with 'EventRegistrations'
LEFT JOIN EventFeedback EF ON E.EventID = EF.EventID  -- Left join with 'EventFeedback'
GROUP BY E.EventID;  -- Groups results by EventID

-- Step 63: Retrieve data from the EventStatistics view
SELECT * FROM EventStatistics;  -- Retrieves all records from the 'EventStatistics' view