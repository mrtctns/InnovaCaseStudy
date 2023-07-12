//
//  Currency.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import Foundation

struct Currency: Codable {
    let currency: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case currency
        case country
    }
}
