//
//  BaseViewController.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import UIKit
import Combine

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    // MARK: - UI Elements
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    lazy var refreshControl = UIRefreshControl()
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
    }
    
    // MARK: - Loading Indicator
    private func setupLoadingIndicator() {
        loadingIndicator.center = view.center
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - Error Handling
    func showError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
