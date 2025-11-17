//
//  ServiceLocatorError.swift
//  ServiceLocator
//
//  Created by Adil Hussain on 14/11/2025.
//

/// An error that occurred whilst adding or getting a service to/from a ``ServiceLocator`` object.
public struct ServiceLocatorError: Error {
    public let message: String
}
