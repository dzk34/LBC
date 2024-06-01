//
//  CategoriesViewModel.swift
//  LBC
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

final class CategoriesViewModel {
    @InjectedDependency(\.categoriesService) var categoriesService: CategoriesServiceProtocol

    var categories: [Category] = []
    
    func fetchCategories() async -> [Category]{
        await categoriesService.fetchCategories()
    }
}
