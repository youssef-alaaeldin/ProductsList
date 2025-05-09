//
//  ProductDataSource.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import Foundation
import UIKit

class ProductDataSource: NSObject {
    
    private weak var source: ProductsDataSourceDelegation?
    var isGridLayout = false
    init(source: ProductsDataSourceDelegation?) {
        self.source = source
    }
    
}

extension ProductDataSource: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return source?.numOfSections ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        source?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        source?.didSelect(indexPath: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        let threshold: CGFloat = 100
        
        let isNearBottom = offsetY + frameHeight >= contentHeight - threshold
        
        if isNearBottom {
            source?.loadMoreItemsIfNeeded()
        }
    }
}

extension ProductDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = source?.model(for: indexPath.row) else {
            return UICollectionViewCell()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else { return UICollectionViewCell() }
        
        cell.configure(with: model, isGrid: isGridLayout)
        return cell
    }
    
    func toggleIsGrid(_ isGrid: Bool) {
        self.isGridLayout = isGrid
    }
}
