//
//  ISSPositionProvider.swift
//  ISSWatch
//
//  Created by John Paul on 17/12/2024.
//

import Foundation

class ISSPositionProvider: PositionProvider {
    func fetchPosition(completion: @escaping (Position?) -> Void) {
        let urlString = "http://api.open-notify.org/iss-now.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error  fetching ISS position: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ISSLocationResponse.self, from: data)
                completion(response.issPosition)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
