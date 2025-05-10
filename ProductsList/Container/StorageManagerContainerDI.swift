//
//  StorageManagerContainerDI.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 10/05/2025.
//

import Foundation
import Factory

extension Container {
    
    // MARK: - Storage manager
    
    var coreDataStorageManager: Factory<StorageManagerProtocol> {
        Factory(self) { CoreDataStorageManager()}
    }
}
