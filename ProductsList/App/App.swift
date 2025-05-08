//
//  App.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import UIKit
import Factory

class App {
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootNavigationController = UINavigationController()
        self.window.rootViewController = rootNavigationController
        let productsViewController = Container.productsServiceDI(navigationController: rootNavigationController)
        rootNavigationController.setViewControllers([productsViewController], animated: true)
        window.makeKeyAndVisible()
    }
}
