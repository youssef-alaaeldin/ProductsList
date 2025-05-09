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
    
    @Published var products: [Product] = []
    
    private var router: ProductsRouterProtocol
    var dataSourceInjection: (() -> Void)?
    
    init(router: ProductsRouterProtocol) {
        self.router = router
    }
    
    func viewWillAppear() {
        dataSourceInjection?()
        getProducts()
    }
}


// MARK: API Calls

extension ProductsViewModel {
    func getProducts() {
        isLoading = true
        let request = ProductsRequest(limit: 7)
        
        getProductsUseCase.execute(productsRequest: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let products):
                    onSuccess(products: products)
                case .failure(let error):
                    self.onFailure(error.localizedDescription)
            }
        }
        
    }
    
    private func onSuccess(products: [Product]) {
        self.products = products
        isLoading = false
    }
}


// MARK: - Data Source Delegation

extension ProductsViewModel: ProductsDataSourceDelegation {
    var numOfSections: Int {
        1
    }
    
    var numberOfItems: Int {
        products.count
    }
    
    func model(for indexPath: Int) -> ProductCellModel {
        guard indexPath >= 0 && indexPath < products.count else {
            fatalError("IndexPath out of bounds in ProductsViewModel.model(for:)")
        }
        let product = products[indexPath]
        return ProductCellModel.mapProductToCellModel(product)
    }
    
    func didSelect(indexPath: Int) {
        
    }
}
