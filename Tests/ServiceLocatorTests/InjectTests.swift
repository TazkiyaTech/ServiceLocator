//
//  File.swift
//  
//
//  Created by Adil Hussain on 09/04/2021.
//

import XCTest
@testable import ServiceLocator

class InjectTests: XCTestCase {
    
    @Inject(via: serviceLocator) var someService: SomeService
    
    func test_inject() {
        XCTAssertEqual("Executed", someService.execute())
    }
}

var serviceLocator: ServiceLocator = {
    let serviceLocator = ServiceLocator()
    
    try! serviceLocator.addService(SomeService())
    
    return serviceLocator
}()

class SomeService {
    func execute() -> String { "Executed" }
}
