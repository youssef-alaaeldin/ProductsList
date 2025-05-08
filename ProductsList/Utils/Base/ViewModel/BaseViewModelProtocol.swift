//
//  BaseViewModelProtocol.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation
import Combine

protocol BaseVMProtocol {
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    var errorMessagePublisher: Published<String>.Publisher { get }
    
    func onFailure(_ error: String)
}
