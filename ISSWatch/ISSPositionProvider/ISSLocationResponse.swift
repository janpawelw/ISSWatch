//
//  ISSLocationResponse.swift
//  ISSWatch
//
//  Created by John Paul on 11/12/2024.
//

import Foundation

struct ISSLocationResponse: Codable {
    let issPosition: Position
    let timestamp: Double
    
    enum CodingKeys: String, CodingKey {
        case issPosition = "iss_position"
        case timestamp
    }
}
