//
//  ApiManagerTests.swift
//  LBCTests
//
//  Created by Khaled on 01/06/2024.
//

import XCTest
@testable import LBC

final class RequestsAndResponsesTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testMakingValidRequest() throws {
        let requestData = ClassifiedsRequest.fetchClassifieds
        let request = try requestData.createURLRequest()
        XCTAssertTrue(request.url?.scheme == APIConstants.scheme)
        XCTAssertTrue(request.url?.path == requestData.path)
        XCTAssertTrue(request.url?.host == APIConstants.host)
    }

    func testMakingRequestWithInvalidUrl() throws {
        let requestData = ClassifiedsRequest.fetchCategory(id: 0)
        XCTAssertThrowsError(try requestData.createURLRequest()) { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidUrl)
        }
    }

    func testParsingResponseWithDataParser() async throws {
        let jsonData = "[{\"id\": 1,\"name\": \"Véhicule\"},{\"id\": 2,\"name\": \"Mode\"},{\"id\": 3,\"name\": \"Bricolage\"},{\"id\": 4,\"name\": \"Maison\"},{\"id\": 5,\"name\": \"Loisirs\"},{\"id\": 6,\"name\": \"Immobilier\"},{\"id\": 7,\"name\": \"Livres/CD/DVD\"},{\"id\": 8,\"name\": \"Multimédia\"},{\"id\": 9,\"name\": \"Service\"},{\"id\": 10,\"name\": \"Animaux\"},{\"id\": 11,\"name\": \"Enfants\"}]".data(using: .utf8)!
        
        let dataParser = DataParser()
        let response: [LBC.Category] = try dataParser.parse(data: jsonData)
        XCTAssertTrue(response.count == 11)
        
        let first = response.first
        XCTAssertEqual(first?.id, 1)
        XCTAssertEqual(first?.name, "Véhicule")
    }
    
    func testImageFetching() throws {
        let lbcImageView = LBCImageView()
        let imageURL = URL(string: "https://source.unsplash.com/random/320x240")!

        XCTAssertNil(lbcImageView.image)
        lbcImageView.downloadFrom(url: imageURL)
        XCTAssertNotNil(lbcImageView.image)
        XCTAssertNotEqual(lbcImageView.image, UIImage(named: Constants.noImagePlaceholder))
    }
//    func testAPIRequestMethod() async throws {
//        let requestData = ClassifiedsRequest.fetchCategories
//        let request = try requestData.createURLRequest()
//        let apiManager = APIManager(urlSession: URLSession.shared)
//        let requestManager = RequestManager()
//
//        let expectation = self.expectation(description: "Received proper response")
//        
//        let response: [LBC.Category] = try await requestManager.perform(request as! RequestProtocol)
////        waitForExpectations(timeout: 60)
//        await fulfillment(of: [expectation])
//    }
}
