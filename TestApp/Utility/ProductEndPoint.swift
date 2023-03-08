//
//  ProductEndPoint.swift
//  Youtube MVVM Products
//
//  Created by Yogesh Patel on 15/01/23.
//

import Foundation

enum ProductEndPoint {
    case products // Module - GET
}

// https://fakestoreapi.com/products
extension ProductEndPoint: EndPointType {

    var path: String {
        switch self {
        case .products:
            return "products"
        }
    }

    var baseURL: String {
        switch self {
        case .products:
            return "https://fakestoreapi.com/"
        }
    }

    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        }
    }

    var body: Encodable? {
        switch self {
        case .products:
            return nil
    
        }
    }

    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}
