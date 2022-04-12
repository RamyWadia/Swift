//
//  KitchenFactory.swift
//  AbstractionFactoryExample
//
//  Created by Ramy Atalla on 2022-04-12.
//

import Foundation

class KitchenFactory: AbstractFactoryProtocol {
    func createChair() -> ChairProtocol {
        print("Kitchen chair added to basket")
        return KitchenChair()
    }
    
    func createSofa() -> SofaProtocol {
        print("Kitchen Sofa added to basket")
        return KitchenSofa()
    }
    
    func createTable() -> TableProtocol {
        print("Kitchen Table added to basket")
        return KitchenTable()
    }
    
    
}
