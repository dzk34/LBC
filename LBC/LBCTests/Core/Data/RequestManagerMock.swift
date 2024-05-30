//
//  RequestManagerMock.swift
//  LBCTests
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

@testable import LBC

class RequestManagerMock: RequestManagerProtocol {
    let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol) {
      self.apiManager = apiManager
    }

    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        let data = try await apiManager.perform(request)
        let decoded: T = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
