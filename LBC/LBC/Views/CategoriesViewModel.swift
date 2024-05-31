//
//  CategoriesViewModel.swift
//  LBC
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

final class CategoriesViewModel: ObservableObject {
    private let categoriesService: CategoriesServiceProtocol

    @Published var categories: [Category] = []

    init(categoriesService: CategoriesServiceProtocol) {
        self.categoriesService = categoriesService
    }
    
    func fetchCategories() async -> [Category]{
        await categoriesService.fetchCategories()
    }
}
