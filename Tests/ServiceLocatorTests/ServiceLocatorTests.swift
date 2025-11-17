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
    func getServiceOfType_fails_when_no_service_of_the_given_type_is_registered() throws {
        // When. / Then.
        let error = try #require(throws: ServiceLocatorError.self) {
            try serviceLocator.getServiceOfType(String.self)
        }
        
        #expect(error.message == "Failed getting service. Could not find service of type 'String'.")
    }
    
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
    func adding_and_getting_service_of_primitive_type() throws {
        // Given.
        let input = "A Service of type 'String'"
        
        // When.
        try serviceLocator.addService(input)
        
        let output = try serviceLocator.getServiceOfType(String.self)
        
        // Then.
        #expect(input == output)
    }
    
    @Test
    func adding_and_getting_superclass_type_when_registration_type_is_not_specified() throws {
        // Given.
        let input = SomeSuperclass()
        
        // When.
        try serviceLocator.addService(input)
        
        let output = try serviceLocator.getServiceOfType(SomeSuperclass.self)
        
        // Then.
        #expect(input === output)
        
        // And.
        let error1 = try #require(throws: ServiceLocatorError.self) {
            try serviceLocator.getServiceOfType(SomeSubclass.self)
        }
        
        #expect(error1.message == "Failed getting service. Could not find service of type 'SomeSubclass'.")
        
        // And.
        let error2 = try #require(throws: ServiceLocatorError.self) {
            try serviceLocator.getServiceOfType(SomeProtocol.self)
        }
        
        #expect(error2.message == "Failed getting service. Could not find service of type 'SomeProtocol'.")
    }
    
    @Test
    func adding_and_getting_superclass_type_when_registration_type_is_specified() throws {
        // Given.
        let input = SomeSuperclass()
        
        // When.
        try serviceLocator.addService(input, as: SomeSuperclass.self)
        try serviceLocator.addService(input, as: SomeSubclass.self)
        try serviceLocator.addService(input, as: SomeProtocol.self)
        
        // Then.
        let output1 = try serviceLocator.getServiceOfType(SomeSuperclass.self)
        let output2 = try serviceLocator.getServiceOfType(SomeSubclass.self)
        let output3 = try serviceLocator.getServiceOfType(SomeProtocol.self)
        
        #expect(output1 === input)
        
        let downcastedOutput2 = try #require(output2 as? SomeSuperclass)
        #expect(downcastedOutput2 === input)
        
        let downcastedOutput3 = try #require(output3 as? SomeSuperclass)
        #expect(downcastedOutput3 === input)
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
    
    protocol SomeProtocol {}
    
    class SomeSubclass {}
    
    class SomeSuperclass: SomeSubclass, SomeProtocol {}
    
    private class TestModule: Module {
        func registerServices(in serviceLocator: ServiceLocator) throws(ServiceLocatorError) {
            try serviceLocator.addService("Some Service")
            try serviceLocator.addService(123456789)
        }
    }
}
