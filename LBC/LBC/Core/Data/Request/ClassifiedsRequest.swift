//
//  ClassifiedsRequest.swift
//  LBC
//
//  Created by Khaled on 29/05/2024.
//

import Foundation

enum ClassifiedsRequest: RequestProtocol {
    case fetchCategories
    case fetchCategory(id: Int)
    case fetchClassifieds
    case fetchClassified(id: Int)
    
    var path: String {
        switch self {
        case .fetchCategories:
            return "/leboncoin/paperclip/master/categories.json"
        case .fetchCategory(id: let id):
            return "Url to fetch a Category using id"
        case .fetchClassifieds:
            return "leboncoin/paperclip/master/listing.json"
        case .fetchClassified(id: let id):
            return "Url to fetch a listing using id"
        }
    }
    
    var requestType: RequestType {
        .get
    }
}
