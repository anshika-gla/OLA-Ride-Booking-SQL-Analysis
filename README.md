# 🚕 OLA Ride Booking SQL Analysis

A full-stack data analytics project that analyzes **10,000 OLA ride booking records** using MySQL and presents key business insights through an interactive React dashboard.

The project combines **SQL data analysis, Node.js/Express backend, MySQL database, and React/Vite frontend** to provide a visual overview of ride bookings, success rates, cancellations, revenue, and vehicle performance.

---

## 🌐 Live Demo

### 📊 Dashboard
https://ola-ride-booking-sql-analysis-1.onrender.com

### 🔗 Backend API
https://ola-ride-booking-sql-analysis-production.up.railway.app

---

## 📌 Project Overview

The objective of this project is to analyze OLA ride booking data and identify useful business insights such as:

- Total number of bookings
- Successful and cancelled rides
- Cancellation rate
- Success rate
- Revenue generated
- Average revenue per successful ride
- Vehicle-wise performance
- Payment method usage
- Pickup location analysis
- Cancellation reasons
- Monthly cancellation trends

The analyzed data is displayed through an interactive analytics dashboard.

---

## 📊 Key Business Insights

Based on the analyzed **10,000 booking records**:

| Metric | Value |
|---|---:|
| Total Bookings | 10,000 |
| Successful Rides | 7,815 |
| Cancelled Rides | 2,185 |
| Success Rate | 78.15% |
| Cancellation Rate | 21.85% |
| Total Revenue | ₹19.06 Lakhs |
| Average Revenue per Successful Ride | ₹243.87 |
| Highest Revenue Vehicle | Mini |
| Highest Successful Rides | Mini |
| Most Used Payment Method | UPI |
| Top Pickup Location | Gurgaon |
| Highest Cancellation Reason | System – No driver available |
| Highest Monthly Cancellation Rate | February 2025 – 24.29% |

---

## 🛠️ Technologies Used

### Frontend
- React.js
- Vite
- JavaScript
- HTML5
- CSS3
- Recharts
- Lucide React

### Backend
- Node.js
- Express.js
- CORS
- dotenv

### Database
- MySQL

### Deployment
- Render – Frontend
- Railway – Backend
- Railway MySQL – Database

### Development Tools
- Git
- GitHub
- VS Code
- MySQL Workbench
- Postman

---

## 🏗️ Project Architecture

```text
                    ┌─────────────────────┐
                    │    React Frontend   │
                    │       (Render)      │
                    └──────────┬──────────┘
                               │
                               │ REST API
                               ▼
                    ┌─────────────────────┐
                    │ Node.js + Express   │
                    │      (Railway)      │
                    └──────────┬──────────┘
                               │
                               │ SQL Queries
                               ▼
                    ┌─────────────────────┐
                    │    MySQL Database   │
                    │      (Railway)      │
                    └─────────────────────┘
