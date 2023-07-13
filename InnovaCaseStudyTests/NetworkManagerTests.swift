//
//  InnovaCaseStudyTests.swift
//  InnovaCaseStudyTests
//
//  Created by Mert Çetin on 12.07.2023.
//

@testable import InnovaCaseStudy
import XCTest
import Firebase

class NetworkManagerTests: XCTestCase {

    func testFetchCurrencyData() {
        FirebaseApp.configure()
        let networkManager = NetworkManager.shared
        let expectation = XCTestExpectation(description: "Currency data fetched successfully")

        
        networkManager.fetchCurrencyData { result in
            
            switch result {
            case .success(let currencies):
                XCTAssertFalse(currencies.isEmpty, "Fetched currency array is empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch currency data: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
