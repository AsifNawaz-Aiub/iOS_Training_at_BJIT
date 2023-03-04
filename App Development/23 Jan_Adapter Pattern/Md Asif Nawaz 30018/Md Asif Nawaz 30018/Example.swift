//
//  Example.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 23/1/23.
//

import Foundation

// The legacy class that we want to adapt
class LegacyClass {
    func legacyMethod() {
        print("Legacy method called")
    }
}

// The new interface that the legacy class should conform to
protocol NewProtocol {
    func newMethod()
}

// The adapter class that conforms to the new protocol and wraps an instance of the legacy class
class Adapter: NewProtocol {
    let legacyObject: LegacyClass

    init(_ legacyObject: LegacyClass) {
        self.legacyObject = legacyObject
    }

    func newMethod() {
        legacyObject.legacyMethod()
    }
}


//class main{
    // Usage
    let legacy = LegacyClass()
    let adapter = Adapter(legacy)
    //adapter.newMethod() // prints "Legacy method called"
//}
