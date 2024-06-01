//
//  ClassifiedsViewModel.swift
//  LBC
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

final class ClassifiedsViewModel {
    @InjectedDependency(\.classifiedsService) var classifiedsService: ClassifiedsServiceProtocol

    var categories: [Category] = []

    func fetchClassifieds() async -> [ClassifiedAd]{
        await classifiedsService.fetchClassifieds()
    }
}
