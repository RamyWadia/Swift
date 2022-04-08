//
//  Exercise.swift
//  Factory
//
//  Created by Ramy Atalla on 2022-04-08.
//

import Foundation

protocol Exercise {
    var name: String { get }
    var type: String { get }
    
    func start()
    func stop()
}
