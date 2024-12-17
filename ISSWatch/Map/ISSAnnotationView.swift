//
//  ISSAnnotationView.swift
//  ISSWatch
//
//  Created by John Paul on 17/12/2024.
//

import Foundation
import MapKit

class ISSAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let annotation = newValue as? ISSAnnotation else { return }
            image = UIImage(named: AssetsInfo.IC_ISS_MAP_ANNOTATION)
            canShowCallout = true
            if let mapView = superview as? MKMapView {
                mapView.selectAnnotation(annotation, animated: true)
            }
        }
    }
}
