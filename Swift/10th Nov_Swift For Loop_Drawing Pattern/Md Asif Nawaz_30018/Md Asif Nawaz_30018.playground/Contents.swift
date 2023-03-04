import UIKit

// Md. Asif Nawaz_30018

// 1
func addExclm (to : String)-> ()->(){
    var capturedString =  to
    func aNestedFun () -> () {
        capturedString = capturedString + "!"
        print(capturedString)
      
    }
    return aNestedFun
}

let sayHi = addExclm(to: "hello")
sayHi()
sayHi()
sayHi()

// 2

func drawPattern(using: String) -> ()->(String){
    var aString =  ""
    func draw () -> String{
        aString = using + aString
        return aString
    }
    return draw
}
let draw = drawPattern(using: "*")
for _ in 1...5 {
print(draw())
}


// 2 Bonus
func drawPatternBonus(using: String) -> (Int)->(String){
    
    var varUsing = using
    func draw (n:Int) -> String{
        var aString =  ""
        
        var j=1
        for _ in 0..<n-j {
            aString = aString + " "
        
        }
        
        for _ in 1...j {
            aString = aString + varUsing
        }
        varUsing = varUsing + using
        j=j+1
        
        return aString
    }
    return draw
}

let draw2 = drawPatternBonus(using: "*")

for i in (1...5).reversed(){
print(draw2(i))
}

//print(draw2(5))
//print(draw2(4))
//print(draw2(3))
//print(draw2(2))
//print(draw2(1))
