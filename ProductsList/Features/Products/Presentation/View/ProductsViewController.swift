//
//  ProductsViewController.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import UIKit

class ProductsViewController: BaseViewController {
    
    var viewModel = ProductsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getProducts()
    }

}
