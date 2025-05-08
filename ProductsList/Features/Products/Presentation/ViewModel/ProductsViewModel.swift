//
//  ProductsViewModel.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation
import Combine
import Factory

class ProductsViewModel: BaseVM {
    @Injected(\.getProductsUseCase) var getProductsUseCase
    
    private var router: ProductsRouterProtocol
    
    init(router: ProductsRouterProtocol) {
        self.router = router
    }
}


// MARK: API Calls

extension ProductsViewModel {
    func getProducts() {
        let request = ProductsRequest(limit: 7)
        
        getProductsUseCase.execute(productsRequest: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let productsResponse):
                    print("Success \(productsResponse)")
                    
                case .failure(let error):
                    self.onFailure(error.localizedDescription)
            }
        }
        
    }
}
