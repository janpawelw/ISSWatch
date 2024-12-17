//
//  ISSAnnotation.swift
//  ISSWatch
//
//  Created by John Paul on 17/12/2024.
//

import Foundation
import MapKit

class ISSAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil) {
        self.coordinate = coordinate
        self.title = title
    }
}
