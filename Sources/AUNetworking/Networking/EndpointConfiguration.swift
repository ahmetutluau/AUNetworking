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

public typealias QueryStringParameters = [String: String]?
public typealias MultipartFormData = [(name: String, filename: String, data: Data)]?

//All endpoint routers will confirm this protocol
public protocol EndpointConfiguration {
    var method: HTTPMethod { get }
    var path: String { get }
    var queryParameters: QueryStringParameters { get }
    var httpBody: Data? { get }
    var headers: [CustomHTTPHeader]? { get }
    var multipartFormData: MultipartFormData  { get }
}

public extension EndpointConfiguration {
    func makeUrlRequest() -> URLRequest {
        guard var components = URLComponents(string: APIConstants.baseURL + path) else { fatalError("Invalid base URL") }
        
        //Create request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        //Add queryParams
        if let queryParams = queryParameters {
            // For GET requests, append query parameters to the URL

            if method == .GET {
                var queryItems: [URLQueryItem] = []
                for (key, value) in queryParams {
                    let queryItem = URLQueryItem(name: key, value: String(describing: value))
                    queryItems.append(queryItem)
                }
                components.queryItems = queryItems
                request.url = components.url
                
            } else {
                // For other methods, add query parameters to the request body
                do {
                    let data = try JSONSerialization.data(withJSONObject: queryParams)
                    request.httpBody = data
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        //Add body
        request.httpBody = httpBody

        
        //Add header
        headers?.forEach({ header in
            request.setValue(header.value, forHTTPHeaderField: header.key)
        })
        
        //Add multipart form data
        if let multipartFormData = multipartFormData {
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            for formData in multipartFormData {
                request.httpBody?.append("--\(boundary)\r\n".data(using: .utf8)!)
                request.httpBody?.append("Content-Disposition: form-data; name=\"\(formData.name)\"; filename=\"\(formData.filename)\"\r\n".data(using: .utf8)!)
                request.httpBody?.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
                request.httpBody?.append(formData.data)
                request.httpBody?.append("\r\n".data(using: .utf8)!)
            }
        }
        
        return request
    }
}
