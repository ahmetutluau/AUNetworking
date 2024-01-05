//
//  File.swift
//  
//
//  Created by Ahmet Utlu on 5.01.2024.
//

import Foundation

extension NetworkRequester {
    func request<T: Decodable>(router: EndpointConfiguration,
                              thread: DispatchQoS.QoSClass? = nil,
                              onSuccess: @escaping (T, String?) -> Void,
                               onFailure: @escaping (String?, NetworkError) -> Void) {
        request(router: router,
                thread: thread,
                onSuccess: onSuccess,
                onFailure: onFailure)
    }
}
