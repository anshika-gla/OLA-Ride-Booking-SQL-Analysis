-- ============================================================
-- OLA RIDE BOOKING SQL ANALYSIS
-- ============================================================

-- ============================================================
-- 1. DATABASE
-- ============================================================

CREATE DATABASE IF NOT EXISTS ola_analysis;

USE ola_analysis;


-- ============================================================
-- 2. DATABASE / TABLE VERIFICATION
-- ============================================================

SHOW TABLES;

SELECT COUNT(*) AS total_records
FROM ola_ride_bookings_10000;

DESCRIBE ola_ride_bookings_10000;


-- ============================================================
-- 3. SAMPLE DATA EXPLORATION
-- ============================================================

SELECT *
FROM ola_ride_bookings_10000
LIMIT 10;


-- ============================================================
-- 4. BOOKING STATUS ANALYSIS
-- ============================================================

SELECT
    Booking_Status,
    COUNT(*) AS total_bookings
FROM ola_ride_bookings_10000
GROUP BY Booking_Status
ORDER BY total_bookings DESC;


-- ============================================================
-- 5. TOTAL BOOKINGS
-- ============================================================

SELECT
    COUNT(*) AS total_bookings
FROM ola_ride_bookings_10000;


-- ============================================================
-- 6. SUCCESSFUL RIDES
-- ============================================================

SELECT
    SUM(
        CASE
            WHEN Booking_Status = 'Success' THEN 1
            ELSE 0
        END
    ) AS successful_rides
FROM ola_ride_bookings_10000;


-- ============================================================
-- 7. CANCELLED RIDES
-- ============================================================

SELECT
    SUM(
        CASE
            WHEN Booking_Status <> 'Success' THEN 1
            ELSE 0
        END
    ) AS cancelled_rides
FROM ola_ride_bookings_10000;


-- ============================================================
-- 8. SUCCESS RATE
-- ============================================================

SELECT
    ROUND(
        SUM(
            CASE
                WHEN Booking_Status = 'Success' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS success_rate
FROM ola_ride_bookings_10000;


-- ============================================================
-- 9. CANCELLATION RATE
-- ============================================================

SELECT
    ROUND(
        SUM(
            CASE
                WHEN Booking_Status <> 'Success' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM ola_ride_bookings_10000;


-- ============================================================
-- 10. TOTAL REVENUE FROM SUCCESSFUL RIDES
-- ============================================================

SELECT
    ROUND(SUM(Booking_Value), 2) AS total_revenue
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success';


-- ============================================================
-- 11. AVERAGE REVENUE PER SUCCESSFUL RIDE
-- ============================================================

SELECT
    ROUND(AVG(Booking_Value), 2) AS avg_successful_ride_value
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success';


-- ============================================================
-- 12. VEHICLE-WISE TOTAL RIDES
-- ============================================================

SELECT
    Vehicle_Type,
    COUNT(*) AS total_rides
FROM ola_ride_bookings_10000
GROUP BY Vehicle_Type
ORDER BY total_rides DESC;


-- ============================================================
-- 13. VEHICLE-WISE SUCCESSFUL RIDES AND REVENUE
-- ============================================================

SELECT
    Vehicle_Type,
    COUNT(*) AS successful_rides,
    ROUND(SUM(Booking_Value), 2) AS total_revenue
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY total_revenue DESC;


-- ============================================================
-- 14. VEHICLE-WISE AVERAGE BOOKING VALUE
-- ============================================================

SELECT
    Vehicle_Type,
    COUNT(*) AS successful_rides,
    ROUND(AVG(Booking_Value), 2) AS avg_booking_value
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY avg_booking_value DESC;


-- ============================================================
-- 15. VEHICLE-WISE CUSTOMER RATING
-- ============================================================

SELECT
    Vehicle_Type,
    COUNT(*) AS successful_rides,
    ROUND(AVG(Customer_Rating), 2) AS avg_customer_rating
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY avg_customer_rating DESC;


-- ============================================================
-- 16. VEHICLE-WISE CANCELLATION RATE
-- ============================================================

SELECT
    Vehicle_Type,
    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN Booking_Status <> 'Success' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,

    ROUND(
        SUM(
            CASE
                WHEN Booking_Status <> 'Success' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate

FROM ola_ride_bookings_10000
GROUP BY Vehicle_Type
ORDER BY cancellation_rate DESC;


-- ============================================================
-- 17. PAYMENT METHOD ANALYSIS
-- ============================================================

SELECT
    Payment_Method,
    COUNT(*) AS transactions
FROM ola_ride_bookings_10000
GROUP BY Payment_Method
ORDER BY transactions DESC;


-- ============================================================
-- 18. PAYMENT METHOD - SUCCESSFUL RIDES AND REVENUE
-- ============================================================

SELECT
    Payment_Method,
    COUNT(*) AS successful_rides,
    ROUND(SUM(Booking_Value), 2) AS total_revenue
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Payment_Method
ORDER BY total_revenue DESC;


-- ============================================================
-- 19. CANCELLATION REASONS
-- ============================================================

SELECT
    Cancelled_By,
    Cancellation_Reason,
    COUNT(*) AS total_cancellations
FROM ola_ride_bookings_10000
WHERE Booking_Status <> 'Success'
GROUP BY Cancelled_By, Cancellation_Reason
ORDER BY total_cancellations DESC;


-- ============================================================
-- 20. TOP PICKUP LOCATIONS
-- ============================================================

SELECT
    Pickup_Location,
    COUNT(*) AS successful_rides
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Pickup_Location
ORDER BY successful_rides DESC
LIMIT 10;


-- ============================================================
-- 21. TOP PICKUP-DROP ROUTES
-- ============================================================

SELECT
    Pickup_Location,
    Drop_Location,
    COUNT(*) AS successful_rides
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Pickup_Location, Drop_Location
ORDER BY successful_rides DESC
LIMIT 10;


-- ============================================================
-- 22. TOP DRIVERS BY SUCCESSFUL RIDES
-- ============================================================

SELECT
    Driver_ID,
    COUNT(*) AS successful_rides,
    ROUND(AVG(Driver_Ratings), 2) AS avg_driver_rating
FROM ola_ride_bookings_10000
WHERE Booking_Status = 'Success'
GROUP BY Driver_ID
ORDER BY successful_rides DESC
LIMIT 10;


-- ============================================================
-- 23. TOP RATED DRIVERS
-- Minimum 10 successful rides
-- ============================================================

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


-- ============================================================
-- 24. MONTHLY BOOKING ANALYSIS
-- ============================================================

SELECT
    DATE_FORMAT(Booking_Date, '%Y-%m') AS booking_month,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN Booking_Status = 'Success' THEN 1
            ELSE 0
        END
    ) AS successful_bookings,

    SUM(
        CASE
            WHEN Booking_Status <> 'Success' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings

FROM ola_ride_bookings_10000

GROUP BY booking_month
ORDER BY booking_month;


-- ============================================================
-- 25. MONTHLY CANCELLATION RATE
-- ============================================================

SELECT
    DATE_FORMAT(Booking_Date, '%Y-%m') AS booking_month,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN Booking_Status <> 'Success' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,

    ROUND(
        SUM(
            CASE
                WHEN Booking_Status <> 'Success' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate

FROM ola_ride_bookings_10000

GROUP BY booking_month
ORDER BY cancellation_rate DESC;


-- ============================================================
-- 26. VEHICLE REVENUE RANKING
-- ============================================================

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


-- ============================================================
-- 27. DRIVER RANKING
-- ============================================================

SELECT
    Driver_ID,

    COUNT(*) AS successful_rides,

    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS ride_rank

FROM ola_ride_bookings_10000

WHERE Booking_Status = 'Success'

GROUP BY Driver_ID;


-- ============================================================
-- 28. VEHICLE ANALYSIS USING CTE
-- ============================================================

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