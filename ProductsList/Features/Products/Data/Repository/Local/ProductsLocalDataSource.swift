//
//  ProductsLocalDataSource.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 10/05/2025.
//

import Foundation
import Factory


class ProductsLocalDataSource: ProductsLocalDataSourceProtocol {
    @Injected(\.coreDataStorageManager) private var coreDataStorageManager
    
    func saveProducts(_ products: [Product]) {
        coreDataStorageManager.save(ProductEntity.self, count: products.count) { entity, index in
            let product = products[index]
            entity.title = product.title
            entity.price = product.price
            entity.desc = product.description
            entity.image = product.image
            entity.rate = product.rating.rate
            entity.count = Int64(product.rating.count)
        }
    }
    
    func fetchProducts() -> [Product] {
        let entities = coreDataStorageManager.fetch(ProductEntity.self)
        return entities.map { entity in
            Product(
                title: entity.title ?? "",
                price: entity.price,
                description: entity.desc ?? "",
                image: entity.image ?? "",
                rating: Rating(rate: entity.rate, count: Int(entity.count))
            )
        }
    }
    
    func clearProducts() {
        coreDataStorageManager.clear(ProductEntity.self)
    }
}
