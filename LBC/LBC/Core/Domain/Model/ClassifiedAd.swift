//
//  ClassifiedAd.swift
//  LBC
//
//  Created by Khaled on 29/05/2024.
//

import Foundation

struct ClassifiedAd: Codable {
    let id: Int
    let title: String
    let categoryId: Int
    let creationDate: String // format: "yyyy-MM-dd'T'HH:mm:ssZ"
    let description: String
    let imagesUrl: ImagesURL?
    let isUrgent: Bool
    let price: Int
    let siret: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price, siret
        case categoryId = "category_id"
        case creationDate = "creation_date"
        case imagesUrl = "images_url"
        case isUrgent = "is_urgent"
    }
}


struct ImagesURL: Codable {
    let small: String?
    let thumb: String?
}
