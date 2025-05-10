//
//  ProductsLocalDataSourceProtocol.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 10/05/2025.
//

import Foundation
import Factory

protocol ProductsLocalDataSourceProtocol {
    func saveProducts(_ products: [Product])
    func fetchProducts() -> [Product]
    func clearProducts()
}
