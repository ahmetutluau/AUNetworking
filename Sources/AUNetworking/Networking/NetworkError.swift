//
//  File.swift
//  
//
//  Created by Ahmet Utlu on 12.10.2023.
//

import Foundation

public enum NetworkError: Error {
    case noError
    case credentialsWrong
    case notConnectedInternet
    case serviceResponseFailed
    case conflictCredentials
    case emptyOrNil
    case authenticationLocked
    case notValidOtpCode
    case redirectAuth
}
