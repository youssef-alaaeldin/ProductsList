//
//  ProductsMapper.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import Foundation

struct ProductsMapper: RemoteMapperProtocol {
    
    func dtoToDomain(_ model: ProductResponse) -> Product {
        return Product(
            title: model.title,
            price: model.price,
            image: model.image
        )
    }
}
