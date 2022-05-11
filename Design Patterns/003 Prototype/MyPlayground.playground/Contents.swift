import UIKit

var str = "Prototype"

class Person {
    var name = ""
}

var person1 = Person()
person1.name = "Jack"

print(person1.name)

var person2 = person1
person2.name = "George"

print(person2.name)
print(person1.name)
//We see the effect of reference type as both print
//lines will give the name George.
//No real copying happened here.

//Same we can test it with next line
print(person1 === person2)


//Next few lines shows how to create a clone
//that will not refere to the same adress in
//memory which is the desired prototype.
class CopiablePerson {
    var name = ""
    
    func clone() -> CopiablePerson {
        let person = CopiablePerson()
        person.name = name
        return person
    }
}

var person3 = CopiablePerson()
person3.name = "Natalia"

var person4 = person3.clone()

//Now we test the clone
print(person3 === person4)


//a practical way to use a prototype is:
class ProtoPerson {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func clone() -> ProtoPerson {
        return ProtoPerson(name: self.name)
    }
}

var person5 = ProtoPerson(name: "somename")
var person6 = person5.clone()
print(person5 === person6)


//Now is time for best prototype in swift.
// It is the same like NSCopying using Swift

protocol Copiable {
    init(_ prototype: Self)
}

extension Copiable {
    public func copy() -> Self {
        return type(of: self).init(self)
    }
}

class ProCopiablePerson: Copiable {
        var name: String
    
    init(name: String) {
        self.name = name
    }
    
    required convenience init(_ prototype: ProCopiablePerson) {
        self.init(name: prototype.name)
    }
}

var person7 = ProCopiablePerson(name: "Max")
var person8 = person7.copy()
print(person7 === person8)
print(person7.name, person8.name)
// as we see now we have deep prototyped without
//referensing the same memory adress. 



