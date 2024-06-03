//
//  RequestManagerMock.swift
//  LBCTests
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

@testable import LBC

class RequestManagerMock: RequestManagerProtocol {
    var dataParser: DataParserProtocol
    let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol, dataParser: DataParserProtocol) {
        self.apiManager = apiManager
        self.dataParser = dataParser
    }

    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        let data = try await apiManager.perform(request)
        let decoded: T = try dataParser.parse(data: data)
        return decoded
    }
}
