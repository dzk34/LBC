//
//  RequestManager.swift
//  LBC
//
//  Created by Khaled on 29/05/2024.
//

import Foundation

protocol RequestManagerProtocol {
    var apiManager: APIManagerProtocol { get }
    var dataParser: DataParserProtocol { get }
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

class RequestManager: RequestManagerProtocol {
    let dataParser: DataParserProtocol
    let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol, dataParser: DataParserProtocol) {
        self.apiManager = apiManager
        self.dataParser = dataParser
    }
    
    func perform<T>(_ request: RequestProtocol) async throws -> T where T : Decodable {
        let data = try await apiManager.perform(request)

        let decoded: T = try dataParser.parse(data: data)

        return decoded
    }
}
