import UIKit

var greeting = "Hello, playground"

// 1
func strChecker (str1: String, str2:String)->Bool{
    
    //var flag = false
    var strOne: Set<Character> = []
    var strTwo: Set<Character> = []
    for eachChar1 in str1 {
        strOne.insert(eachChar1)
    }
    for eachChar2 in str2 {
        strTwo.insert(eachChar2)
    }
    
    let res =  strOne.symmetricDifference(strTwo)
    if res.isEmpty {
        return true
    }else{
        return false
    }
    
}



print(strChecker(str1: "abcd", str2: "abc"))



//2

//func combine(arr1:[Int],arr2:[Int]){ $0, $1 -> [Int] in
//    ($0 * $1) * ($0 * $1)
//}
//
//var arr1 = [1,2,3,4]
//var arr2 = [5,5,5,3]
//let result = combine(arr1,arr2) {
//    ($0 * $1) * ($0 * $1)
//}

//3
enum Faction:Equatable {
    case greens
    case blacks
}
let houses: [String: Faction] = [
    "Baratheon" : .greens,
    "Stark" : .blacks,
    "Hightower" : .greens,
    "Velaryon" : .blacks,
    "Lannister" : .greens,
    "Arryn" : .blacks
]

//func getLoyalists(fac:Faction, dict: [String: Faction]) ->()->[String]{
//    func aFun () -> String{
//        var arr:[String] = []
//        for (key, val) in dict {
//            if val == fac {
//                arr.append(key)
//            }
//        }
//        return arr
//    }
//    return aFun
//}



