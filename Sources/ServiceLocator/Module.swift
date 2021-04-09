//
//  Module.swift
//  ServiceLocator
//
//  Created by Adil Hussain on 08/11/2019.
//  Copyright © 2021 Tazkiya Tech. All rights reserved.
//

import Foundation

protocol Module {
    func getServices() -> [Any]
}
