//
//  Inject.swift
//  ServiceLocator
//
//  Created by Adil Hussain on 09/04/2021.
//  Copyright © 2021 Tazkiya Tech. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Inject<T> {
    
    private let serviceLocator: ServiceLocator
    
    public var wrappedValue: T {
        get {
            try! serviceLocator.getServiceOfType(T.self)
        }
    }
    
    public init(via serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
}
