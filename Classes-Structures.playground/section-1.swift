// Playground - noun: a place where people can play swift

class Vehicle {
    var wheelNumber: Int
    var passengerNumber: Int
    
    func description() -> String {
        return "\(wheelNumber) wheels and \(passengerNumber) max number of passengers"
    }
    
    init() {
        wheelNumber = 0
        passengerNumber = 0
    }
    
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        wheelNumber = 2
        passengerNumber = 2
    }
    
}

let abicycle = Bicycle()
abicycle.description()
