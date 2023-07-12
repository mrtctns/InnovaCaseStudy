//
//  NetworkManager.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    /// Decodable
    func readJSONData<T: Decodable>(fileName: String, objectType: T.Type) throws -> T {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "JSON file cannot be found", code: 0)
        }

        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormatter)
            let object = try decoder.decode(objectType, from: jsonData)
            return object
        } catch {
            throw error
        }
    }
}
