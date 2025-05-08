//
//  ProductsRouter.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import UIKit

protocol ProductsRouterProtocol: RouterProtocol {
    func navigateToDetails()
}

class ProductsRouter: ProductsRouterProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToDetails() {
        // TODO: Navigate to product details
    }
}
