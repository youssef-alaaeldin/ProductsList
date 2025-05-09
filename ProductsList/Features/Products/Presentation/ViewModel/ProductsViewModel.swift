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
    
    // Pagination states
    private var currentLimit = 7
    private let pageSize = 7
    private let maxItems = 20
    private var isLoadingMore = false
    private var isAllItemsLoaded = false
    
    init(router: ProductsRouterProtocol) {
        self.router = router
    }
    
    func viewWillAppear() {
        dataSourceInjection?()
        getProducts(reset: true)
    }
}


// MARK: API Calls

extension ProductsViewModel {
    func getProducts(reset: Bool = false) {
        if reset {
            currentLimit = pageSize
            isAllItemsLoaded = false
        }
        
        guard !isAllItemsLoaded else { return }
        
        isLoading = true
        let request = ProductsRequest(limit: min(currentLimit, maxItems))
        
        getProductsUseCase.execute(productsRequest: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let products):
                    self.onSuccess(products: products, isReset: reset)
                case .failure(let error):
                    self.onFailure(error.localizedDescription)
            }
        }
    }
    
    private func onSuccess(products: [Product], isReset: Bool) {
        if isReset {
            self.products = products
        } else {
            let newProducts = products.suffix(pageSize)
            self.products.append(contentsOf: newProducts)
        }
        isLoading = false
        isLoadingMore = false
        
        if self.products.count >= maxItems || products.count < currentLimit {
            isAllItemsLoaded = true
        }
    }
    
    func loadMoreProducts() {
        guard !isLoading && !isLoadingMore && !isAllItemsLoaded else { return }
        isLoadingMore = true
        currentLimit = min(currentLimit + pageSize, maxItems)
        getProducts(reset: false)
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
    
    func loadMoreItemsIfNeeded() {
        loadMoreProducts()
    }
    
    func didSelect(indexPath: Int) {
        router.navigateToDetails(product: products[indexPath])
    }
}
