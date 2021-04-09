//
//  ServiceLocator.swift
//  ServiceLocator
//
//  Created by Adil Hussain on 09/09/2019.
//  Copyright © 2021 Tazkiya Tech. All rights reserved.
//

import Foundation

/// A simple in-memory bucket into which services (i.e. objects) can be registered and retrieved.
public class ServiceLocator {
    
    private var services = [ObjectIdentifier: Any]()
    
    public init() {}
    
    /// Obtains the service (i.e. object) of the specified type from this service locator.
    ///
    /// - Parameter type: the type of the service to obtain.
    /// - Throws: Throws an error if a service of the specified type does not exist in this service locator.
    /// - Returns: The service which is registered in this service locator matching the specified type.
    public func getServiceOfType<T>(_ type: T.Type) throws -> T {
        
        let serviceIdentifier = ObjectIdentifier(type)
        let service = services[serviceIdentifier]
        
        if (service == nil) {
            throw ServiceLocatorError.FailedGettingService("Could not find service of type '\(type)'")
        }
        
        return service as! T
    }
    
    /// Adds each of the services defined in the given module to this service locator.
    /// 
    /// - Parameter module: the module to add to this service locator.
    /// - Throws: Throws an error if the given module defines a service which has a type that is already registered in this service locator.
    public func addModule(_ module: Module) throws {
        try module.getServices().forEach { (service) in
            try addService(service)
        }
    }
    
    /// Adds the given service to this service locator.
    ///
    /// - Parameter service: The service to add to this service locator.
    /// - Throws: Throws an error if the type of the given service is the same as a service which is already registered in this service locator.
    public func addService(_ service: Any) throws {
        
        let serviceType = type(of: service)
        let serviceIdentifier = ObjectIdentifier(serviceType)
        
        if (services[serviceIdentifier] != nil) {
            throw ServiceLocatorError.FailedAddingService("Service of type '\(serviceType)' already exists")
        }
        
        services[serviceIdentifier] = service
    }
}

fileprivate enum ServiceLocatorError: Error {
    case FailedAddingService(_ message: String)
    case FailedGettingService(_ message: String)
}
