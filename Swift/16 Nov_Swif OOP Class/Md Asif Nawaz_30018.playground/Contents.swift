import UIKit

class MotorVehicle{
    var wheels : Int
    var seats : Int
    var motorVehicleType: String
    
    func typeOfMotorVehicle(){
        print("This is a \(motorVehicleType)")
    }
    
    func engine(cc: Int){
        print("Default Engine cc \(cc)")
    }
    
    init(motorVehicleType: String,wheels: Int, seats:Int){
        self.motorVehicleType = motorVehicleType
        self.wheels = wheels
        self.seats = seats
    }
    init(){
        self.motorVehicleType = "Motor Vehicle"
        self.wheels = 0
        self.seats = 0
    }
 
}


class SedanCar : MotorVehicle {
    
    init(vehicleType:String){
        super.init(motorVehicleType:vehicleType, wheels: 4,seats: 4)
    }
    
    override func typeOfMotorVehicle (){
        print("This is a \(motorVehicleType) Motor Vehicle")
    }
    override func engine (cc:Int){
        print("A \(motorVehicleType) will have \(cc) cc engine!")
    }
}

let motorVehicle = MotorVehicle()

motorVehicle.typeOfMotorVehicle()
motorVehicle.engine(cc: 0)

let aCar = SedanCar (vehicleType:"4 Door Sedan")

aCar.typeOfMotorVehicle()
aCar.engine(cc: 1400)

