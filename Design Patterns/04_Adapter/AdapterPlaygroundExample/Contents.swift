import UIKit

protocol BirdProtocol {
    func sing()
    func fly()
}

class Bird: BirdProtocol {
    func sing() {
        print("twe - twe")
    }
    
    func fly() {
        print("Bird is flying")
    }
}

class Raven {
    func flySearchAndEat() {
        print("I am a smart raven flying looking for food")
    }
    
    func call() {
        print("Kraaa - Kraaa")
    }
}

func testBird<T: BirdProtocol>(bird: T) {
    bird.fly()
    bird.sing()
}

let bird1 = Bird()
testBird(bird: bird1)

//can we now testBird the raven?
//No, as it does not conform to the BirdProtocol,
//But we know that Raven is a bird so we can
//use adapter to solv this problem.

class RavenAdapter: BirdProtocol {
    private var raven: Raven
    
    init(adaptee: Raven) {
        raven = adaptee
    }
    
     func fly() {
        raven.flySearchAndEat()
    }
    
    func sing() {
        raven.call()
    }
}

//now as the RavenAdapter conforms to the protocol
//and it has the required methods we can testBird the Raven

let raven = Raven()
let ravenAdapter = RavenAdapter(adaptee: raven)
testBird(bird: ravenAdapter)

