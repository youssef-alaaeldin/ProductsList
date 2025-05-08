//
//  NetworkProviderContainerDI.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation
import Factory

extension Container {
    var networkProvider: Factory<NetworkProviderProtocol> {
        Factory(self) { NetworkProvider() }
    }
}
