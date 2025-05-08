//
//  ProductsRepository.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation
import Factory

class ProductsRepository: ProductsRepositoryProtocol {
    @Injected(\.productsRemoteDS) private var productsRemoteDS
    
    var productsTask: Task<Void, Never>?
    
    func getProducts(productsRequest: ProductsRequest, completion: @escaping (Result<Products, any Error>) -> Void) {
        productsRemoteDS.getProducts(productsRequest: productsRequest) { result in
            switch result {
                case .success(let products):
                    completion(.success(products))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
