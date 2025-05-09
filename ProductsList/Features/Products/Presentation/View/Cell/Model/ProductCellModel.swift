//
//  ProductCellModel.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import Foundation

struct ProductCellModel {
    var title: String
    var image: String
    var price: String
}

extension ProductCellModel {
    static func mapProductToCellModel(_ product: Product) -> ProductCellModel {
        return ProductCellModel(
            title: product.title,
            image: product.image,
            price: "$\(product.price)"
        )
    }
}
