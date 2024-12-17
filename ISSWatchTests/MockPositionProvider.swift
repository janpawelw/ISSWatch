//
//  MockPositionProvider.swift
//  ISSWatchTests
//
//  Created by John Paul on 17/12/2024.
//

import Foundation

class MockPositionProvider: PositionProvider {
    var mockPosition: Position?
    
    func fetchPosition(completion: @escaping (Position?) -> Void) {
        completion(mockPosition)
    }
}
