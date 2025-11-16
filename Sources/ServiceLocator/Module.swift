//
//  Module.swift
//  ServiceLocator
//
//  Created by Adil Hussain on 08/11/2019.
//  Copyright © 2021 Tazkiya Tech. All rights reserved.
//

import Foundation

/// Defines a group of services.
public protocol Module {
    
    /// Registers this module's services in the given ``ServiceLocator``.
    ///
    /// - Parameter serviceLocator: The ``ServiceLocator`` into which this ``Module`` is to register its services.
    /// - Throws: ``ServiceLocatorError`` if an error is encountered on registering or retrieving a service to/from the given ``ServiceLocator`` instance.
    func registerServices(in serviceLocator: ServiceLocator) throws(ServiceLocatorError)
}
