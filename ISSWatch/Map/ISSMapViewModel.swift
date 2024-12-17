//
//  ISSMapViewModel.swift
//  ISSWatch
//
//  Created by John Paul on 11/12/2024.
//

import Foundation
import MapKit

class ISSMapViewModel: ObservableObject {
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude:  0.0),
        span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
    )
    @Published var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    private let timeInterval: TimeInterval
    private var timer: Timer?
    private let positionProvider: PositionProvider
    private let regionSpan = 1.0
    
    init(positionProvider: PositionProvider, timeInterval: TimeInterval = 2.0) {
        self.positionProvider = positionProvider
        self.timeInterval = timeInterval
        startFetchingISSPosition()
    }
    
    func startFetchingISSPosition() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in
            self.fetchAndUpdatePosition()
        })
    }
    
    func stopFetchingISSPosition() {
        timer?.invalidate()
    }
    
    private func fetchAndUpdatePosition() {
        self.positionProvider.fetchPosition { position in
            DispatchQueue.main.async {
                self.coordinates = position?.cordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
                self.region = MKCoordinateRegion(
                    center: self.coordinates,
                    span: MKCoordinateSpan(latitudeDelta: self.regionSpan, longitudeDelta: self.regionSpan)
                )
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
}
