//
//  ProductCell.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    static let identifier = "ProductCell"
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        productImageView.contentMode = .scaleAspectFit
    }
    
    func configure(with product: ProductCellModel, isGrid: Bool) {
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        
        productImageView.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(systemName: "photo"))
        
        mainStackView.axis = isGrid ? .vertical : .horizontal
        titleLabel.textAlignment = isGrid ? .center : .left
        priceLabel.textAlignment = isGrid ? .center : .left
    }
}
