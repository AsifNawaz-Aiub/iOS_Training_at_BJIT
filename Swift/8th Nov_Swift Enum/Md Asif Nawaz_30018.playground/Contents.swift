import UIKit



enum User : Equatable {
    case admin
    case moderator
    case member(role: Rank)
}

enum Rank{
    case expert
    case intermediate
    case beginner
}
let data: [String:User] = [ "A00123" : User.admin,
                            "M00111" : User.moderator,
                            "M00131" : User.moderator,
                            "U00113" : User.member(role: Rank.expert),
                            "U00422" : User.member(role: Rank.expert),
                            "U01608" : User.member(role: Rank.intermediate),
                            "U07712" : User.member(role: Rank.intermediate),
                            "U09002" : User.member(role: Rank.beginner) ]

func getUser(role : User, dataD : [String:User])-> [String]{
    var arr:[String] = []
    var  i:Int = 0
    for (key,value) in dataD{
        if value == role {
            arr.insert(key, at: i)
            i=i+1
        }
    }
    return arr
}
let results = getUser(role: User.member(role: Rank.intermediate), dataD : data)
print(results)


//let data: [String:User] = [ "A00123" : User.admin,
//                            "M00111" : User.moderator,
//                            "M00131" : User.moderator,
//                            "U00113" : User.member,
//                            "U00422" : User.member,
//                            "U01608" : User.member,
//                            "U07712" : User.member,
//                            "U09002" : User.member ]


//func getUser(role: User, dataD : [String:User])-> [String]{
//    var arr:[String] = []
//    var  i:Int = 0
//    for (key,value) in dataD{
//        if value == role {
//            arr.insert(key, at: i)
//            i=i+1
//        }
//    }
//    return arr
//}
//
//var res = getUser(role: User.member, dataD: data)
//print(res)



