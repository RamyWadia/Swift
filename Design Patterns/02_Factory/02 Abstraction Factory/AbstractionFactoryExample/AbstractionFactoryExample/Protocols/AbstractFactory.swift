//
//  AbstractFactory.swift
//  AbstractionFactoryExample
//
//  Created by Ramy Atalla on 2022-04-12.
//

import Foundation

protocol AbstractFactoryProtocol {
    func createChair() -> ChairProtocol
    func createSofa() -> SofaProtocol
    func createTable() -> TableProtocol
}
