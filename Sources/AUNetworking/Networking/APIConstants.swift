/*
MIT License

Copyright (c) 2024 Ahmet UTLU

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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
