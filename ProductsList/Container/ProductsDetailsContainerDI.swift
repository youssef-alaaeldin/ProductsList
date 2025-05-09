//
//  ProductsDetailsContainer.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import UIKit
import Factory

extension Container {
    // MARK: - Router
    
    var productsDetailsRouter: ParameterFactory<UINavigationController, ProductsDetailsRouterProtocol> {
        ParameterFactory(self) { navController in
            ProductsDetailsRouter(navigationController: navController)
        }
    }
    
    static func productsDetailsServiceDI(navigationController: UINavigationController, product: Product) -> ProductsDetailsViewController {
        let router = self.shared.productsDetailsRouter.resolve(navigationController)
        let viewModel = ProductsDetailsViewModel(router: router, product: product)
            
        let viewController = ProductsDetailsViewController(viewModel: viewModel)
        
        return viewController
    }
}
