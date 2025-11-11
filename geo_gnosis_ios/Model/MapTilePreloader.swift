//
//  MapTilePreloader.swift
//  geo_gnosis_ios
//
//  Created for async map tile preloading
//

import Foundation
import MapKit
import SwiftUI
import os.log

// Preloads MapKit satellite tiles in the background to improve first-load performance
@MainActor
class MapTilePreloader: ObservableObject {

    private var preloadMapView: MKMapView?
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "geo_gnosis_ios", category: "MapTilePreloader")

    // Representative coordinates spread across the globe for cache warming
    private let preloadLocations: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),   // New York
        CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278),    // London
        CLLocationCoordinate2D(latitude: 35.6762, longitude: 139.6503),   // Tokyo
        CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093),  // Sydney
        CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332)    // Mexico City
    ]

    // Starts preloading satellite tiles if satellite mode is enabled
    // - Parameter sateliteMapOn: Whether satellite mode is currently enabled
    func startPreloading(sateliteMapOn: Bool) {
        guard sateliteMapOn else {
            logger.info("Skipping tile preload - satellite mode disabled")
            return
        }

        logger.info("Starting background tile preload...")

        // Delay to avoid interfering with initial UI load
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
            await performPreload()
        }
    }

    // Performs the actual tile preloading
    private func performPreload() async {
        // Create a minimal hidden map view
        preloadMapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))

        guard let mapView = preloadMapView else {
            logger.error("Failed to create preload map view")
            return
        }

        // Configure for satellite imagery
        if #available(iOS 17.0, *) {
            mapView.preferredConfiguration = MKImageryMapConfiguration()
        } else {
            mapView.mapType = .satellite
        }

        logger.info("Preloading tiles for \(self.preloadLocations.count) locations")

        // Load tiles for each location
        for (index, coordinate) in preloadLocations.enumerated() {
            await preloadLocation(coordinate: coordinate, mapView: mapView, index: index + 1)

            // Small delay between locations to avoid overwhelming the network
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        }

        logger.info("Tile preload complete")
        cleanup()
    }

    /// Preloads tiles for a specific coordinate
    private func preloadLocation(coordinate: CLLocationCoordinate2D, mapView: MKMapView, index: Int) async {
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )

        mapView.setRegion(region, animated: false)

        // Give MapKit time to request and cache tiles
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second

        logger.debug("Preloaded location \(index)/\(self.preloadLocations.count)")
    }

    // Cleans up resources after preloading
    private func cleanup() {
        preloadMapView?.removeFromSuperview()
        preloadMapView = nil
        logger.debug("Preloader cleanup complete")
    }
}
