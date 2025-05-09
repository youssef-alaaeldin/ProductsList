//
//  ProductsDetailsViewModel.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import Foundation

class ProductsDetailsViewModel: BaseVM {
    
    var product: Product
    var router: ProductsDetailsRouterProtocol
    
    init(router: ProductsDetailsRouterProtocol, product: Product) {
        self.product = product
        self.router = router
    }
}
