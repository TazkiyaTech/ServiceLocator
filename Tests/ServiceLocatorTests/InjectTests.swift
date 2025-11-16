//
//  InjectTests.swift
//  ServiceLocatorTests
//
//  Created by Adil Hussain on 09/04/2021.
//

import Testing
@testable import ServiceLocator

@MainActor
class InjectTests {
    
    @Inject(via: serviceLocator) var someService: SomeService
    
    @Test
    func inject() {
        #expect(someService.execute() == "Executed")
    }
}

@MainActor
let serviceLocator: ServiceLocator = {
    let serviceLocator = ServiceLocator()
    
    try! serviceLocator.addService(SomeService())
    
    return serviceLocator
}()

class SomeService {
    func execute() -> String { "Executed" }
}
