//
//  ProductsViewModel.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation
import Combine
import Factory

// MARK: - ProductsViewModel

class ProductsViewModel: BaseVM {
    @Injected(\.getProductsUseCase) var getProductsUseCase
    
    @Published var products: [Product] = []
    
    private var router: ProductsRouterProtocol
    var dataSourceInjection: (() -> Void)?
    
    // MARK: Pagination states
    private var currentLimit = PaginationConstants.pageSize
    private var isPaginating = false
    private var isAllItemsLoaded = false

    // MARK: - Init
    init(router: ProductsRouterProtocol) {
        self.router = router
    }
}

// MARK: - Public Methods

extension ProductsViewModel {
    func viewWillAppear() {
        dataSourceInjection?()
        getProducts(reset: true)
    }
}

// MARK: - API

private extension ProductsViewModel {
    
    func getProducts(reset: Bool = false) {
        if reset { resetPagination() }
        guard !isAllItemsLoaded else { return }

        isLoading = true
        let request = ProductsRequest(limit: min(currentLimit, PaginationConstants.maxItems))

        getProductsUseCase.execute(productsRequest: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let (products, isFromCache)):
                    self.handleSuccess(products: products, isReset: reset, isFromCache: isFromCache)

                case .failure:
                    self.handleFailure(message: "Failed to load products. No cached data available.")
            }
        }
    }

    func handleSuccess(products: [Product], isReset: Bool, isFromCache: Bool) {
        if isReset {
            self.products = products
        } else {
            let newProducts = products.suffix(PaginationConstants.pageSize)
            self.products.append(contentsOf: newProducts)
        }

        isLoading = false
        isPaginating = false

        if isFromCache {
            isAllItemsLoaded = true
            errorMessage = "You're viewing cached data. Internet connection failed."
        }

        if products.count < currentLimit || self.products.count >= PaginationConstants.maxItems {
            isAllItemsLoaded = true
        }
    }

    func handleFailure(message: String) {
        errorMessage = message
        isLoading = false
        isPaginating = false
    }
}

// MARK: - Pagination

private extension ProductsViewModel {

    func resetPagination() {
        currentLimit = PaginationConstants.pageSize
        isAllItemsLoaded = false
    }

    func loadMoreProducts() {
        guard canLoadMore else { return }

        isPaginating = true
        currentLimit = min(currentLimit + PaginationConstants.pageSize, PaginationConstants.maxItems)
        getProducts(reset: false)
    }

    var canLoadMore: Bool {
        return !isLoading && !isPaginating && !isAllItemsLoaded
    }
}

// MARK: - Data Source Delegation

extension ProductsViewModel: ProductsDataSourceDelegation {
    var numOfSections: Int { 1 }

    var numberOfItems: Int { products.count }

    func model(for indexPath: Int) -> ProductCellModel {
        guard indexPath >= 0 && indexPath < products.count else {
            fatalError("IndexPath out of bounds in ProductsViewModel.model(for:)")
        }
        return ProductCellModel.mapProductToCellModel(products[indexPath])
    }

    func loadMoreItemsIfNeeded() {
        loadMoreProducts()
    }

    func didSelect(indexPath: Int) {
        router.navigateToDetails(product: products[indexPath])
    }
}

// MARK: - Constants

private extension ProductsViewModel {
    enum PaginationConstants {
        static let pageSize: Int = 7
        static let maxItems: Int = 20
    }
}
