//
//  GetProductsUseCase.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation
import Factory

class GetProductsUseCase: GetProductsUseCaseProtocol {
    @Injected(\.productsRepository) private var productsRepository
    
    func execute(productsRequest: ProductsRequest, completion: @escaping (Result<[Product], any Error>) -> Void) {
        productsRepository.getProducts(productsRequest: productsRequest) { result in
            switch result {
                case .success(let products):
                    completion(.success(products))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
