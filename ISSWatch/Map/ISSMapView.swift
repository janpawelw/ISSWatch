//
//  ISSMapView.swift
//  ISSWatch
//
//  Created by John Paul on 11/12/2024.
//

import SwiftUI
import MapKit

struct ISSMapView: View {
    
    @StateObject private var viewModel = ISSMapViewModel(positionProvider: ISSPositionProvider())
    
    var body: some View {
        MapView(region: $viewModel.region)
            .edgesIgnoringSafeArea(.all)
    }
}

fileprivate struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if mapView.annotations.count == 0 {
            let annotation = ISSAnnotation(coordinate: region.center, title:NSLocalizedString("iss_annotation_title", comment: ""))
            mapView.addAnnotation(annotation)
        } else {
            if let annotation = mapView.annotations.first as? ISSAnnotation {
                animateAnnotation(annotation, to: region.center, mapView: mapView)
            }
        }
    }
    
    func animateAnnotation(_ annotation: ISSAnnotation, to coordinate: CLLocationCoordinate2D, mapView: MKMapView) {
        UIView.animate(withDuration: 1.0) {
            annotation.willChangeValue(forKey: "coordinate")
            annotation.coordinate = region.center
            annotation.didChangeValue(forKey: "coordinate")
            mapView.setCenter(region.center, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        private let issPinIdentifier = "iss_pin"
        private var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = issPinIdentifier
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = ISSAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
            for annotationView in views {
                if let annotation = annotationView.annotation as? ISSAnnotation {
                    mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }
    
}

/*
struct ISSMapView_Previews: PreviewProvider {
    static var previews: some View {
        ISSMapView()
    }
}*/
