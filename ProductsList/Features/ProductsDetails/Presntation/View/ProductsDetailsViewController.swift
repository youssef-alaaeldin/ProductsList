//
//  ProductsDetailsViewController.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import UIKit
import SDWebImage

class ProductsDetailsViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
        setupUI()
        scrollView.delegate = self
    }
}

// MARK: - Setup UI

extension ProductsDetailsViewController {
    private func setupUI() {
        let product = viewModel.product
        
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        ratingLabel.text = "⭐️ \(product.rating.rate) (\(product.rating.count) reviews)"
        descriptionLabel.text = product.description
        
        productImageView.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(systemName: "photo"))
    }
}

// MARK: - Stretch header

extension ProductsDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y

        if y < 0 {
            imageHeightAnchor.constant = 250 - y
        } else {
            imageHeightAnchor.constant = 250
        }
    }
}
