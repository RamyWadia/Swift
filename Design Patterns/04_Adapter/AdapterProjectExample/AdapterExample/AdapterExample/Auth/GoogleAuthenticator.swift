//
//  GoogleAuthentication.swift
//  AdapterExample
//
//  Created by Ramy Atalla on 2022-05-24.
//

import Foundation

public struct GoogleUser {
    public var email: String
    public var password: String
    public var token: String
}

public class GoogleAuthenticator {
    
    public typealias completion = (Result<GoogleUser, Error>) -> Void
    
    public func login(email: String,
                      password: String,
                      completion: @escaping completion) {
        let token = "special-token-value"
        let user = GoogleUser(email: email,
                              password: password,
                              token: token)
        completion(.success(user))
    }
}
