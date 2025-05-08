//
//  BaseViewControllerProtocol.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation

protocol BaseViewControllerProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func handleRefresh()
}
