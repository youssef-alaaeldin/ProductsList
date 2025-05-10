//
//  ProductsRouter.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import UIKit
import Factory

protocol ProductsRouterProtocol: RouterProtocol {
    func navigateToDetails(product: Product)
}

class ProductsRouter: ProductsRouterProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToDetails(product: Product) {
        let productDetailsVC = Container.productsDetailsServiceDI(navigationController: navigationController, product: product)
        navigationController.pushViewController(productDetailsVC, animated: true)

    }
}
