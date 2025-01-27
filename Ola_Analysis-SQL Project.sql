CREATE DATABASE ola_db;
USE ola_db;

CREATE TABLE bookings 
(
date DATE,
time TIME,
booking_id VARCHAR(15),
booking_starus VARCHAR(20),
customer_id VARCHAR(10),
vehicle_type VARCHAR(15),
pickup_location VARCHAR(20),
drop_location VARCHAR(20),
v_tat INT,
c_tat INT,
canceled_rides_by_customer VARCHAR(50),
canceled_rides_by_driver VARCHAR(40),
incomplete_rides VARCHAR(4),
incomplete_rides_reasons VARCHAR(20),
booking_value INT,
payment_method VARCHAR(15),
ride_distance INT,
driver_rating INT,
customer_rating INT
);

SELECT * FROM bookings;


----- Analysis & Problem-solving -----
-- 1. Retrieve all successful bookings --
CREATE VIEW success_bookings AS
SELECT * FROM bookings
WHERE booking_status = 'Success';


-- 2. Find the average ride distance for each vehicle type --
CREATE VIEW ride_dist_of_each_vehicle AS
SELECT vehicle_type,
	   AVG(ride_distance) AS avg_ride_dist FROM bookings
GROUP BY 
	    vehicle_type;
        

-- 3. Get the total number of cancelled rides by customers --
CREATE VIEW cancelled_rides_by_customers AS
SELECT COUNT(*) FROM bookings
WHERE Booking_Status = 'canceled by customer';


-- 4. List the top 5 customers who booked the highest number of rides --
CREATE VIEW top_5_customer_with_high_bookings AS
SELECT Customer_ID, COUNT(booking_id) AS total_book_rides
FROM bookings
GROUP BY Customer_ID
ORDER BY total_book_rides DESC
LIMIT 5 ;


-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues --
CREATE VIEW rides_cancelled_by_drivers_prsnl_car_issues AS
SELECT COUNT(*)
FROM bookings
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';


-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings --
CREATE VIEW max_min_driver_ratings_Prime_Sedan_bookings AS
SELECT MAX(Driver_Rating),
	   MIN(Driver_Rating) 
FROM bookings
WHERE 
	 Vehicle_Type = 'Prime Sedan';
     

-- 7. Retrieve all rides where payment was made using UPI --
CREATE VIEW pay_by_UPI AS
SELECT * FROM bookings
WHERE payment_method = 'UPI';


-- 8. Find the average customer rating per vehicle type --
CREATE VIEW avg_rating_each_vehicle AS
SELECT Vehicle_Type, 
	   AVG(Customer_Rating) 
FROM bookings
GROUP BY 
	   Vehicle_Type;


-- 9. Calculate the total booking value of rides completed successfully --
CREATE VIEW revenue_successful_bookings AS
SELECT SUM(Booking_Value) AS success_ride_revenue FROM bookings
WHERE Booking_Status = 'Success';


-- 10. List all incomplete rides along with the reason --
CREATE VIEW incomplete_ride_reasons AS
SELECT Booking_ID, Incomplete_Rides_Reasons FROM bookings
WHERE Incomplete_Rides = 'Yes';





----- Analysis Results -----
-- 1. Retrieve all successful bookings --
SELECT * FROM success_bookings;

-- 2. Get average ride distance for each vehicle type --
SELECT * FROM ride_dist_of_each_vehicle;

-- 3. Get the total number of cancelled rides by customers --
SELECT * FROM cancelled_rides_by_customers;

-- 4. List the top 5 customers who booked the highest number of rides --
SELECT * FROM top_5_customer_with_high_bookings;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues --
SELECT * FROM rides_cancelled_by_drivers_prsnl_car_issues;

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings --
SELECT * FROM max_min_driver_ratings_Prime_Sedan_bookings;

-- 7. Retrieve all rides where payment was made using UPI --
SELECT * FROM pay_by_UPI;

-- 8. Find the average customer rating per vehicle type --
SELECT * FROM avg_rating_each_vehicle;

-- 9. Calculate the total booking value of rides completed successfully --
SELECT * FROM revenue_successful_bookings;

-- 10. List all incomplete rides along with the reason --
SELECT * FROM incomplete_ride_reasons;


