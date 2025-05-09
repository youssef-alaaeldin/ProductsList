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
    
    func getProducts(productsRequest: ProductsRequest, completion: @escaping (Result<[Product], any Error>) -> Void) {
        let mapper = ProductsMapper()
        
        productsRemoteDS.getProducts(productsRequest: productsRequest) { result in
            switch result {
                case .success(let productResponse):
                    let productDomain = mapper.dtoToDomain(productResponse)
                    completion(.success(productDomain))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
