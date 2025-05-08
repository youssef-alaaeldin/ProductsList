//
//  RouterProtocol.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation
import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController { get set }
    var presentedVC: UIViewController? { get }
}

extension RouterProtocol {
    unowned var presentedVC: UIViewController? {
        return navigationController.topViewController
    }
}
