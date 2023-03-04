import UIKit
import Dispatch
//struct IntStack {
//
//    var items : [Int] = []
//
//    mutating func push (_ item: Int){
//        items.insert(item, at: 0)
//    }
//    mutating func pop () -> Int{
//        return items.removeFirst()
//    }
//}
//
//var stack = IntStack()
//
//stack.push(1)
//stack.push(2)
//stack.pop()
//
//enum SomeEnum //: Equatable
//{
//    case a (Int)
//    case b (String)
//}
//protocol SomeProtocol
//{
//    associatedtype Element
//}
//
//extension SomeProtocol where Element: Equatable {
//
//    func isEquatable()-> Bool {
//      return true
//    }
//
//}
//struct SomeStruct<T>: SomeProtocol {
//    typealias Element = T
//}
//
//
//let something = SomeStruct<SomeEnum>()
//
////something.isEquatable
//
//let concurrentQueue = DispatchQueue (label :"com.demo.concurrent-queue", attributes:.concurrent)
//
//concurrentQueue.async{
//print("Task executed from custom concurrent queue3")
//}
//
//DispatchQueue (label :"com. demo. serial-queue") .async {
//print ("Task executed from custom serial queue1")
//}
//
//let serialQueue = DispatchQueue (label: "com.demo.serial-queue")
//
//serialQueue.async{
//print("Task executed from custom serial queue2")
//}
//
//
//var sum = 0
//DispatchQueue.global().async {for i in 0..<10 {
//    print(i)
//    DispatchQueue.global().sync{
//        sleep(5)
//        print("Task 1 completed")
//
//    }
//    //sum = sum + i
//}}
//
//DispatchQueue.global().async {for i in 10..<20{
//    print(i)
//    //print("Sum-", sum)
//}}
//
//DispatchQueue.global().async {for i in 20..<30 {
//    print(i)
//
//}}

let jsonArray = [
    ["stageId": 1, "name": "John"],
    ["stageId": 2, "name": "Jane"],
    ["stageId": 1, "name": "Jim"],
    ["stageId": 2, "name": "Jack"]
]

let groupedDictionary = Dictionary(grouping: jsonArray) { element in
    return element["stageId"] as! Int
}
print(groupedDictionary)
let result = groupedDictionary.map { group in
    return group.value.last!
}
print(result)
