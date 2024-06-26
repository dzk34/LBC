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
    var requestType: RequestType { get }
}

extension RequestProtocol {
    var host: String {
        APIConstants.host
    }
    
    var scheme: String {
        APIConstants.scheme
    }
    
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

          guard let url = components.url
          else { throw NetworkError.invalidUrl }

          var urlRequest = URLRequest(url: url)
          urlRequest.httpMethod = requestType.rawValue


        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return urlRequest
    }
}
