//
//  GetProductsUseCaseProtocol.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation

protocol GetProductsUseCaseProtocol {
    func execute(productsRequest: ProductsRequest, completion: @escaping (Result<Products, Error>) -> Void)
}
