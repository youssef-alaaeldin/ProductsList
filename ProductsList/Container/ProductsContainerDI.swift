//
//  ProductsContainerDI.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import UIKit
import Factory

extension Container {
    
    // MARK: - Router
    
    
    // MARK: - Remote Data Source
    var productsRemoteDS: Factory<ProductsRemoteDataSourceProtocol> {
        Factory(self) { ProductsRemoteDataSource() }
    }
    
    // MARK: - Repository
    var productsRepository: Factory<ProductsRepositoryProtocol> {
        Factory(self) { ProductsRepository() }
    }
    
    
    // MARK: - Use Case
}
