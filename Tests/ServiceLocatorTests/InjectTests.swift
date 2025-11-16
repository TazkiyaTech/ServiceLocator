//
//  InjectTests.swift
//  ServiceLocatorTests
//
//  Created by Adil Hussain on 09/04/2021.
//

import Testing
@testable import ServiceLocator

class InjectTests {
    
    @Inject(via: serviceLocator) private var someService: SomeService
    
    @Test
    func inject() {
        #expect(someService.execute() == "Executed")
    }
}

nonisolated(unsafe) private let serviceLocator: ServiceLocator = {
    let serviceLocator = ServiceLocator()
    
    try! serviceLocator.addService(SomeService())
    
    return serviceLocator
}()

private class SomeService {
    func execute() -> String { "Executed" }
}
