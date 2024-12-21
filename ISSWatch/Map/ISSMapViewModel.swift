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
    private static let regionSpan = 1.0
    
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
        positionProvider.fetchPosition { position in
            guard let coordinate = position?.cordinate else { return }
            DispatchQueue.main.async { [weak self] in
                self?.coordinates = coordinate
                self?.region = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: ISSMapViewModel.regionSpan, longitudeDelta: ISSMapViewModel.regionSpan)
                )
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
}
