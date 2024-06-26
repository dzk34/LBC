//
//  LBCImageView.swift
//  LBC
//
//  Created by Khaled on 31/05/2024.
//

import UIKit

class LBCImageView: UIImageView {
    @InjectedDependency(\.apiManager) var apiManager: APIManagerProtocol
    
    func downloadFrom(url: URL) {
        Task {
            do {
                let data = try await apiManager.downloadImageData(from: url)
                image = UIImage(data: data)
            } catch {
                image = UIImage(named: Constants.noImagePlaceholder)
            }
        }
    }
}
