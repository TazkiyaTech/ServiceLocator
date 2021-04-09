//
//  ServiceLocatorUnitTest.swift
//  ServiceLocatorTests
//
//  Created by Adil Hussain on 04/11/2019.
//  Copyright © 2021 Tazkiya Tech. All rights reserved.
//

import XCTest
@testable import ServiceLocator

class ServiceLocatorTests: XCTestCase {
    
    private var serviceLocator: ServiceLocator!
    
    override func setUp() {
        super.setUp()
        serviceLocator = ServiceLocator()
    }
    
    func test_addService_fails_when_service_of_same_type_is_already_registered() throws {
        // Given.
        try serviceLocator.addService("Service1")
        
        // When.
        XCTAssertThrowsError(try serviceLocator.addService("Service2"))
    }
    
    func test_getServiceOfType_succeeds_when_desired_service_is_registered() throws {
        // Given.
        let input = "A Service of type 'String'"
        try serviceLocator.addService(input)
        
        // When.
        let output = try serviceLocator.getServiceOfType(String.self)
        
        // Then.
        XCTAssertEqual(input, output)
    }
    
    func test_getServiceOfType_fails_when_desired_service_is_not_registered() {
        // When. / Then.
        XCTAssertThrowsError(try serviceLocator.getServiceOfType(String.self))
    }
    
    func test_addModule_when_services_in_module_are_not_already_registered() throws {
        // Given.
        let module = TestModule()
        
        // When.
        try serviceLocator.addModule(module)
        
        // Then.
        XCTAssertEqual("Some Service", try serviceLocator.getServiceOfType(String.self))
        XCTAssertEqual(123456789, try serviceLocator.getServiceOfType(Int.self))
    }
    
    func test_addModule_when_service_in_module_is_already_registered() throws {
        // Given.
        let module = TestModule()
        
        try serviceLocator.addService("A Service of type 'String'")
        
        // When.
        XCTAssertThrowsError(try serviceLocator.addModule(module))
    }
    
    class TestModule: Module {
        func getServices() -> [Any] {
            return ["Some Service", 123456789]
        }
    }
}
