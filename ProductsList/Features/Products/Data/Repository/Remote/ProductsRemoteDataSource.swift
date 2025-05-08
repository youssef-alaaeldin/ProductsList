//
//  ProductsRemoteDataSource.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation
import Factory

class ProductsRemoteDataSource: ProductsRemoteDataSourceProtocol {
    @Injected(\.networkProvider) private var networkProvider
    
    var productsTask: Task<Void, Never>?
    
    func getProducts(productsRequest: ProductsRequest, completion: @escaping (Result<Products, any Error>) -> Void) {
        productsTask = Task {
            do {
                let result = try await networkProvider.get(endpoint: productsRequest, responseType: Products.self)
                
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func cancelOnGoingTasks() {
        productsTask?.cancel()
    }
}
