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
    
    /// - Returns: The services defined by this module.
    func getServices() -> [Any]
}
