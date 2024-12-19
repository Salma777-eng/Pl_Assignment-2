# TRANSPORT MANAGEMENT SYSTEM
The Transport Management System (TMS) manages vehicles, drivers, routes, schedules, and customer bookings using Oracle Database. It allows users to create, retrieve, update, and delete transport data while performing operations like joins, subqueries, and access control. The system is designed for efficient transport logistics management.

## 1. Table structures

##  Vehicle table
```sql
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,
    VehicleNumber VARCHAR2(20),
    Capacity INT,
    Model VARCHAR2(50)
);
```

##  Driver table
```sql
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    DriverName VARCHAR2(100),
    LicenseNumber VARCHAR2(50),
    PhoneNumber VARCHAR2(15)
);
``````
##  Routes table
```sql
CREATE TABLE Routes (
    RouteID INT PRIMARY KEY,
    StartLocation VARCHAR2(100),
    EndLocation VARCHAR2(100),
    Distance NUMBER
);
```

##  Schedules table
```sql
CREATE TABLE Schedules (
    ScheduleID INT PRIMARY KEY,
    VehicleID INT,
    RouteID INT,
    DepartureTime TIMESTAMP,
    ArrivalTime TIMESTAMP,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    FOREIGN KEY (RouteID) REFERENCES Routes(RouteID)
);
``````
##  Bookings table
```sql
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustomerName VARCHAR2(100),
    ScheduleID INT,
    BookingDate DATE,
    FOREIGN KEY (ScheduleID) REFERENCES Schedules(ScheduleID)
);
```
## 2. Inserting data

## Inserting into Vehicles table
```sql
INSERT INTO Vehicles (VehicleID, VehicleNumber, Capacity, Model) 
VALUES (1, 'ABC123', 50, 'Mercedes Sprinter');
```
## Inserting into Drivers table
```sql
INSERT INTO Drivers (DriverID, DriverName, LicenseNumber, PhoneNumber) 
VALUES (1, 'John Doe', 'DL12345', '1234567890');
```
## Inserting into Routes table
```sql
INSERT INTO Routes (RouteID, StartLocation, EndLocation, Distance) 
VALUES (1, 'City A', 'City B', 150);
```
## Inserting into Schedules table
```sql
INSERT INTO Schedules (ScheduleID, VehicleID, RouteID, DepartureTime, ArrivalTime) 
VALUES (1, 1, 1, TO_TIMESTAMP('2024-10-10 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-10-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
```
## Inserting into Bookings table
```sql
INSERT INTO Bookings (BookingID, CustomerName, ScheduleID, BookingDate) 
VALUES (1, 'Alice Johnson', 1, SYSDATE);
```
## 3. Update and delete data

## Updating a vehicle's capacity
```sql
UPDATE Vehicles 
SET Capacity = 55 
WHERE VehicleID = 1;
```
## Deleting a booking
```sql
DELETE FROM Bookings 
WHERE BookingID = 1;
```
## 4. Perform Joins to Retrieve Related Data

## Retrieve all schedules with vehicle and route details
```sql
SELECT s.ScheduleID, v.VehicleNumber, r.StartLocation, r.EndLocation, s.DepartureTime, s.ArrivalTime
FROM Schedules s
JOIN Vehicles v ON s.VehicleID = v.VehicleID
JOIN Routes r ON s.RouteID = r.RouteID;
```
## 4. Subqueries

## Find the route details for the vehicle with the largest capacity
```sql
SELECT * FROM Routes 
WHERE RouteID = (SELECT RouteID FROM Schedules 
                 WHERE VehicleID = (SELECT VehicleID FROM Vehicles 
                                    ORDER BY Capacity DESC FETCH FIRST 1 ROWS ONLY));
```
  ## 4. DDL, DCL, and TCL Operations:
## DDL (Data Definition Language): For table creation, modification, etc.
```sql
ALTER TABLE Vehicles ADD Manufacturer VARCHAR2(50);
```
## DCL (Data Control Language): Granting or revoking privileges.
```sql
GRANT SELECT, INSERT ON Vehicles TO system;
```
## TCL (Transaction Control Language): Commit or rollback transactions.
```sql
BEGIN
    INSERT INTO Bookings (BookingID, CustomerName, ScheduleID, BookingDate) 
    VALUES (2, 'Bob Smith', 1, SYSDATE);
    
    COMMIT;
END;
```
"# Pl_Assignment-2" 
"# Pl_Assignment-2" 
"# Pl_Assignment-2" 
