import UIKit

// Md. Asif Nawaz - 30018


//1

func convertAndSum (str1:String, str2:String)-> Int?{
    
    let n1:Int? = Int(str1)
    let n2:Int? = Int(str2)
    
    if let n1 = n1, let n2 = n2 {
        let sum = n1+n2
        return sum
    }
        return nil
    
}
    
convertAndSum(str1:"50",str2:"50")
convertAndSum(str1:"abcd",str2:"50")

//2

let blacks = [
"Rhaenyra": 32,
"Daemon": 48,
"Jacaerys": 15,
"Lucerys": 14,
"Joffrey": 12,
"Aegon": 9,
"Viserys": 7 ]

func search(str:String,blacks:[String:Int]) {
    
    let foundValue:Int? = blacks[str]
    
    guard let foundValue = foundValue else{
        print("person not found")
        return
    }
    print(foundValue)
    
    return
}
search(str:"Aegon", blacks: blacks)
search(str:"Aegon1", blacks: blacks)


//3

func postData(email:String?, subject:String?, comment:String?){
    
    guard let email = email,let comment = comment else {
        print("Email and Subject Feild Is Required")
        return
    }
    let subject = subject ?? "General Query"
    print(email)
    print(subject)
    print(comment)
    return
}

postData(email: "Eamil", subject: nil, comment: "Comment")


//7

func twoInt(num1: Int, num2:Int)->Int?{
    
    if num1 % num2 != 0{
        return nil
    }
    return num1/num2
}

let result:Int? = twoInt(num1:100,num2:5)

if let result = result {
    print(result)
}

