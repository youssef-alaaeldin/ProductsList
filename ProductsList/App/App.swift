//
//  App.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation
import UIKit

class App {
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootNavigationController = UINavigationController()
        self.window.rootViewController = rootNavigationController
        let viewController = ViewController()
        rootNavigationController.setViewControllers([viewController], animated: true)
        window.makeKeyAndVisible()
    }
}
