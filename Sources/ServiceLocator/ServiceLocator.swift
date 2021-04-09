//
//  ServiceLocator.swift
//  ServiceLocator
//
//  Created by Adil Hussain on 09/09/2019.
//  Copyright © 2021 Tazkiya Tech. All rights reserved.
//

import Foundation

class ServiceLocator {
    
    private var services = [ObjectIdentifier: Any]()
    
    func getServiceOfType<T>(_ type: T.Type) throws -> T {
        
        let serviceIdentifier = ObjectIdentifier(type)
        let service = services[serviceIdentifier]
        
        if (service == nil) {
            throw ServiceLocatorError.FailedGettingService("Could not find service of type '\(type)'")
        }
        
        return service as! T
    }
    
    func addModule(_ module: Module) throws {
        try module.getServices().forEach { (service) in
            try addService(service)
        }
    }
    
    func addService(_ service: Any) throws {
        
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
