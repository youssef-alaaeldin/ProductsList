//
//  MockProductsRepository.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 10/05/2025.
//
import Foundation

class MockProductsRepository: ProductsRepositoryProtocol {
    
    var shouldReturnError: Bool = false
    var errorToReturn: NSError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load products. No cached data available."])

    var mockProducts: [Product] = [
        Product(
            title: "Mock Product",
            price: 99.99,
            description: "A mocked product",
            image: "https://image.url",
            rating: Rating(rate: 4.5, count: 50)
        )
    ]

    var isFromCache: Bool = false

    func getProducts(productsRequest: ProductsRequest, completion: @escaping (Result<([Product], Bool), any Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(errorToReturn))
            return
        }
        completion(.success((mockProducts, isFromCache)))
    }
}
