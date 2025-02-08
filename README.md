# Ola Cab Analysis - SQL & PowerBI Project

## Project Overview

**Project Title**: Cab Analysis  
**Database**: `ola_db`

This project is designed to demonstrate SQL skills or PowerBI skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a Cab Bookings database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries then create a interactive dashboaard on Power BI.

## Objectives

1. **Set up a Bookings database**: Create and populate a Bookings database with the provided Bookings data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.
5. **Dashboard**: Use Microsoft Power BI tool to create a interactive dashboard to visulaize thte analysis for deep understandings.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `ola_db`.
- **Table Creation**: A table named `bookings` is created to store the cab bookings data. The table structure includes columns for Date, Time, Booking_ID, Booking_Status, Customer_ID, Vehicle_Type, Pickup_Location, Drop_Location, V_TAT, C_TAT, Canceled_Rides_by_Customer, Canceled_Rides_by_Driver, Incomplete_Rides, Incomplete_Rides_Reason	Booking_Value, Payment_Method, Ride_Distance, Driver_Ratings, Customer_Rating.

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **-- 1. Retrieve all successful bookings --**:
```sql
CREATE VIEW success_bookings AS
SELECT * FROM bookings
WHERE booking_status = 'Success';
```

2. **Find the average ride distance for each vehicle type**:
```sql
CREATE VIEW ride_dist_of_each_vehicle AS
SELECT vehicle_type,
	   AVG(ride_distance) AS avg_ride_dist FROM bookings
GROUP BY 
	    vehicle_type;
```

3. **Get the total number of cancelled rides by customers.**:
```sql
CREATE VIEW cancelled_rides_by_customers AS
SELECT COUNT(*) FROM bookings
WHERE Booking_Status = 'canceled by customer';
```

4. **List the top 5 customers who booked the highest number of rides.**:
```sql
CREATE VIEW top_5_customer_with_high_bookings AS
SELECT Customer_ID, COUNT(booking_id) AS total_book_rides
FROM bookings
GROUP BY Customer_ID
ORDER BY total_book_rides DESC
LIMIT 5 ;
```

5. **Get the number of rides cancelled by drivers due to personal and car-related issues.**:
```sql
CREATE VIEW rides_cancelled_by_drivers_prsnl_car_issues AS
SELECT COUNT(*)
FROM bookings
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';
```

6. **Find the maximum and minimum driver ratings for Prime Sedan bookings.**:
```sql
CREATE VIEW max_min_driver_ratings_Prime_Sedan_bookings AS
SELECT MAX(Driver_Rating),
	   MIN(Driver_Rating) 
FROM bookings
WHERE 
	 Vehicle_Type = 'Prime Sedan';
```

7. **Retrieve all rides where payment was made using UPI**:
```sql
SCREATE VIEW pay_by_UPI AS
SELECT * FROM bookings
WHERE payment_method = 'UPI';
```

8. **Find the average customer rating per vehicle type. **:
```sql
CREATE VIEW avg_rating_each_vehicle AS
SELECT Vehicle_Type, 
	   AVG(Customer_Rating) 
FROM bookings
GROUP BY 
	   Vehicle_Type;
```

9. **Calculate the total booking value of rides completed successfully.**:
```sql
CREATE VIEW revenue_successful_bookings AS
SELECT SUM(Booking_Value) AS success_ride_revenue FROM bookings
WHERE Booking_Status = 'Success';
```

10. **List all incomplete rides along with the reason**
```sql
CREATE VIEW incomplete_ride_reasons AS
SELECT Booking_ID, Incomplete_Rides_Reasons FROM bookings
WHERE Incomplete_Rides = 'Yes';
```

# Create a view for each findings so that a manager can easily retieve the anlaysis
-- 1. Retrieve all successful bookings --
```SQL
SELECT * FROM success_bookings;
```

```SQL
-- 2. Get average ride distance for each vehicle type --
SELECT * FROM ride_dist_of_each_vehicle;
```

```SQL
-- 3. Get the total number of cancelled rides by customers --
SELECT * FROM cancelled_rides_by_customers;
```

```SQL
-- 4. List the top 5 customers who booked the highest number of rides --
SELECT * FROM top_5_customer_with_high_bookings;
```

```SQL
-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues --
SELECT * FROM rides_cancelled_by_drivers_prsnl_car_issues;
```

```SQL
-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings --
SELECT * FROM max_min_driver_ratings_Prime_Sedan_bookings;
```

```SQL
-- 7. Retrieve all rides where payment was made using UPI --
SELECT * FROM pay_by_UPI;
```

```SQL
-- 8. Find the average customer rating per vehicle type --
SELECT * FROM avg_rating_each_vehicle;
```

```SQL
-- 9. Calculate the total booking value of rides completed successfully --
SELECT * FROM revenue_successful_bookings;
```

```SQL
-- 10. List all incomplete rides along with the reason --
SELECT * FROM incomplete_ride_reasons;
```

## Findings

- **1: Ride Bookings Over Time** :- ● The ride bookings fluctuate daily, showing a peak of 3,432 rides and a low of 3,072 during the observed period. 
                                    ● Booking success rate is 62.09%, while cancellations by drivers, customers, and driver unavailability account for 37.91%. 
                                    ● Total bookings during the period amounted to 103,024 rides.
  
- **Payment Preferences**: ● Cash payments dominate (19.3M transactions), followed by UPI (14.2M). Credit and Debit Cards are minimally used. 
                           ● Highlighted preference for immediate, tangible payment methods.
  
- **Top Revenue-Generating Locations**: ● RT Nagar tops the chart with ₹777,106, closely followed by Nagarbhavi and Banashankari. 
                                         ● The top 5 locations contribute significantly to overall revenue.
  
- **Customer and Driver Analysis**: ● Top customers bring in revenue between ₹5,938 and ₹6,019, highlighting the importance of retaining high-value customers. 
                                    ● Average customer and driver ratings hover around 4.05, indicating generally satisfactory experiences. 


- **Cancellation Insights**: ● Cancellation rate stands at 28.08%, with key issues being: 
                                 ○ Personal and car-related problems (35.49%). 
                                 ○ Customer-related cancellations (30.24%). 
                                 ○ Incorrect addresses and over-permitted passengers. 
                             ● Canceled bookings cost the company ₹21M in lost revenue.

  
## Suggestions

1. Introduce incentive programs for drivers to minimize cancellations.
2. Implement predictive algorithms to match drivers with high-demand areas, reducing "Driver Not Found" issues.
3. Promote digital payments (UPI/Cards) through discounts or loyalty rewards.
4. Enhance trust in online transactions via security and ease-of-use campaigns.
5. Increase driver availability in these locations to capture latent demand. 
6. Launch localized promotions to boost revenue further in these high-performing areas.
7. Create a loyalty program to engage and retain top customers. 
8. Provide regular feedback and training to drivers based on rating trends.
  


## Conclusion

1. Offer real-time driver and customer support to address issues quickly. 
2. Implement a stricter penalty policy for frequent cancellations by both drivers and customers. 
3. Encourage customers to verify booking details to reduce errors.



For more content on SQL, data analysis, and other data-related topics, Make sure to connect on Linkedin:
- **LinkedIn**: [Connect with me professionally](www.linkedin.com/in/tarun-mahor)
- **Dashboard** [Dashboard](https://app.powerbi.com/links/tCIOhcYYJM?ctid=d5c5977f-36d4-41a3-b226-4ad8f0e79bbc&pbi_source=linkShare)

Thank you for your support, and I look forward to connecting with you!
