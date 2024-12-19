
-- Creating the Vehicles table
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    VehicleNumber VARCHAR2(20),
    Capacity INT,
    Model VARCHAR2(50)
);

-- Creating the Drivers table
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    DriverName VARCHAR2(100),
    LicenseNumber VARCHAR2(50),
    PhoneNumber VARCHAR2(15)
);

-- Creating the Routes table
CREATE TABLE Routes (
    RouteID INT PRIMARY KEY,
    StartLocation VARCHAR2(100),
    EndLocation VARCHAR2(100),
    Distance NUMBER
);

-- Creating the Schedules table
CREATE TABLE Schedules (
    ScheduleID INT PRIMARY KEY,
    VehicleID INT,
    RouteID INT,
    DepartureTime TIMESTAMP,
    ArrivalTime TIMESTAMP,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    FOREIGN KEY (RouteID) REFERENCES Routes(RouteID)
);

-- Creating the Bookings table
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustomerName VARCHAR2(100),
    ScheduleID INT,
    BookingDate DATE,
    FOREIGN KEY (ScheduleID) REFERENCES Schedules(ScheduleID)
);
-- Inserting into Vehicles table
INSERT INTO Vehicles (VehicleID, VehicleNumber, Capacity, Model) 
VALUES (1, 'ABC123', 50, 'Mercedes Sprinter');

-- Inserting into Drivers table
INSERT INTO Drivers (DriverID, DriverName, LicenseNumber, PhoneNumber) 
VALUES (1, 'John Doe', 'DL12345', '1234567890');

-- Inserting into Routes table
INSERT INTO Routes (RouteID, StartLocation, EndLocation, Distance) 
VALUES (1, 'City A', 'City B', 150);

-- Inserting into Schedules table
INSERT INTO Schedules (ScheduleID, VehicleID, RouteID, DepartureTime, ArrivalTime) 
VALUES (1, 1, 1, TO_TIMESTAMP('2024-10-10 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-10-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Inserting into Bookings table
INSERT INTO Bookings (BookingID, CustomerName, ScheduleID, BookingDate) 
VALUES (1, 'Alice Johnson', 1, SYSDATE);
-- Updating a vehicle's capacity
UPDATE Vehicles 
SET Capacity = 55 
WHERE VehicleID = 1;

-- Deleting a booking
DELETE FROM Bookings 
WHERE BookingID = 1;
-- Retrieve all schedules with vehicle and route details
SELECT s.ScheduleID, v.VehicleNumber, r.StartLocation, r.EndLocation, s.DepartureTime, s.ArrivalTime
FROM Schedules s
JOIN Vehicles v ON s.VehicleID = v.VehicleID
JOIN Routes r ON s.RouteID = r.RouteID;
-- Find the route details for the vehicle with the largest capacity
SELECT * FROM Routes 
WHERE RouteID = (SELECT RouteID FROM Schedules 
                 WHERE VehicleID = (SELECT VehicleID FROM Vehicles 
                                    ORDER BY Capacity DESC FETCH FIRST 1 ROWS ONLY));
ALTER TABLE Vehicles ADD Manufacturer VARCHAR2(50);
GRANT SELECT, INSERT ON Vehicles TO system;
BEGIN
    INSERT INTO Bookings (BookingID, CustomerName, ScheduleID, BookingDate) 
    VALUES (2, 'Bob Smith', 1, SYSDATE);
    
    COMMIT;
END;
