//
//  FactoryExercise.swift
//  Factory
//
//  Created by Ramy Atalla on 2022-04-08.
//

import Foundation

enum Exercises {
    case jumping, squat, pushUps
}

class FactoryExercise {
   static let defaultFactory = FactoryExercise()
    
    func createExercise(name: Exercises) -> Exercise {
        switch name {
        case .jumping: return Jumping()
        case .squat: return Squat()
        case .pushUps: return PushUps()
        }
    }
}
