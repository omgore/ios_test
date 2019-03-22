//
//  Observable.swift
//  ios_test
//
//  Created by Om Gore on 16/03/19.
//  Copyright © 2019 Om Gore. All rights reserved.
//

import UIKit

class Observable<T> {
    
    typealias EventListener = (T) -> Void
    
    var listener: EventListener?
    var value: T {
        didSet {
            listener?(self.value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    public func bind(listener: EventListener?) {
        self.listener = listener
    }
    
    public func bindAndFire(listener: EventListener?) {
        self.listener = listener
        self.listener?(value)
    }
    
}
