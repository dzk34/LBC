//
//  CategoriesService.swift
//  LBC
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

protocol CategoriesServiceProtocol {
    func fetchCategories() async -> [Category]
}

struct CategoriesService: CategoriesServiceProtocol {
    private let requestManager: RequestManagerProtocol

    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension CategoriesService {
    func fetchCategories() async -> [Category] {
        let requestData = ClassifiedsRequest.fetchCategories
        
        do {
            let categoriesList: [Category] = try await requestManager.perform(requestData)
            return categoriesList
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
