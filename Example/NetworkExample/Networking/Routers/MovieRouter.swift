//
//  MovieRouter.swift
//  NetworkExample
//
//  Created by Ahmet Utlu on 12.10.2023.
//

import Foundation
import AUNetworking

enum MovieRouter: EndpointConfiguration {
        
    case popular
    case detail(Int)
    
    var method: HTTPMethod {
        switch self {
        case .popular:
            return .GET
        case .detail:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .detail(let model):
            return "/movie/\(model)"
        }
    }
    
    var queryParameters: QueryStringParameters {
        switch self {
        case .popular,.detail:
            return ["api_key": "d01c48435a43627d2ac87bf0d9e756ee"]
        }
    }
    
    var httpBody: Data? {
        return nil
    }
    
    var headers: [CustomHTTPHeader]? {
        return nil
    }
    
    var multipartFormData: MultipartFormData {
        return nil
    }

}
