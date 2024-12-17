//
//  PositionProvider.swift
//  ISSWatch
//
//  Created by John Paul on 17/12/2024.
//

import Foundation

protocol PositionProvider {
    func fetchPosition(completion: @escaping (Position?) -> Void)
}
