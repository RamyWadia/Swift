//
//  ViewController.swift
//  Factory
//
//  Created by Ramy Atalla on 2022-04-08.
//

import UIKit

class ViewController: UIViewController {
    
    var exerciseArray = [Exercise]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createExercise(exName: .jumping)
        createExercise(exName: .squat)
        createExercise(exName: .pushUps)
        practiceExercise()
    }
    
    func createExercise(exName: Exercises) {
        let NewExercise = FactoryExercise.defaultFactory.createExercise(name: exName)
        exerciseArray.append(NewExercise)
    }
    
    func practiceExercise() {
        for ex in exerciseArray {
            ex.start()
            ex.stop()
        }
    }


}

