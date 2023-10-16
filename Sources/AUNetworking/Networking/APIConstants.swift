//
//  File.swift
//  
//
//  Created by Ahmet Utlu on 12.10.2023.
//

import Foundation

public struct APIConstants {
    static var _baseURL = "write-your-base-url"
    public static var baseURL: String {
        get {
            return _baseURL
        }
        set {
            _baseURL = newValue
        }
    }
}
    
public enum CustomHTTPHeader: String {
    case authentication
    case contentType
    case multiPart
    case deviceType
    
    var key: String {
        switch self {
        case .authentication: return "Authorization"
        case .contentType: return "Content-Type"
        case .multiPart: return "Content-Type"
        case .deviceType: return "DeviceType"
        }
    }
    
    var value: String {
        switch self {
        case .authentication: return "Bearer"
        case .contentType: return "application/json"
        case .multiPart: return "multipart/form-data"
        case .deviceType: return "2"
        }
    }
}
