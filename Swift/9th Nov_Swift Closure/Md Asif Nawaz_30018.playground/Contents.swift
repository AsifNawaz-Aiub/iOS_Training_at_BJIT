import UIKit
import Foundation

// Name - Md. Asif Nawaz_30018

//1

enum Operation {
    case sum
    case sub
    case mul
    case div
    
}

func chooseMathFunc(operationEnum : Operation)-> (Double,Double)-> (Double){
    
    func sum(a: Double, b:Double)-> Double{
        return a+b
    }
    func sub(a: Double, b:Double)-> Double{
        return a-b
    }
    func mul(a: Double, b:Double)-> Double{
        return a*b
    }
    func div(a: Double, b:Double)-> Double{
        return a/b
    }
    if operationEnum == Operation.sum {return sum}
    else if operationEnum == Operation.sub {return sub}
    else if operationEnum == Operation.mul {return mul}
    else {return div}
    
    
}

func  performOperation (a: Double, b:Double, operationEnum: Operation )-> Double{
    let selectedFunc = chooseMathFunc(operationEnum: operationEnum)
    let res = selectedFunc(a,b)
    return res
}

performOperation(a: 10.00, b: 5.00, operationEnum: Operation.sum)
performOperation(a: 10.00, b: 5.00, operationEnum: Operation.sub)
performOperation(a: 10.00, b: 5.00, operationEnum: Operation.mul)
performOperation(a: 10.00, b: 5.00, operationEnum: Operation.div)



// 2

func longRunningTask(completion: () -> ()) {
    var count = 0
    
    for _ in 0..<100000{ count += 1 }
    completion()
    
}

func notify() {
    print("long running task was finished")
    
}


for i in 1...5 {
    //longRunningTask(completion: notify)
    
    longRunningTask{
        print("task completed \(i) time(s)")
    }
    
}
