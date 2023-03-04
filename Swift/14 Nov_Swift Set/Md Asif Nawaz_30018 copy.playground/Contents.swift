import UIKit

// Md. Asif Nawaz 30018


//Question 1
//let inputAxis = (0,1)
//let (x,y) = inputAxis
//
//if x==0 && y==0 {
//    print("The point is located on the Origin")
//}
//else if (x != 0 && y == 0) {
//    print("The point is located on the X-axis")
//}
//else if (y != 0 && x == 0) {
//    print("The point is located on the Y-axis")
//}
//else if (x > 0 && y > 0) {
//    print("The point is located on the First Qquadrant")
//}
//else if (x < 0 && y > 0) {
//    print("The point is located on the Second Qquadrant")
//}
//else if (x < 0 && y < 0) {
//    print("The point is located on the Third Qquadrant")
//}
//else if (x > 0 && y < 0) {
//    print("The point is located on the Fourth Qquadrant")
//}
//
//
////Question 2
//let mark = 75
//switch mark {
//case 90...100:
//    print("A")
//case 83..<90:
//    print("B+")
//case 80..<83:
//    print("B")
//case 73..<80:
//    print("B")
//case 67..<73:
//    print("C")
//case 60..<67:
//    print("D")
//case 0..<60:
//    print("F")
//default:
//    print("")
//}
//
////Question 3
//// i
//let number = 7
//var i = 2
//if number == 0 || number == 1 {
//    print("It is not a prime number")
//}else{
//    var flag = false
//    while(i < number/2){
//        if(number % i == 0){
//          flag = true
//          break
//        }
//        i+=1
//    }
//    if !flag {
//        print("It is a prime number")
//    }else{
//        print("It is not a prime number")
//    }
//}
//
////ii
//
//let array = [1,2,3,4,5,6,7,8,9,10]
//var sum = 0
//for eachElement in array {
//    sum += eachElement
//}
//print(sum)
//
////iii
//
//let greens = [ "Rhaenyra": 32, "Daemon": 48, "Jacaerys": 15, "Lucerys": 14, "Joffrey": 12, "Aegon": 9, "Viserys": 7 ]
//
//var oldestAge = 0
//var oldestName = " "
//var youngestAge = Int.max
//var youngtestName = " "
//
//for (name,age) in greens{
//
//    if(age > oldestAge){
//        oldestAge = age
//        oldestName = name
//    }
//}
//for (name,age) in greens{
//
//    if(age < youngestAge){
//        youngestAge = age
//        youngtestName = name
//    }
//}
//
//
//print("Oldest Person --  \(oldestName) : \(oldestAge)")
//print("Youngest Person --  \(youngtestName) : \(youngestAge)")
//
//
////iv
//let cse475:Set = [10001,10002,10003, 10004, 10005, 10006, 10007]
//let cse488:Set = [10001,10005, 10006, 10009, 10015, 10005]
//
//print("Students Taking Both Courses \(cse475.intersection(cse488))")
//print("Students Taking only cse475 Course \(cse475.subtracting(cse488))")
//print("Students Taking only cse488 Course \(cse488.subtracting(cse475))")

var str:String! = "An implicitely unwrapped string"

let anotherStr:String = str

type(of: anotherStr)

let str2 = str

type(of: str2)



