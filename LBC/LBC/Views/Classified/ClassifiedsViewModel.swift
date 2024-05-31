//
//  ClassifiedsViewModel.swift
//  LBC
//
//  Created by Khaled on 30/05/2024.
//

import Foundation

final class ClassifiedsViewModel: ObservableObject {
    private let classifiedsService: ClassifiedsServiceProtocol

    @Published var categories: [Category] = []

    init(classifiedsService: ClassifiedsServiceProtocol) {
        self.classifiedsService = classifiedsService
    }
    
    func fetchClassifieds() async -> [ClassifiedAd]{
        await classifiedsService.fetchClassifieds()
    }
}
