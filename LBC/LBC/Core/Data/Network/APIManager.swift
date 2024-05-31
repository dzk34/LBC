//
//  APIManager.swift
//  LBC
//
//  Created by Khaled on 29/05/2024.
//

import Foundation

protocol APIManagerProtocol {
    func perform(_ request: RequestProtocol) async throws -> Data
    func downloadImageData(from url: URL) async throws -> Data
}

class APIManager: APIManagerProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform(_ request: RequestProtocol) async throws -> Data {
        print("calling url \(request.host) \(request.path)")
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else { throw NetworkError.invalidServerResponse }
        
        return data
    }
    
    func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await urlSession.data(for: request)
        return data
    }
}
