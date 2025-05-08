//
//  ProductsRequest.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import Foundation

struct ProductsRequest: Endpoint {
    var limit: Int?
    
    var parameters: [String : Any]? {
        var parameters: [String : Any] = [:]
        
        if let limit = limit {
            parameters["limit"] = limit
        }
        
        return parameters
    }
    
    var path: String {
        "/products"
    }
    
    var headers: [String : String]?
    
    var body: Any?
}
