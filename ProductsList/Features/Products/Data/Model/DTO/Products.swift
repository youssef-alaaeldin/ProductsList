//
//  Products.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

typealias Products = [Product]
