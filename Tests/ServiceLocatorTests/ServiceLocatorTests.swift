//
//  ServiceLocatorTests.swift
//  ServiceLocatorTests
//
//  Created by Adil Hussain on 04/11/2019.
//  Copyright © 2021 Tazkiya Tech. All rights reserved.
//

import Testing
@testable import ServiceLocator

class ServiceLocatorTests {
    
    private let serviceLocator = ServiceLocator()
    
    @Test
    func addService_fails_when_a_service_of_the_same_type_is_already_registered() throws {
        // Given.
        try serviceLocator.addService("Service1")
        
        // When. / Then.
        let error = try #require(throws: ServiceLocatorError.self) {
            try serviceLocator.addService("Service2")
        }
        
        #expect(error.message == "Failed adding service. Service of type 'String' already exists.")
    }
    
    @Test
    func getServiceOfType_succeeds_when_a_service_of_the_given_type_is_registered() throws {
        // Given.
        let input = "A Service of type 'String'"
        try serviceLocator.addService(input)
        
        // When.
        let output = try serviceLocator.getServiceOfType(String.self)
        
        // Then.
        #expect(input == output)
    }
    
    @Test
    func getServiceOfType_fails_when_no_service_of_the_given_type_is_registered() throws {
        // When. / Then.
        let error = try #require(throws: ServiceLocatorError.self) {
            try serviceLocator.getServiceOfType(String.self)
        }
        
        #expect(error.message == "Failed getting service. Could not find service of type 'String'.")
    }
    
    @Test
    func addModule_succeeds_when_module_defines_services_which_have_different_types_to_services_already_registered() throws {
        // Given.
        let module = TestModule()
        
        try serviceLocator.addService(99.9)
        
        // When.
        try serviceLocator.addModule(module)
        
        // Then.
        #expect(try serviceLocator.getServiceOfType(Double.self) == 99.9)
        #expect(try serviceLocator.getServiceOfType(String.self) == "Some Service")
        #expect(try serviceLocator.getServiceOfType(Int.self) == 123456789)
    }
    
    @Test
    func addModule_fails_when_module_defines_a_service_which_has_the_same_type_as_a_service_already_registered() throws {
        // Given.
        try serviceLocator.addService("A Service of type 'String'")
        
        // When. / Then.
        let error = try #require(throws: ServiceLocatorError.self) {
            try serviceLocator.addModule(TestModule())
        }
        
        #expect(error.message == "Failed adding service. Service of type 'String' already exists.")
    }
    
    private class TestModule: Module {
        func registerServices(in serviceLocator: ServiceLocator) throws(ServiceLocatorError) {
            try serviceLocator.addService("Some Service")
            try serviceLocator.addService(123456789)
        }
    }
}
