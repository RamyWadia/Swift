//
//  TwitterAdapter.swift
//  AdapterExample
//
//  Created by Ramy Atalla on 2022-05-24.
//

import Foundation

class TwitterAuthAdatper: AuthenticationService {
    
    private var authenticator = TwitterAuthentor()
    
    
    public func login(email: String,
               password: String,
               success: @escaping completionSuccess,
               failure: @escaping completionFailure) {
        
        authenticator.login(email: email,
                            password: password) { result in
            switch result {
            case .success(let twitterUser):
                let user = User(email: twitterUser.email, password: twitterUser.password)
                let token = Token(value: twitterUser.token)
                success(user, token)
            case .failure(let err):
                failure(err)
            }
        }
    }
}
