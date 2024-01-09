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
import Alamofire

public typealias QueryStringParameters = [String: String]?

public protocol EndpointConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var queryParameters: QueryStringParameters { get }
    var httpBody: Data? { get }
    var headers: [CustomHTTPHeader]? { get }
}

public extension EndpointConfiguration {
    func asURLRequest() throws -> URLRequest {
        let url = try (APIConstants.baseURL + path).asURL()
        
        var urlComponents = URLComponents(string: url.absoluteString)
        
        //Query Parameters
        urlComponents?.queryItems = queryParameters?.map { key, value in
            return URLQueryItem(name: key, value: value)
        }

        var urlRequest = URLRequest(url: (urlComponents?.url!)!)

        //HTTP Method
        urlRequest.httpMethod = method.rawValue

        //Headers
        headers?.forEach({ header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        })

        //Parameters
        urlRequest.httpBody = httpBody

        return urlRequest
    }
}
