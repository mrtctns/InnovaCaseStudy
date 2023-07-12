//
//  DateFormatter+Extension.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import Foundation

extension DateFormatter {
    static let customFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
}
