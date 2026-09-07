package com.tracking.vehicle;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Main entry point for the Vehicle Tracking System application.
 * This Spring Boot application provides real-time vehicle tracking capabilities
 * using WebSocket for live updates and MySQL for persistent storage.
 *
 * Features:
 * - RESTful APIs for vehicle and location management
 * - Real-time GPS updates via WebSocket
 * - Historical location tracking
 * - Multi-vehicle support
 */
@SpringBootApplication
@EnableScheduling
public class VehicleTrackingApplication {

    public static void main(String[] args) {
        SpringApplication.run(VehicleTrackingApplication.class, args);
        System.out.println("\n✓ Vehicle Tracking System started successfully!");
        System.out.println("✓ Access the application at: http://localhost:8080");
        System.out.println("✓ API Documentation available at: http://localhost:8080/swagger-ui.html\n");
    }
}
