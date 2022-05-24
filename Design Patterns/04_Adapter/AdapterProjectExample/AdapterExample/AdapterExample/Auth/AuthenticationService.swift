//
//  AuthenticationService.swift
//  AdapterExample
//
//  Created by Ramy Atalla on 2022-05-24.
//

import Foundation

public struct User {
    public let email: String
    public let password: String
}

public struct Token {
    public let value: String
}

public protocol AuthenticationService {
    typealias authenticatedUser = (User, Token)
    
    typealias completionSuccess = (User, Token) -> Void
    typealias completionFailure = (Error?) -> Void
    
    func login(email: String,
               password: String,
               success: @escaping completionSuccess,
               failure: @escaping completionFailure)
}
