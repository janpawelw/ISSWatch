//
//  Position.swift
//  ISSWatch
//
//  Created by John Paul on 11/12/2024.
//

import Foundation
import CoreLocation

struct Position: Codable {
    let longitude: String
    let latitude: String
    
    var cordinate: CLLocationCoordinate2D? {
        guard let lat = Double(latitude), let lon = Double(longitude) else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
