//
//  URLProtocolStub.swift
//  LBC
//
//  Created by Khaled on 01/06/2024.
//
/*
import Foundation

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    public override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        returnMockResponse()
    }
    
    override func stopLoading() {}
    
    func returnMockResponse() {
        guard let handler = URLProtocolMock.requestHandler else { return }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    func setURLProtocolMock() {
        URLProtocolMock.requestHandler = { request in
            let exampleData =
            """
            {
            "base": "USD"
            }
            """
                .data(using: .utf8)
            
            let response = HTTPURLResponse.init(url: request.url, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return(response, exampleData)
        }
    }
}

struct Object: Codable {
    let base: String
}

*/
