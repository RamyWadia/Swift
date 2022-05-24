//
//  GoogleAuthAdatper.swift
//  AdapterExample
//
//  Created by Ramy Atalla on 2022-05-24.
//

import Foundation

class GoogleAuthAdatper: AuthenticationService {
    
    private var authenticator = GoogleAuthenticator()
    
    
    public func login(email: String,
               password: String,
               success: @escaping completionSuccess,
               failure: @escaping completionFailure) {
        
        authenticator.login(email: email,
                            password: password) { result in
            switch result {
            case .success(let googleUser):
                let user = User(email: googleUser.email, password: googleUser.password)
                let token = Token(value: googleUser.token)
                success(user, token)
            case .failure(let err):
                failure(err)
            }
        }
    }
}
