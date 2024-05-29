//
//  RequestProtocol.swift
//  LBC
//
//  Created by Khaled on 29/05/2024.
//

import Foundation

enum RequestType: String {
    case get
    case post
    case put
    case patch
    case delete
}

protocol RequestProtocol {
    var path: String { get }
//    var headers: [String: String] { get }
//    var params: [String: Any] { get }
//    var urlParams: [String: String?] { get }
//    var addAuthorizationToken: Bool { get }
    var requestType: RequestType { get }
}

extension RequestProtocol {
    var host: String {
        APIConstants.host
    }
    
    var scheme: String {
        APIConstants.scheme
    }
    
    
    func createURLRequest(authToken: String) throws -> URLRequest? {
        nil
    }
}
