//
//  Product.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import Foundation

// MARK: Domain Model

struct Product {
    let title: String
    let price: Double
    let description: String
    let image: String
    let rating: Rating
}
