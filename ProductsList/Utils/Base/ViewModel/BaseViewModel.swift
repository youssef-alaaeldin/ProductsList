//
//  BaseViewModel.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation
import Combine

class BaseVM: BaseVMProtocol {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    var isLoadingPublisher: Published<Bool>.Publisher {
        return $isLoading
    }
    
    var errorMessagePublisher: Published<String>.Publisher {
        return $errorMessage
    }
  
    var cancellables = Set<AnyCancellable>()
    
    func onFailure(_ error: String) {
        self.errorMessage = error.description
        self.isLoading = false
    }
}
