import UIKit
//import Darwin

var serialMain = DispatchQueue (label: "com.demo.main-queue", attributes: .concurrent)
// main task 1
serialMain.async
{
    print("hsafdg")
    sleep(3)
    print ("hello from custom main-1")
//    let innerSerialQueue = DispatchQueue(label: "com.demo.serial-queue", attributes: .concurrent)
//    innerSerialQueue.async{
//        // return
//        //sleep(1)
//        print ("task 1 begin")
//        sleep(5)
//        print("task 1 end")
//    }
//    print ("hello 1")
//    innerSerialQueue.async{
//        print ("task 2 begin")
//        sleep(2)
//        print("task 2 end")
//    }
//    sleep(5)
//    print("hello 2")
    
}
// main task 2
serialMain.async{
    print ("hello from custom main")
}
