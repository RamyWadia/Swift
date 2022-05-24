//
//  Squat.swift
//  Factory
//
//  Created by Ramy Atalla on 2022-04-08.
//

import Foundation

class Squat: Exercise {
    var name: String = "Squat"
    
    var type: String = "Legs exercise"
    
    func start() {
        print("start squats")
    }
    
    func stop() {
        print("done squating")
    }
    
    
}
