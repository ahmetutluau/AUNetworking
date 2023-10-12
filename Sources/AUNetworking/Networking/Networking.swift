//
//  File.swift
//  
//
//  Created by Ahmet Utlu on 12.10.2023.
//

import Foundation
import Alamofire

public class Networking {
     public static func request<T: Decodable>(router: EndpointConfiguration,
                                      thread: DispatchQoS.QoSClass? = nil,
                                      onSuccess: @escaping (T, String?) -> Void,
                                      onFailure: @escaping (String?, NetworkError) -> Void) {
        switch thread {
        case .background:
            DispatchQueue.global(qos: .background).async {
                handleRequest(router: router,
                              onSuccess: onSuccess,
                              onFailure: onFailure)
            }
        default:
            handleRequest(router: router,
                          onSuccess: onSuccess,
                          onFailure: onFailure)
        }
    }
    
    static private func handleRequest<T: Decodable>(router: EndpointConfiguration,
                                                    onSuccess: @escaping (T, String?) -> Void,
                                                    onFailure: @escaping (String?, NetworkError) -> Void) {
        callRequest(router: router,
                    onSuccess: onSuccess,
                    onFailure: onFailure)
    }
    
    static private func callRequest<T: Decodable>(router: EndpointConfiguration,
                                                  onSuccess: @escaping (T, String?) -> Void,
                                                  onFailure: @escaping (String?, NetworkError) -> Void) {
        AF.request(router).responseDecodable { (response: AFDataResponse<T?>) in
            handleResponse(response: response,
                           onSuccess: onSuccess,
                           onFailure: onFailure)
        }
    }
    
    static private func handleResponse<T: Decodable>(response: AFDataResponse<T?>,
                                                     onSuccess: @escaping (T, String?) -> Void,
                                                     onFailure: @escaping (String?, NetworkError) -> Void) {
        printLog(response: response)
        let jsonString = String(bytes: response.data ?? Data(), encoding: .utf8) ?? ""
        let dict = jsonString.convertToDictionary()
        let consumerErrorMessage = dict?["error"] as? String
        switch response.result {
        case .success(let baseData):
            guard let validatedStatusCode = response.response?.statusCode else { return }
            switch validatedStatusCode {
            case 200..<300:
                guard let validatedData = baseData else {
                    onFailure("error200", .noError)
                    return
                }
                onSuccess(validatedData, consumerErrorMessage)
            case 406:
                onFailure("error406", .notValidOtpCode)
            case 417:
                onFailure("error417" , .redirectAuth)
            case 423:
                onFailure("error423", .authenticationLocked)
            default:
                onFailure("errorDefault", .noError)
            }
        case .failure:
            if !ConnectionManager.isConnectedToNetwork() {
                onFailure(consumerErrorMessage, .notConnectedInternet)
            }
            else {
                onFailure(consumerErrorMessage, .noError)
            }
        }
    }

    static private func printLog<T: Decodable>(response: AFDataResponse<T>) {
        print("\n\n\n")
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        debugPrint(response)
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        print("\n\n\n")
    }
}
