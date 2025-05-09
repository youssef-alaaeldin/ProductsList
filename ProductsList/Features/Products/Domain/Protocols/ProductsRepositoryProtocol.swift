//
//  ProductsRepositoryProtocol.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation

protocol ProductsRepositoryProtocol {
    func getProducts(productsRequest: ProductsRequest, completion: @escaping (Result<[Product], Error>) -> Void)
}
