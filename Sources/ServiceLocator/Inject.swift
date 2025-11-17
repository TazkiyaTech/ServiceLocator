//
//  Inject.swift
//  ServiceLocator
//
//  Created by Adil Hussain on 09/04/2021.
//  Copyright © 2021 Tazkiya Tech. All rights reserved.
//

import Foundation


/// A convenience property wrapper which makes it easier to pull out services from a ``ServiceLocator`` object.
///
/// Without this property wrapper, you would define properties in your view controller and test classes as follows:
///
/// ```
/// var someService: SomeService {
///     try! serviceLocator.getServiceOfType(SomeService.self)
/// }
/// ```
///
/// With this property wrapper, you can instead define properties as a one-liner as follows:
///
/// ```
/// @Inject(via: serviceLocator) var someService: SomeService
/// ```
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
