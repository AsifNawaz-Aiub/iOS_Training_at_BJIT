import UIKit
// asif.nawaz@bjitacademy.com
// Md. Asif Nawaz_30018

// 2
extension String {
    
    func isPallindrome ()-> Bool{
        
        for _ in 0..<self.count {
            
        }
      
        
        return true
    }
}
let str1 = "civic"
str1.isPallindrome()


// 3
protocol QueueProtocol  {
    associatedtype T
    var queue: [T]{get set}
    func isEmpty()-> Bool
    mutating func enqueue(val :T)
    mutating func dequeue()-> T?
    func peek()-> T
    //func isHead(val:T)-> Bool
}
extension QueueProtocol  {
    func isEmpty()-> Bool {
        if queue.isEmpty {
            return true
        }else {return false}
    }
   mutating func enqueue(val :T) {
        queue.append(val)
    }
    mutating func dequeue()->T? {
        if isEmpty() {
            return nil
        }
        return queue.removeFirst()
    }
    func peek ()->T{
        return queue[0]
    }
//    func isHead(val:T)-> Bool{
//        if queue[0] == val{
//
//        }
//    }
}
struct Queue<Elements> : QueueProtocol {
    var queue: [Elements] = []
    typealias T = Elements
    
}
var queue1 = Queue<Double>()
queue1.enqueue(val :4.2)
queue1.enqueue(val :5.1)
print(queue1.dequeue()!)


// 1

class Vehicle {
    var name: String
    
    func printVehicleDesctription(){
        print("This is general vehical")
    }
    
    init (name: String){
        self.name = name
    }
}

class Bike : Vehicle {
    var wheels : Int
    var owners : [String] = ["Asif", "Nawaz"]
    init(name: String ,wheels: Int) {
         self.wheels =  wheels
         super.init(name: name)
    }
    override func printVehicleDesctription() {
        print("This is a Bike")
    }
    
    subscript(i :Int)-> String{
            return owners[i]
        
    }
    
    func getOwnerByIndex(i : Int)throws -> String {
        do{
         try owners[i]
        }catch {
            return "Out of index, no owner found"
        }
        return owners[i]
    }
}
