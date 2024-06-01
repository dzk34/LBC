//
//  RequestManager.swift
//  LBC
//
//  Created by Khaled on 29/05/2024.
//

import Foundation

protocol RequestManagerProtocol {
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

class RequestManager: RequestManagerProtocol {
    @InjectedDependency(\.apiManager) var apiManager: APIManagerProtocol
    @InjectedDependency(\.dataParser) var dataParser: DataParserProtocol
    
    func perform<T>(_ request: RequestProtocol) async throws -> T where T : Decodable {
        let data = try await apiManager.perform(request)

        let decoded: T = try dataParser.parse(data: data)

        return decoded
    }
}
