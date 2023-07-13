//
//  Bundle+Extension.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import Foundation

extension Bundle {
    func readLocalJson<T: Codable>(fileName: String, objectType: T.Type) throws -> T? {
        guard let fileURL = url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "JSON file cannot be found", code: 0)
        }

        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()

        do {
            let object = try decoder.decode(objectType, from: data)
            return object
        } catch {
            throw NSError(domain: "JSON Cannot parse: \(error.localizedDescription)", code: 0)
        }
    }
}
