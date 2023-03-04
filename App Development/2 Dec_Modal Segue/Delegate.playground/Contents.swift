import UIKit

//struct Cookie {
//    var size:Int = 5
//    var hasChocolateChips:Bool = false
//}
//
//class Bakery {
//    func makeCookie(){
//        var cookie = Cookie()
//
//    }
//}

protocol AllocateMemory {
    func allocateMemory(memorySize: Int)
}
protocol DeallocateMemory {
    func deallocateMemory(memorySize: Int)
}
class Memory : AllocateMemory, DeallocateMemory {
    func deallocateMemory(memorySize: Int) {
        print("\(memorySize) Byte Memory has been Deallocated!")
    }
    func allocateMemory(memorySize: Int) {
        print("\(memorySize) Byte Memory has been allocated!")
    }
}

class OperatingSystem {

    var allocateMemoryDelegate : AllocateMemory?
    var deallocateMemoryDelegate: DeallocateMemory?
    
    func memoryManagement (memorySize: Int){
        allocateMemoryDelegate?.allocateMemory(memorySize: memorySize)
        print("Work is finished!")
        deallocateMemoryDelegate?.deallocateMemory(memorySize: memorySize)
    }
    
}

var os = OperatingSystem()
os.allocateMemoryDelegate = Memory()
os.deallocateMemoryDelegate = Memory()
os.memoryManagement(memorySize: 10)
