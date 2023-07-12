//
//  Global.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import Foundation

class Global{
    static let shared = Global()
    var transactionsArr: [Transactions] = []
    var currentUser: User? = nil
}
