//
//  ProductsDetailsViewController.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import UIKit

class ProductsDetailsViewController: BaseViewController {
    
    private var viewModel: ProductsDetailsViewModel
    
    init(viewModel: ProductsDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ProductsDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.product.title)
    }

}
