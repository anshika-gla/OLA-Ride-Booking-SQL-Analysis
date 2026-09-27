const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");
require("dotenv").config();

const app = express();

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

db.connect((err) => {
    if (err) {
        console.error("❌ MySQL connection failed:", err.message);
        return;
    }

    console.log("✅ MySQL Connected Successfully");
});

app.get("/", (req, res) => {
    res.json({
        message: "OLA Ride Booking API is running 🚕"
    });
});

app.get("/api/summary", (req, res) => {
    const query = `
        SELECT
            COUNT(*) AS total_bookings,
            SUM(CASE
                WHEN Booking_Status = 'Success' THEN 1
                ELSE 0
            END) AS successful_rides,
            SUM(CASE
                WHEN Booking_Status <> 'Success' THEN 1
                ELSE 0
            END) AS cancelled_rides,
            ROUND(
                SUM(CASE
                    WHEN Booking_Status <> 'Success' THEN 1
                    ELSE 0
                END) * 100 / COUNT(*),
                2
            ) AS cancellation_rate
        FROM ola_ride_bookings_10000;
    `;

    db.query(query, (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({
                error: "Database query failed"
            });
        }

        res.json(result[0]);
    });
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, "0.0.0.0", () => {
    console.log(`🚀 Server running on port ${PORT}`);
});