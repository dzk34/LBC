//
//  APIManagerMock.swift
//  LBCTests
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

@testable import LBC

struct APIManagerMock: APIManagerProtocol {
    func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)//dzk
        return data
    }
    
    func perform(_ request: LBC.RequestProtocol) async throws -> Data {
        return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
    }
}
