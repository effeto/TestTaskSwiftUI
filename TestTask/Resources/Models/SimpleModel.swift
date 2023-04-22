//
//  SimpleModel.swift
//  TestTask
//
//  Created by Демьян on 22.04.2023.
//

import Foundation

// MARK: - SimpleModel
struct SimpleModel: Codable {
    var vendors: [Vendor]?
}

// MARK: - Vendor
struct Vendor: Codable, Identifiable {
    let id: Int?
    let companyName, areaServed, shopType: String?
    let favorited, follow: Bool?
    let businessType: String?
    let coverPhoto: CoverPhoto?
    let categories: [Category]?
    let tags: [Tag]?

    enum CodingKeys: String, CodingKey {
        case id
        case companyName = "company_name"
        case areaServed = "area_served"
        case shopType = "shop_type"
        case favorited, follow
        case businessType = "business_type"
        case coverPhoto = "cover_photo"
        case categories, tags
    }
}

// MARK: - Category
struct Category: Codable, Identifiable, Equatable {
    
    static func == (lhs: Category, rhs: Category) -> Bool {
           return lhs.id == rhs.id
       }
    
    let id: Int?
    let name: String?
    let image: CoverPhoto?
}

// MARK: - CoverPhoto
struct CoverPhoto: Codable {
    let id: Int?
    let mediaURL: String?
    let mediaType: MediaType?

    enum CodingKeys: String, CodingKey {
        case id
        case mediaURL = "media_url"
        case mediaType = "media_type"
    }
}

enum MediaType: String, Codable {
    case image = "image"
}

// MARK: - Tag
struct Tag: Codable, Identifiable {
    let id: Int?
    let name, purpose: String?
}

