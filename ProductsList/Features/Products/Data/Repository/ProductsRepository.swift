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
    @Injected(\.productsLocalDS) private var productsLocalDS
    
    var productsTask: Task<Void, Never>?
    let mapper = ProductsMapper()
    
    func getProducts(productsRequest: ProductsRequest, completion: @escaping (Result<[Product], any Error>) -> Void) {
        
        productsRemoteDS.getProducts(productsRequest: productsRequest) { [weak self]  result in
            guard let self = self else { return }
            switch result {
                case .success(let productResponse):
                    let productDomain = self.mapper.dtoToDomain(productResponse)
                    self.productsLocalDS.saveProducts(productDomain)
                    completion(.success(productDomain))
                case .failure(let error):
                    let cachedProducts = self.productsLocalDS.fetchProducts()
                    if !cachedProducts.isEmpty {
                        completion(.success(cachedProducts))
                    } else {
                        completion(.failure(error))
                    }
            }
        }
    }
    
}
