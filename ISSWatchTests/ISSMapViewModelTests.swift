//
//  ISSMapViewModelTests.swift
//  ISSWatchTests
//
//  Created by John Paul on 17/12/2024.
//

import XCTest

final class ISSMapViewModelTests: XCTestCase {
    var viewModel: ISSMapViewModel!
    var mockPositionProvider: MockPositionProvider!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockPositionProvider = MockPositionProvider()
        viewModel = ISSMapViewModel(positionProvider: mockPositionProvider, timeInterval: 1.0)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockPositionProvider = nil
        try super.tearDownWithError()
    }
    
    func testInitialCoordinate() {
        XCTAssertEqual(viewModel.coordinates.latitude, 0.0)
        XCTAssertEqual(viewModel.coordinates.longitude, 0.0)
    }
    
    func testFetchPosition() {
        let expectation = self.expectation(description: "Fetch position expectation")
        let expectedLatitude = 40.68919
        let expectedLongitude = -74.04466
        mockPositionProvider.mockPosition = Position(longitude: "\(expectedLongitude)", latitude: "\(expectedLatitude)")
        viewModel.startFetchingISSPosition()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            XCTAssertEqual(self.viewModel.coordinates.latitude, expectedLatitude)
            XCTAssertEqual(self.viewModel.coordinates.longitude, expectedLongitude)
            XCTAssertEqual(self.viewModel.region.center.latitude, expectedLatitude)
            XCTAssertEqual(self.viewModel.region.center.longitude, expectedLongitude)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4.0, handler: { error in
            self.viewModel.stopFetchingISSPosition()
        })
    }

}
