//
//  StorageManagerProtocol.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 10/05/2025.
//

import Foundation
import CoreData

protocol StorageManagerProtocol {
    func saveContext()
    
    func save<T: NSManagedObject>(_ type: T.Type, count: Int, configure: (T, Int) -> Void)
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T]
    
    func clear<T: NSManagedObject>(_ type: T.Type)
}
