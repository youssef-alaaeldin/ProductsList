//
//  ProductDataSourceDelegation.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 09/05/2025.
//

import Foundation

protocol ProductsDataSourceDelegation: AnyObject {
    var numOfSections: Int { get }
    var numberOfItems: Int { get }
    func model(for indexPath: Int) -> ProductCellModel
    func didSelect(indexPath: Int)
}
