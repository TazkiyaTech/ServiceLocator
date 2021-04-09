//
//  Inject.swift
//  ServiceLocator
//
//  Created by Adil Hussain on 09/04/2021.
//  Copyright © 2021 Tazkiya Tech. All rights reserved.
//

import Foundation

@propertyWrapper
struct Inject<T> {
    
    private let serviceLocator: ServiceLocator
    
    var wrappedValue: T {
        get {
            try! serviceLocator.getServiceOfType(T.self)
        }
    }
    
    init(via serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
}
