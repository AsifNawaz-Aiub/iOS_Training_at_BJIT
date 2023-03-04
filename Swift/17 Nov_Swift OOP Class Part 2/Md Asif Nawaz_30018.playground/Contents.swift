import UIKit
// Md Asif Nawaz - 30018
class Vehicle{
    var wheels : Int
    var seats : Int
    var vehicleName: String
    static var totalWheelsToMake:Int = 0
    static var totalPriceOfWheels: Double = 0.00
    static private(set) var eachWheelPrice = 100.00
    
    class func calculateTotalPriceToMakeWheels ()-> Double{
        //self.eachWheelPrice = eachWheelPrice
        totalPriceOfWheels = (eachWheelPrice * Double(totalWheelsToMake))
        return Vehicle.totalPriceOfWheels
    }

    func showVehicleDetails(){
        print("Wheels : \(wheels), Seats: \(seats)")
    }
    
    init(wheels: Int, seats:Int, vehicleName: String){
        self.wheels = wheels
        self.seats = seats
        self.vehicleName = vehicleName
        Vehicle.totalWheelsToMake += self.wheels
        Vehicle.calculateTotalPriceToMakeWheels()
        
    }
    
    deinit {
        print("This instance is deleted")
        Vehicle.totalWheelsToMake = Vehicle.totalWheelsToMake - self.wheels
        Vehicle.calculateTotalPriceToMakeWheels()

    }
 
}


var firstVehicle:Vehicle? = Vehicle (wheels: 4, seats: 4, vehicleName: "Sedan")
var firstVehicle2:Vehicle? = Vehicle (wheels: 2, seats: 4, vehicleName: "Sedan")

firstVehicle?.showVehicleDetails()
firstVehicle2?.showVehicleDetails()

print("Price of Total Wheels Now - \(Vehicle.totalPriceOfWheels)")
//firstVehicle = nil
firstVehicle2 = nil
print("Price of Total Wheels Now - \(Vehicle.totalPriceOfWheels)")


//print(Vehicle.calculateTotalPriceToMakeWheels(eachWheelPrice:100.00))
//firstVehicle.getTotalPriceOfWheels()
