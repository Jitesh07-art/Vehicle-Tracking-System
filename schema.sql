-- ====================================================================
-- VEHICLE TRACKING SYSTEM - DATABASE SCHEMA
-- ====================================================================
-- 
-- This SQL schema creates the necessary tables for the vehicle
-- tracking system with proper indexing and constraints.
--

-- Create the database
CREATE DATABASE IF NOT EXISTS vehicle_tracking;
USE vehicle_tracking;

-- ====================================================================
-- VEHICLES TABLE
-- ====================================================================
-- Stores information about all registered vehicles in the tracking system.

CREATE TABLE IF NOT EXISTS vehicles (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    
    -- Vehicle Information
    name VARCHAR(100) NOT NULL COMMENT 'Display name of the vehicle',
    vehicle_number VARCHAR(50) NOT NULL UNIQUE COMMENT 'Unique vehicle registration number',
    vehicle_type VARCHAR(50) COMMENT 'Type of vehicle (Sedan, SUV, Truck, etc.)',
    driver_name VARCHAR(100) COMMENT 'Name of the current driver',
    
    -- Current Status
    status VARCHAR(20) NOT NULL DEFAULT 'INACTIVE' COMMENT 'ACTIVE, INACTIVE, MAINTENANCE',
    
    -- Current Location (cached from latest location record)
    latitude DOUBLE COMMENT 'Current latitude coordinate',
    longitude DOUBLE COMMENT 'Current longitude coordinate',
    current_speed DOUBLE DEFAULT 0.0 COMMENT 'Current speed in km/h',
    
    -- Timestamps
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When vehicle was registered',
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    
    -- Indexes for frequently queried columns
    INDEX idx_vehicle_number (vehicle_number),
    INDEX idx_vehicle_status (status),
    INDEX idx_updated_at (updated_at)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Stores vehicle information and current status';

-- ====================================================================
-- LOCATIONS TABLE
-- ====================================================================
-- Stores GPS location history for all vehicles.

CREATE TABLE IF NOT EXISTS locations (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    
    -- Vehicle Reference
    vehicle_id BIGINT NOT NULL COMMENT 'Foreign key to vehicles table',
    
    -- GPS Coordinates
    latitude DOUBLE NOT NULL COMMENT 'Latitude coordinate',
    longitude DOUBLE NOT NULL COMMENT 'Longitude coordinate',
    
    -- Additional GPS Data
    speed DOUBLE COMMENT 'Speed in km/h',
    heading DOUBLE COMMENT 'Direction heading in degrees (0-360)',
    accuracy DOUBLE COMMENT 'GPS accuracy in meters',
    altitude DOUBLE COMMENT 'Altitude in meters',
    
    -- Timestamps
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When location was recorded',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When record was created',
    
    -- Foreign Key Constraint
    CONSTRAINT fk_location_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Indexes for performance
    INDEX idx_vehicle_id (vehicle_id),
    INDEX idx_timestamp (timestamp),
    INDEX idx_vehicle_timestamp (vehicle_id, timestamp),
    INDEX idx_created_at (created_at)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Stores GPS tracking history for vehicles';

-- ====================================================================
-- ER DIAGRAM (TEXT FORMAT)
-- ====================================================================
-- 
--   ┌──────────────────────────────┐
--   │       VEHICLES               │
--   ├──────────────────────────────┤
--   │ id (PK) ◄──┐                 │
--   │ name       │                 │
--   │ number     │ 1:N             │
--   │ type       │ relationship    │
--   │ driver     │                 │
--   │ status     │                 │
--   │ latitude   │                 │
--   │ longitude  │                 │
--   │ speed      │                 │
--   │ created_at │                 │
--   │ updated_at │                 │
--   └──────────────────────────────┘
--            ▲
--            │ 1
--            │
--            │ N
--            │
--   ┌──────────┴──────────────────┐
--   │      LOCATIONS               │
--   ├──────────────────────────────┤
--   │ id (PK)                      │
--   │ vehicle_id (FK) ►────────────┤
--   │ latitude                     │
--   │ longitude                    │
--   │ speed                        │
--   │ heading                      │
--   │ accuracy                     │
--   │ altitude                     │
--   │ timestamp                    │
--   │ created_at                   │
--   └──────────────────────────────┘
--
-- ====================================================================

-- ====================================================================
-- SAMPLE DATA (for testing)
-- ====================================================================

-- Insert sample vehicles
INSERT INTO vehicles (name, vehicle_number, vehicle_type, driver_name, status, latitude, longitude, current_speed)
VALUES
    ('Taxi-001', 'MH-02-AB-1234', 'Sedan', 'John Doe', 'ACTIVE', 37.7749, -122.4194, 45.5),
    ('Taxi-002', 'MH-02-AB-1235', 'Sedan', 'Jane Smith', 'INACTIVE', 37.7750, -122.4200, 0.0),
    ('Truck-001', 'MH-02-CD-5678', 'Truck', 'Mike Johnson', 'ACTIVE', 37.7745, -122.4190, 65.0)
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;

-- Insert sample locations
INSERT INTO locations (vehicle_id, latitude, longitude, speed, heading, accuracy, altitude, timestamp)
SELECT v.id, 37.7749, -122.4194, 45.5, 90, 5.0, 10.0, CURRENT_TIMESTAMP
FROM vehicles v WHERE v.vehicle_number = 'MH-02-AB-1234' LIMIT 1;

INSERT INTO locations (vehicle_id, latitude, longitude, speed, heading, accuracy, altitude, timestamp)
SELECT v.id, 37.7745, -122.4190, 65.0, 180, 5.0, 10.0, CURRENT_TIMESTAMP
FROM vehicles v WHERE v.vehicle_number = 'MH-02-CD-5678' LIMIT 1;

-- ====================================================================
-- VIEWS FOR COMMON QUERIES
-- ====================================================================

-- View for current vehicle status
CREATE OR REPLACE VIEW v_vehicle_current_status AS
SELECT 
    v.id,
    v.name,
    v.vehicle_number,
    v.vehicle_type,
    v.driver_name,
    v.status,
    v.latitude,
    v.longitude,
    v.current_speed,
    (SELECT COUNT(*) FROM locations WHERE vehicle_id = v.id) as total_locations,
    (SELECT MAX(timestamp) FROM locations WHERE vehicle_id = v.id) as last_location_time
FROM vehicles v;

-- View for vehicle location history summary
CREATE OR REPLACE VIEW v_vehicle_location_summary AS
SELECT 
    v.id,
    v.name,
    COUNT(l.id) as location_count,
    MIN(l.timestamp) as earliest_location,
    MAX(l.timestamp) as latest_location,
    AVG(l.speed) as average_speed,
    MAX(l.speed) as max_speed,
    MIN(l.speed) as min_speed
FROM vehicles v
LEFT JOIN locations l ON v.id = l.vehicle_id
GROUP BY v.id, v.name;

-- ====================================================================
-- End of Database Schema
-- ====================================================================
