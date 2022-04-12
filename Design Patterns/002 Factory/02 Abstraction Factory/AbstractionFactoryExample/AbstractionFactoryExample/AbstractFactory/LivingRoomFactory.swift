//
//  LivingRoomFactory.swift
//  AbstractionFactoryExample
//
//  Created by Ramy Atalla on 2022-04-12.
//

import Foundation

class LivingRoomFactory: AbstractFactoryProtocol {
    func createChair() -> ChairProtocol {
        print("LivingRoom Chair added to basket")
        return LivingRoomChair()
    }
    
    func createSofa() -> SofaProtocol {
        print("LivingRoomSofa added to basket")
        return LivingRoomSofa()
    }
    
    func createTable() -> TableProtocol {
        print("LivingRoomTable added to basket")
        return LivingRoomTable()
    }
    
    
}
