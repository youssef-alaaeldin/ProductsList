//
//  ProductsDetailsRouter.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import UIKit

protocol ProductsDetailsRouterProtocol: RouterProtocol {
    func navigate()
}

class ProductsDetailsRouter: ProductsDetailsRouterProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate() {
        
    }
}
