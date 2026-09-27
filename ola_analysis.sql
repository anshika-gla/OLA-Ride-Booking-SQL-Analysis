CREATE DATABASE ola_analysis;

USE ola_analysis;
CREATE TABLE ola_bookings (
    Booking_ID VARCHAR(20),
    Booking_Date DATE,
    Booking_Status VARCHAR(30),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    Ride_Distance DECIMAL(10,2),
    Driver_Ratings DECIMAL(3,2),
    Customer_Rating DECIMAL(3,2),
    Booking_Value DECIMAL(10,2),
    Payment_Method VARCHAR(30),
    Cancelled_By VARCHAR(30),
    Cancellation_Reason VARCHAR(255),
    Driver_ID VARCHAR(20)
);

USE ola_analysis;

SELECT COUNT(*) AS total_records
FROM ola_bookings;

SELECT COUNT(*) FROM ola_bookings;

USE ola_analysis;

SELECT COUNT(*) AS total_records
FROM ola_ride_bookings_10000;

DROP TABLE ola_bookings;


RENAME TABLE ola_ride_bookings_10000
TO ola_bookings;

USE ola_analysis;

SHOW TABLES;

USE ola_analysis;

SHOW TABLES;
SELECT COUNT(*) AS total_records
FROM ola_ride_bookings_10000;

USE ola_analysis;

SELECT *
FROM ola_ride_bookings_10000
LIMIT 10;
DESCRIBE ola_ride_bookings_10000;

USE ola_analysis;

SELECT 
    Booking_Status,
    COUNT(*) AS total_bookings
FROM ola_ride_bookings_10000
GROUP BY Booking_Status;

SELECT 
    Vehicle_Type,
    COUNT(*) AS total_rides
FROM ola_ride_bookings_10000
GROUP BY Vehicle_Type
ORDER BY total_rides DESC;

SELECT 
    Payment_Method,
    COUNT(*) AS transactions
FROM ola_ride_bookings_10000
GROUP BY Payment_Method
ORDER BY transactions DESC;

SELECT
    Booking_Status,
    COUNT(*) AS total_bookings
FROM ola_ride_bookings_10000
GROUP BY Booking_Status
ORDER BY total_bookings DESC;

SELECT
    ROUND(
        SUM(CASE
            WHEN Booking_Status <> 'Success' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM ola_ride_bookings_10000;

SELECT 
    SUM(Booking_Value) AS total_revenue
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success';

SELECT 
    ROUND(AVG(Booking_Value), 2) AS average_booking_value
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success';

SELECT 
    ROUND(AVG(Booking_Value), 2) AS average_booking_value
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success';

SELECT
    Vehicle_Type,
    COUNT(*) AS successful_rides,
    ROUND(SUM(Booking_Value), 2) AS total_revenue
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY total_revenue DESC;

SELECT
    Payment_Method,
    COUNT(*) AS successful_rides,
    ROUND(SUM(Booking_Value), 2) AS total_revenue
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Payment_Method
ORDER BY total_revenue DESC;

SELECT
    Cancelled_By,
    Cancellation_Reason,
    COUNT(*) AS total_cancellations
FROM ola_ride_bookings_10000
WHERE Booking_Status <> 'Success'
GROUP BY Cancelled_By, Cancellation_Reason
ORDER BY total_cancellations DESC;

SELECT
    Driver_ID,
    COUNT(*) AS successful_rides,
    ROUND(AVG(Driver_Ratings), 2) AS avg_driver_rating
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Driver_ID
ORDER BY successful_rides DESC
LIMIT 10;

SELECT
    Driver_ID,
    COUNT(*) AS successful_rides,
    ROUND(AVG(Driver_Ratings), 2) AS avg_driver_rating
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Driver_ID
HAVING COUNT(*) >= 10
ORDER BY avg_driver_rating DESC
LIMIT 10;


SELECT
    Vehicle_Type,
    COUNT(*) AS successful_rides,
    ROUND(AVG(Customer_Rating), 2) AS avg_customer_rating
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY avg_customer_rating DESC;

SELECT
    Pickup_Location,
    COUNT(*) AS successful_rides
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Pickup_Location
ORDER BY successful_rides DESC
LIMIT 10;
SELECT
    Pickup_Location,
    Drop_Location,
    COUNT(*) AS successful_rides
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Pickup_Location, Drop_Location
ORDER BY successful_rides DESC
LIMIT 10;


SELECT
    Vehicle_Type,
    COUNT(*) AS total_bookings,
    SUM(CASE
        WHEN Booking_Status != 'Success' THEN 1
        ELSE 0
    END) AS cancelled_bookings,
    ROUND(
        SUM(CASE
            WHEN Booking_Status != 'Success' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM ola_ride_bookings_10000
GROUP BY Vehicle_Type
ORDER BY cancellation_rate DESC;

SELECT
    DATE_FORMAT(STR_TO_DATE(Booking_Date, '%d-%m-%Y'), '%Y-%m') AS booking_month,
    COUNT(*) AS total_bookings,
    SUM(CASE
        WHEN Booking_Status = 'Success' THEN 1
        ELSE 0
    END) AS successful_bookings,
    SUM(CASE
        WHEN Booking_Status != 'Success' THEN 1
        ELSE 0
    END) AS cancelled_bookings
FROM ola_ride_bookings_10000
GROUP BY booking_month
ORDER BY booking_month;

SELECT Booking_Date
FROM ola_ride_bookings_10000
LIMIT 10;


SELECT
    DATE_FORMAT(STR_TO_DATE(Booking_Date, '%Y-%m-%d'), '%Y-%m') AS booking_month,
    COUNT(*) AS total_bookings,
    SUM(CASE
        WHEN Booking_Status = 'Success' THEN 1
        ELSE 0
    END) AS successful_bookings,
    SUM(CASE
        WHEN Booking_Status != 'Success' THEN 1
        ELSE 0
    END) AS cancelled_bookings
FROM ola_ride_bookings_10000
GROUP BY booking_month
ORDER BY booking_month;


SELECT
    DATE_FORMAT(
        STR_TO_DATE(Booking_Date, '%Y-%m-%d'),
        '%Y-%m'
    ) AS booking_month,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN Booking_Status != 'Success' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,

    ROUND(
        SUM(
            CASE
                WHEN Booking_Status != 'Success' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate

FROM ola_ride_bookings_10000

GROUP BY booking_month

ORDER BY cancellation_rate DESC;


SELECT
    Vehicle_Type,
    COUNT(*) AS successful_rides,
    ROUND(SUM(Booking_Value), 2) AS total_revenue,

    RANK() OVER (
        ORDER BY SUM(Booking_Value) DESC
    ) AS revenue_rank

FROM ola_ride_bookings_10000

WHERE Booking_Status = 'Success'

GROUP BY Vehicle_Type;

SELECT
    Vehicle_Type,
    COUNT(*) AS successful_rides,
    ROUND(SUM(Booking_Value), 2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(Booking_Value) DESC
    ) AS revenue_rank
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type;

SELECT
    Vehicle_Type,
    COUNT(*) AS successful_rides,
    ROUND(SUM(Booking_Value), 2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(Booking_Value) DESC
    ) AS revenue_rank
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type;

SELECT
    Vehicle_Type,
    COUNT(*) AS total_rides,
    ROUND(AVG(Booking_Value), 2) AS avg_booking_value
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY avg_booking_value DESC;


SELECT
    Vehicle_Type,
    COUNT(*) AS successful_rides,
    ROUND(AVG(Customer_Rating), 2) AS avg_customer_rating
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY avg_customer_rating DESC;

SELECT
    Pickup_Location,
    COUNT(*) AS successful_rides
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Pickup_Location
ORDER BY successful_rides DESC
LIMIT 10;

SELECT
    ROUND(
        SUM(CASE WHEN Booking_Status <> 'Success' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM ola_ride_bookings_10000;



SELECT
    Cancelled_By,
    Cancellation_Reason,
    COUNT(*) AS total_cancellations
FROM ola_ride_bookings_10000
WHERE Booking_Status <> 'Success'
GROUP BY Cancelled_By, Cancellation_Reason
ORDER BY total_cancellations DESC;

SELECT
    COUNT(*) AS total_bookings,
    SUM(Booking_Status = 'Success') AS successful_bookings,
    SUM(Booking_Status <> 'Success') AS cancelled_bookings,
    ROUND(SUM(Booking_Value), 2) AS total_revenue,
    ROUND(AVG(Booking_Value), 2) AS avg_booking_value,
    ROUND(
        SUM(Booking_Status <> 'Success') * 100.0 / COUNT(*), 2
    ) AS cancellation_rate
FROM ola_ride_bookings_10000;


WITH vehicle_analysis AS (
    SELECT
        Vehicle_Type,
        COUNT(*) AS successful_rides,
        ROUND(SUM(Booking_Value), 2) AS total_revenue
    FROM ola_ride_bookings_10000
    WHERE Booking_Status = 'Success'
    GROUP BY Vehicle_Type
)
SELECT *
FROM vehicle_analysis
ORDER BY total_revenue DESC; 

SELECT
    Driver_ID,
    COUNT(*) AS successful_rides,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS ride_rank
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Driver_ID;