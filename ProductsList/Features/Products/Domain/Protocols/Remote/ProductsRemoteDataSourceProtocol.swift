//
//  ProductsRemoteDataSourceProtocol.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation

protocol ProductsRemoteDataSourceProtocol {
    func getProducts(productsRequest: ProductsRequest, completion: @escaping (Result<[ProductResponse], Error>) -> Void)
}
