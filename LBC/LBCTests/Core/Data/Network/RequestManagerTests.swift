//
//  RequestManagerTests.swift
//  LBCTests
//
//  Created by Khaled on 30/05/2024.
//

import Foundation
import XCTest

@testable import LBC

class RequestManagerTests: XCTestCase {
    private var requestManager: RequestManagerProtocol?
    
    override func setUp() {
        super.setUp()
        
        guard let userDefaults = UserDefaults(suiteName: #file) else { return }
        
        userDefaults.removePersistentDomain(forName: #file)
        
        requestManager = RequestManager(apiManager: APIManagerMock())
    }
    
    func testRequestCategories() async throws {
        guard let categories: [LBC.Category] = try await requestManager?.perform(CategoriesRequestMock.fetchCategories)
        else {
            XCTFail("Failed to get data from the request manager")
            return
        }
        
        let first = categories.first
        let last = categories.last

        XCTAssertEqual(first?.id, 1)
        XCTAssertEqual(first?.name, "Véhicule")

        XCTAssertEqual(last?.id, 11)
        XCTAssertEqual(last?.name, "Enfants")
    }
}
