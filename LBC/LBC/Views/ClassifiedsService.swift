//
//  ClassifiedsService.swift
//  LBC
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

protocol ClassifiedsServiceProtocol {
    func fetchClassifieds() async -> [ClassifiedAd]
}

struct ClassifiedsService: ClassifiedsServiceProtocol {
    private let requestManager: RequestManagerProtocol

    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension ClassifiedsService {
    func fetchClassifieds() async -> [ClassifiedAd] {
        let requestData = ClassifiedsRequest.fetchClassifieds
        
        do {
            let classifiedAd: [ClassifiedAd] = try await requestManager.perform(requestData)
            return classifiedAd
        } catch {
            print(error)
            return []
        }
    }
}
