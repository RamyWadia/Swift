//
//  ViewController.swift
//  AdapterExample
//
//  Created by Ramy Atalla on 2022-05-24.
//

import UIKit

class ViewController: UIViewController {
    
    var authService: AuthenticationService = GoogleAuthAdatper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createUser(email: "email@email.se", password: "supperPassword")
    }
    
    func createUser(email: String,
                    password: String) {
        authService.login(email: email, password: password) { user, token in
            print("DEBUG: user \(email) authenticated successfully with token \(token)")
        } failure: { err in
            if let err = err {
                print("DEBUG: implementing needed for error \(err.localizedDescription)")
            }
        }
    }
}

