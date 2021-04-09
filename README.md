# ServiceLocator

Swift package offering a simple in-memory bucket into which services (i.e. objects) can be registered and retrieved.

## Installation

1. Add this Swift package to your Xcode project's list of Swift packages by means of this repo's URL.
2. Select the target(s) that you would like to add this Swift package to.

## Usage

The purpose of this Swift package is to offer a means by which an application can initialise and register all of its services into an in-memory bucket at start-up and then obtain these services later in the application's view controllers and integration tests without the view controllers and integration tests having to concern themselves with the details of how these services are initialised.

The main class offered by this Swift package is the [ServiceLocator](Sources/ServiceLocator/ServiceLocator.swift) class. This class defines three methods as follows:

* `addService(service:)` – Adds the given service to the service locator.
* `addModule(module:)` – Adds each of the services defined in the given [Module](Sources/ServiceLocator/Module.swift) to the service locator.
* `getServiceOfType(type:)` – Gets the service of the specified type from the service locator.

### Registering services

Let's assume we're going to register services into the service locator grouped by modules rather than registering services into the service locator individually. Let's assume also, for the purposes of example, that our application consists of two modules – `ModuleA` and `ModuleB` – and `ModuleA` defines a service which a service in `ModuleB` depends on. Then, firstly, `ModuleA` will look something like:

```
import ServiceLocator

class ModuleA: Module {
    func getServices() -> [Any] {
        return [ServiceA()]
    }
}
```

Secondly, `ModuleB` will look something like this:

```
import ServiceLocator

class ModuleB: Module {
    private let serviceLocator: ServiceLocator

    init(_ serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }

    func getServices() -> [Any] {
        let serviceA = try! serviceLocator.getServiceOfType(ServiceA.self)
        let serviceB = ServiceB(serviceA)
    
        return [serviceB]
    }
}
```

Lastly, the `ServiceLocator` object will be defined as follows:

```
let serviceLocator = ServiceLocator()

try serviceLocator.addModule(ModuleA())
try serviceLocator.addModule(ModuleB(serviceLocator))
```

### Retrieving services

The only two places where services should be sought out from a `ServiceLocator` object (once it has been defined and all services have been added to it) are the application's view controllers and test classes. All other calls to the `ServiceLocator.getServiceOfType(type:)` method are considered an abuse.

Assuming the presence of a `ServiceLocator` object named `serviceLocator` in a view controller or test class, a service is retrieved from the service locator as follows:

```
@Inject(via: serviceLocator) var someService: SomeService
```
