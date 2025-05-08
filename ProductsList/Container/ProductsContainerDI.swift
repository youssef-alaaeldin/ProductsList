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
    
    var productsRouter: ParameterFactory<UINavigationController, ProductsRouterProtocol> {
        ParameterFactory(self) { navController in
            ProductsRouter(navigationController: navController)
        }
    }
    
    static func productsServiceDI(navigationController: UINavigationController) -> ProductsViewController {
        let router = self.shared.productsRouter.resolve(navigationController)
        let viewModel = ProductsViewModel(router: router)
        
        let viewController = ProductsViewController(viewModel: viewModel)
        
        return viewController
    }
    
    // MARK: - Remote Data Source
    
    var productsRemoteDS: Factory<ProductsRemoteDataSourceProtocol> {
        Factory(self) { ProductsRemoteDataSource() }
    }
    
    // MARK: - Repository
    
    var productsRepository: Factory<ProductsRepositoryProtocol> {
        Factory(self) { ProductsRepository() }
    }
    
    
    // MARK: - Use Case
    
    var getProductsUseCase: Factory<GetProductsUseCaseProtocol> {
        Factory(self) { GetProductsUseCase() }
    }
}
