//
//  ServiceContainer.swift
//  LBC
//
//  Created by Khaled on 01/06/2024.
//

import Foundation


// MARK: Injected Services
private struct APIManagerKey: InjectedServiceKey {
    static var currentValue: APIManagerProtocol = APIManager()
}

private struct RequestManagerKey: InjectedServiceKey {
    static var currentValue: RequestManagerProtocol = RequestManager()
}

private struct DataParserKey: InjectedServiceKey {
    static var currentValue: DataParserProtocol = DataParser()
}

private struct CategoriesServiceKey: InjectedServiceKey {
    static var currentValue: CategoriesServiceProtocol = CategoriesService()
}

private struct ClassifiedsServiceKey: InjectedServiceKey {
    static var currentValue: ClassifiedsServiceProtocol = ClassifiedsService()
}

private struct ClassifiedsViewModelKey: InjectedServiceKey {
    static var currentValue: ClassifiedsViewModel = ClassifiedsViewModel()
}

private struct CategoriesViewModelKey: InjectedServiceKey {
    static var currentValue: CategoriesViewModel = CategoriesViewModel()
}

extension InjectedServiceValues {
    var apiManager: APIManagerProtocol {
        get { Self[APIManagerKey.self] }
        set { Self[APIManagerKey.self] = newValue }
    }
    
    var dataParser: DataParserProtocol {
        get { Self[DataParserKey.self] }
        set { Self[DataParserKey.self] = newValue }
    }
    
    var requestManager: RequestManagerProtocol {
        get { Self[RequestManagerKey.self] }
        set { Self[RequestManagerKey.self] = newValue }
    }
    
    var categoriesService: CategoriesServiceProtocol {
        get { Self[CategoriesServiceKey.self] }
        set { Self[CategoriesServiceKey.self] = newValue }
    }
    
    var classifiedsService: ClassifiedsServiceProtocol {
        get { Self[ClassifiedsServiceKey.self] }
        set { Self[ClassifiedsServiceKey.self] = newValue }
    }
    
    var classifiedsViewModel: ClassifiedsViewModel {
        get { Self[ClassifiedsViewModelKey.self] }
        set { Self[ClassifiedsViewModelKey.self] = newValue }
    }
    
    var categoriesViewModel: CategoriesViewModel {
        get { Self[CategoriesViewModelKey.self] }
        set { Self[CategoriesViewModelKey.self] = newValue }
    }
}
