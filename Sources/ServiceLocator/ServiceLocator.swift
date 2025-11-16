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
    /// - Throws: ``ServiceLocatorError`` if a service of the specified type does not exist in this service locator.
    /// - Returns: The service which is registered in this service locator matching the specified type.
    public func getServiceOfType<T>(_ type: T.Type) throws(ServiceLocatorError) -> T {
        
        let serviceIdentifier = ObjectIdentifier(type)
        let service = services[serviceIdentifier]
        
        if (service == nil) {
            throw ServiceLocatorError(message: "Failed getting service. Could not find service of type '\(type)'.")
        }
        
        return service as! T
    }
    
    /// Adds each of the services defined in the given module to this service locator.
    /// 
    /// - Parameter module: the module to add to this service locator.
    /// - Throws: ``ServiceLocatorError`` if the given module defines a service which has a type that is already registered in this service locator.
    public func addModule(_ module: Module) throws(ServiceLocatorError) {
        try module.registerServices(in: self)
    }
    
    /// Adds the given service to this service locator.
    ///
    /// - Parameter service: The service to add to this service locator.
    /// - Throws: ``ServiceLocatorError`` if the type of the given service is the same as a service which is already registered in this service locator.
    public func addService(_ service: Any) throws(ServiceLocatorError) {
        
        let serviceType = type(of: service)
        let serviceIdentifier = ObjectIdentifier(serviceType)
        
        if (services[serviceIdentifier] != nil) {
            throw ServiceLocatorError(message: "Failed adding service. Service of type '\(serviceType)' already exists.")
        }
        
        services[serviceIdentifier] = service
    }
}


