//
//  PinLocation.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/29/23.
//

import Foundation
import CoreLocation

struct PinLocation: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
