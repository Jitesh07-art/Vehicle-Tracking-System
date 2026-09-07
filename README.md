# 🚗 Vehicle Tracking & Status System

A full-stack web application designed to **track vehicles, monitor their real-time status, and manage vehicle information** through a centralized system. The application provides an interactive interface for monitoring vehicles and uses a backend API with a MySQL database for storing and managing data.

## 📌 Project Overview

The **Vehicle Tracking & Status System** is a web-based application developed for the **Transportation & Logistics** domain.

The system allows users to:

* 🚘 Register and manage vehicles
* 📍 Track vehicle locations
* 📊 Monitor vehicle status
* 🗺️ Display vehicle locations using maps
* 🔐 Manage user authentication
* 🗄️ Store vehicle and tracking information in MySQL
* 🔄 Communicate between frontend and backend using REST APIs

The project follows a **client-server architecture**, where the Vue.js frontend communicates with the Spring Boot backend through RESTful APIs.

---

## 🎯 Objectives

* Provide centralized vehicle tracking and monitoring.
* Display vehicle locations on an interactive map.
* Maintain vehicle and user information.
* Provide real-time or updated vehicle status.
* Reduce manual vehicle monitoring.
* Provide a scalable architecture for future fleet-management features.

---

## 🛠️ Technology Stack

### Frontend

* Vue.js
* HTML5
* CSS3
* JavaScript
* REST API integration

### Backend

* Java
* Spring Boot
* Spring Web
* RESTful APIs

### Database

* MySQL
* MySQL Workbench

### Other Technologies

* Maps / Location API
* Git
* GitHub

---

## 🏗️ System Architecture

```text
                    ┌─────────────────────┐
                    │       User          │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │    Vue.js Frontend  │
                    │                     │
                    │  Dashboard          │
                    │  Vehicle Management │
                    │  Tracking Map       │
                    └──────────┬──────────┘
                               │
                         REST APIs
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Spring Boot API   │
                    │                     │
                    │ Controllers         │
                    │ Services            │
                    │ Business Logic      │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │       MySQL         │
                    │                     │
                    │ Users               │
                    │ Vehicles            │
                    │ Tracking Data       │
                    └─────────────────────┘
```

---

## ✨ Features

### 👤 User Management

* User registration
* User login
* Authentication
* User-specific access

### 🚗 Vehicle Management

* Add vehicles
* Update vehicle information
* Delete vehicles
* View registered vehicles

### 📍 Vehicle Tracking

* Display vehicle location
* Map-based tracking
* Track vehicle movement/status
* Location information management

### 📊 Dashboard

* Vehicle overview
* Vehicle status
* Tracking information
* Centralized monitoring

### 🗄️ Database Management

The application stores information such as:

* User details
* Vehicle details
* Vehicle status
* Location information
* Tracking records

---

## 📂 Project Structure

```text
vehicle-tracking-status-system/
│
├── frontend/
│   ├── src/
│   ├── public/
│   ├── package.json
│   └── ...
│
├── backend/
│   ├── src/
│   │   ├── main/
│   │   └── test/
│   ├── pom.xml
│   └── ...
│
├── database/
│   └── database.sql
│
├── docs/
│   ├── architecture.png
│   ├── er-diagram.png
│   ├── uml-diagram.png
│   └── screenshots/
│
├── .gitignore
└── README.md
```

---

## ⚙️ Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/vehicle-tracking-status-system.git
```

```bash
cd vehicle-tracking-status-system
```

---

## 🗄️ Database Setup

1. Install **MySQL**.
2. Open MySQL Workbench.
3. Create a database:

```sql
CREATE DATABASE vehicle_tracking;
```

4. Import the SQL file:

```text
database/database.sql
```

5. Configure the database credentials in the Spring Boot application.

Example:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/vehicle_tracking
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

> Do not upload your real database password to GitHub.

---

## ▶️ Running the Backend

Navigate to the backend directory:

```bash
cd backend
```

Run the Spring Boot application:

```bash
mvn spring-boot:run
```

The backend will normally run at:

```text
http://localhost:8080
```

---

## ▶️ Running the Frontend

Open another terminal:

```bash
cd frontend
```

Install dependencies:

```bash
npm install
```

Start the Vue.js application:

```bash
npm run dev
```

The frontend will normally be available at the URL shown by Vite.

---

## 🔌 REST API

Example API endpoints:

| Method | Endpoint                    | Description              |
| ------ | --------------------------- | ------------------------ |
| GET    | `/api/vehicles`             | Get all vehicles         |
| GET    | `/api/vehicles/{id}`        | Get vehicle by ID        |
| POST   | `/api/vehicles`             | Add a vehicle            |
| PUT    | `/api/vehicles/{id}`        | Update vehicle           |
| DELETE | `/api/vehicles/{id}`        | Delete vehicle           |
| GET    | `/api/tracking/{vehicleId}` | Get tracking information |

> Update these endpoints according to the actual APIs implemented in your project.

---

## 🗺️ Map Integration

The application integrates map functionality to visualize vehicle locations.

The map can be used to:

* Display vehicle positions
* View vehicle movement
* Identify vehicle locations
* Monitor multiple vehicles

---

## 🔮 Future Enhancements

The system can be extended with:

* 🤖 AI-based vehicle anomaly detection
* 📈 Predictive maintenance
* 🚦 Traffic-aware route optimization
* 🔔 Real-time notifications
* 📱 Mobile application
* 📍 GPS/IoT device integration
* 📊 Advanced analytics dashboard
* ☁️ AWS cloud deployment
* 🔐 Role-based access control
* 🧠 AI-powered route and vehicle analysis

---

## 🧪 Testing

The backend APIs can be tested using tools such as:

* Postman
* Browser
* MySQL Workbench

Frontend functionality can be tested through the Vue.js application.

---

## 📸 Screenshots

Add screenshots of your application here.

Example:

```markdown
## 📸 Screenshots

### Dashboard
![Dashboard](docs/screenshots/dashboard.png)

### Vehicle Tracking
![Vehicle Tracking](docs/screenshots/tracking.png)

### Vehicle Management
![Vehicle Management](docs/screenshots/vehicles.png)
```

---

## 🎓 Academic Project

**Project:** Vehicle Tracking & Status System
**Domain:** Transportation & Logistics
**Type:** Full-Stack Web Application

### Technologies

```text
Vue.js + Java + Spring Boot + MySQL + Maps API
```

---

## 👨‍💻 Author

**Jitesh Sitaram Gaikwad**

Computer Science Engineering
SGGSIE&T, Vishnupuri, Nanded

---

## 📄 License

This project is developed for **educational and academic purposes**.
