//
//  CategoriesRequestMock.swift
//  LBCTests
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

@testable import LBC

enum CategoriesRequestMock: RequestProtocol {
    case fetchCategories

    var path: String {
        guard let path = Bundle.main.path(forResource: "categories", ofType: "json") else { return "" }
        
        return path
    }
    
    var requestType: RequestType {
        .get
    }    
}
