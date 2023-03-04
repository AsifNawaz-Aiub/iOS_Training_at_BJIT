//
//  Observable.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 26/1/23.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    private var listener: ((T) -> Void)?
    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
    }
}
