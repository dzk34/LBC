//
//  ClassifiedsRequestMock.swift
//  LBCTests
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

@testable import LBC

enum ClassifiedsRequestMock: RequestProtocol {
    case fetchClassifieds

    var path: String {
        guard let path = Bundle.main.path(forResource: "listing", ofType: "json") else { return "" }
        
        return path
    }
    
    var requestType: RequestType {
        .get
    }
}
