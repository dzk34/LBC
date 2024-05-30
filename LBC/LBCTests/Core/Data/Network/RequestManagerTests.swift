//
//  RequestManagerTests.swift
//  LBCTests
//
//  Created by Khaled on 30/05/2024.
//

import Foundation
import XCTest

@testable import LBC

class RequestManagerTests: XCTestCase {
    private var requestManager: RequestManagerMock?
    
    override func setUp() {
        super.setUp()
        requestManager = RequestManagerMock(apiManager: APIManagerMock())
    }
    
    func testRequestCategories() async throws {
        guard let categories: [LBC.Category] = try await requestManager?.perform(CategoriesRequestMock.fetchCategories)
        else {
            XCTFail("Failed to get data from the request manager")
            return
        }
        
        let first = categories.first
        let last = categories.last

        XCTAssertEqual(first?.id, 1)
        XCTAssertEqual(first?.name, "Véhicule")

        XCTAssertEqual(last?.id, 11)
        XCTAssertEqual(last?.name, "Enfants")
    }
    
    func testRequestClassifieds() async throws {
        guard let classifieds: [LBC.ClassifiedAd] = try await requestManager?.perform(ClassifiedsRequestMock.fetchClassifieds)
        else {
            XCTFail("Failed to get data from the request manager")
            return
        }

        let first = classifieds.first
        let last = classifieds.last

        XCTAssertEqual(first?.id, 1461267313)
        XCTAssertEqual(first?.categoryId, 4)
        XCTAssertEqual(first?.title, "Statue homme noir assis en plâtre polychrome")
        XCTAssertEqual(first?.description, "Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible")
        XCTAssertEqual(first?.price, 140)
        XCTAssertEqual(first?.creationDate, "2019-11-05T15:56:59+0000")
        XCTAssertEqual(first?.isUrgent, false)

        XCTAssertEqual(last?.id, 1702195622)
    }
}
