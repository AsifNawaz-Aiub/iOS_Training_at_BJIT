import UIKit

// Md Asif Nawaz - 30018

//Example - Builder Pattern

class PCCofiguration {
    var monitor: String
    var processor: String
    var ram: String
    var storage: String
    var gpu: String
    
    init(builder: PCCofigurationBuilder) {
        self.monitor = builder.monitor
        self.processor = builder.processor
        self.ram = builder.ram
        self.storage = builder.storage
        self.gpu = builder.gpu
    }
}

class PCCofigurationBuilder {
    var monitor: String = "-"
    var processor: String = "-"
    var ram: String = "-"
    var storage: String = "-"
    var gpu: String = "-"
    
    func setMonitor(_ monitor: String) -> PCCofigurationBuilder {
        self.monitor = monitor
        return self
    }
    
    func setProcessor(_ processor: String) -> PCCofigurationBuilder {
        self.processor = processor
        return self
    }

    func setRAM(_ ram: String) -> PCCofigurationBuilder {
        self.ram = ram
        return self
    }

    func setStorage(_ storage: String) -> PCCofigurationBuilder {
        self.storage = storage
        return self
    }
    
    func setGpu(_ gpu: String) -> PCCofigurationBuilder {
        self.gpu = gpu
        return self
    }

    func build() -> PCCofiguration {
        return PCCofiguration(builder: self)
    }
}

let pCCofigurationBuilder = PCCofigurationBuilder()
let pCCofigurationBuilder2 = PCCofigurationBuilder()

let computer = pCCofigurationBuilder
    .setMonitor("BenQ GW2283")
    .setProcessor("Ryzen 5 1600")
    .setRAM("16 GB")
    .setStorage("1000GB HDD")
    .setGpu("Nvidia 1050 TI")
    .build()

let computer2 = pCCofigurationBuilder2
    .setProcessor("Ryzen 5 1600")
    .setRAM("16 GB")
    .setStorage("1000GB HDD")
    .build()

print("PC - 1")
print(computer.monitor)
print(computer.processor)
print(computer.ram)
print(computer.storage)
print(computer.gpu)
print("\nPC - 2")
print(computer2.monitor)
print(computer2.processor)
print(computer2.ram)
print(computer2.storage)
print(computer2.gpu)




//Example - Bridge Pattern

protocol Shape {
    var color: Color { get }
    func draw()
}

protocol Color {
    func fill()
}

class Circle: Shape {
    var color: Color
    var radius: Double
    init(_ color: Color, radius: Double) {
        self.color = color
        self.radius = radius
    }
    func draw() {
        print("Drawing circle with radius: \(radius) and color:")
        color.fill()
    }
}

class Red: Color {
    func fill() {
        print("red")
    }
}

class Blue: Color {
    func fill() {
        print("blue")
    }
}

let redCircle = Circle(Red(), radius: 5)
let blueCircle = Circle(Blue(), radius: 10)
redCircle.draw()
blueCircle.draw()

//In this example, the Shape protocol defines a draw() method, which is implemented by the Circle class. The Circle class also has a property for the color, which is defined by the Color protocol. The Color protocol has a fill() method which is implemented by two different concrete classes Red and Blue. In this way, the Circle class is decoupled from the specific color implementation, and can work with any color that conforms to the Color protocol. This allows us to change the color of the Circle without changing the Circle class and also we can create new color without changing the Circle class.

// Example - Adapter Pattern

protocol Engine {
    func startEngine()
    func stopEngine()
}

class Car: Engine {
    func startEngine() {
        print("The car engine has started.")
    }
    func stopEngine() {
        print("The car engine has stopped.")
    }
}

class Bicycle {
    func pedal() {
        print("Pedaling the bicycle.")
    }
    func dontPedal() {
        print("Pedaling stopped.")
    }
}

class BicycleToEngineAdapter: Engine {
    private let bicycle: Bicycle
    init(_ bicycle: Bicycle) {
        self.bicycle = bicycle
    }
    func startEngine() {
        bicycle.pedal()
    }
    func stopEngine() {
        bicycle.dontPedal()
    }
}

let car = Car()
car.startEngine() // The car engine has started.
car.stopEngine() // The car engine has stopped.

let bicycle = Bicycle()
let bicycleToEngine = BicycleToEngineAdapter(bicycle)
bicycleToEngine.startEngine() // Pedaling the bicycle.
bicycleToEngine.stopEngine() // Stop pedaling


//In this example, Car class has methods startEngine() and stopEngine() which are used to start and stop the car engine. But in this case, we have a Bicycle which we want to use in place of the Car. So, we created an adapter class BicycleToEngineAdapter that conforms to the Engine protocol and wraps an instance of the Bicycle class. The adapter class BicycleToEngineAdapter has methods startEngine() and stopEngine() which are similar to Car class but it starts the engine by pedaling the bicycle and stop engine by not pedaling. Now, we can use BicycleToEngineAdapter object as it conforms to Engine protocol and can be used in place of Car object.
