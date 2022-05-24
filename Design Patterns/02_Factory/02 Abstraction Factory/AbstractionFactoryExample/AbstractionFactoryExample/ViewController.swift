//
//  ViewController.swift
//  AbstractionFactoryExample
//
//  Created by Ramy Atalla on 2022-04-12.
//

import UIKit

class ViewController: UIViewController {
    var chair: ChairProtocol?
    var table: TableProtocol?
    var sofa: SofaProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func KitchenBuy(_ sender: Any) {
        chair = KitchenFactory().createChair()
        table = KitchenFactory().createTable()
        sofa = KitchenFactory().createSofa()
    }
    
    
    @IBAction func LivingRoomBuy(_ sender: Any) {
        chair = LivingRoomFactory().createChair()
        table = LivingRoomFactory().createTable()
        sofa = LivingRoomFactory().createSofa()
    }
}

