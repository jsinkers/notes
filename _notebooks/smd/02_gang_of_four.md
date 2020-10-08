---
title: Gang of Four Patterns
notebook: Software Modelling and Design
layout: note
date: 2020-10-07
tags: 
...

# Gang of Four Patterns

[TOC]: #

## Taxonomy

### Behavioural

### Creational

### Structural

## Adapter

- use the pattern name in the type name

__Problem:__ 
- how to resolve incompatible interfaces?
- how to provide a stable interface for similar components with different interfaces?

__Solution:__ Convert the original interface of a component into another interface through an intermediate
adapter object

__Implementation:__

![Object adapter](img/structure-object-adapter-2x.png)

_Example: airline flights_

```java 
// flight adapter interface
public interface IFlightAdapter {
    String from();
    String to();
    String departureTime();
    String arrivalTime();
}

public VirginFlightAdapter implements IFlightAdapter {
    // context maintained within the adapter
    VirginFlight flight;

    VirginFlightAdapter(VirginFlight flight) {
        this.flight = flight;
    }

    // implement methods of interface by calling services of VirginFlight
    public String from() {
        return flight.getDeparture();
    }
}

public QantasFlightAdapter implements IFlightAdapter { ... }

public JetstarFlightAdapter implements IFlightAdapter { ... }

// singleton factory to create adapters
public AirlineAdapterFactory {
     
    public static AirlineAdapterFactory getInstance() { ... }

    public IFlightAdapter getFlightAdapter(Object Flight) {
        // determine correct adapter to create
        if (flight instanceof VirginFlight) {
            return new VirginFlightAdapter(flight);
        } else if (...) {
            // ...
        }
    }
}
```

__Related:__ 
- resource adapter hiding an external system is similar to a Facade.  The point of difference is that 
  a resource adapter exists to permit adaptation to varying external interfaces, wrapping a single object,
  while a Facade wraps an entire subsystem
- may use a Factory to create Adapters

__Pros:__
- single responsibility principle: separation of interface/data conversion from primary business logic
- open/closed principle: you can add new adapters without breaking client code

__Cons:__
- increased complexity.  Might be easier to modify the service class


## Factory

- simple factory, concrete factory
- simplification of GoF _Abstract Factory_

__Problem:__ 
- who should be responsible for complex object creation? 
- how to maintain high cohesion so that objects used by a class don't need to be concerned with object creation?

__Solution:__ create a Factory, a Pure Fabrication, that handles object creation

__Implementation:__

__Related:__ 
- Factories are often accessed with the Singleton pattern

__Pros:__
- separate responsibility of complex creation into __cohesive__ helper objects
- hide complex creation logic
- can implement performance enhancing memory management e.g. object caching/recycling

__Cons:__
- additional complexity

## Singleton

__Problem:__ 
- need global access to an object to avoid large amounts of message passing, which could produce high coupling
- need exactly one instance of some object

__Solution:__ use a Singleton class which has only one instance, providing a global point of access through a static method
- why not simply make all service methods `static` methods of the class?
  - instance methods permit subclassing; static methods are not polymorphic and usually can't be overridden
  - OO remote communication methods (e.g. RMI) typically only support instance methods, rather than static ones
  - class may be useful in other contexts, where it need not be a singleton.  Instance methods therefore make it more
    flexible

__Implementation:__

```java
public class Singleton {
    private static instance = null;

    public static Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }
        return instance;
    }
}
```

__Related:__ 
- often used for Factory objects, Facade objects

__Pros:__
- solves the problems of global access and single instance
- lazy initialisation of the instance: you only construct a Singleton on request

__Cons:__
- violates single responsibility principle: solves global access/single instance at the same time
- can mask bad design: components may know too much about each other (high coupling)

## Strategy

__Problem:__ 
- how to design for varying but related algorithms?  
- how to allow runtime selection of these algorithms/policies?

__Solution:__ define each algorithm in a separate class, implementing a common interface

__Implementation:__
- a strategy object is passed the context object, which it uses to apply the algorithm

```java
public interface RouteStrategy {
    Route getRoute(Location A, Location B);
}

public class CycleStrategy implements RouteStrategy {
    public Route getRoute(Location A, Location B) {
        // get cycling route
        // ...
        return cycleRoute;
    }
}

public class BusStrategy implements RouteStrategy { ... }

public class TrainStrategy implements RouteStrategy { ... }
```

__Related:__ 
- strategies can be created by a Factory

__Pros:__
- strategy can be selected/changed at runtime
- provides __polymorphism__ to context object, which doesn't need to know particulars of the strategy, but simply
  uses the services of the interface
- provides __protected variations__, as algorithms are able to be modified without affecting the client
- open/closed principle: you are able to introduce new strategies without modifying the context

__Cons:__
- may be overly complicated when you have stable algorithms that are few in number
- clients still need to know how to select the correct algorithm
- anonymous functions may be a lightweight alternative

## Composite

__Problem:__ 

__Solution:__

__Implementation:__

__Related:__ 

__Pros:__

__Cons:__

## Facade

__Problem:__ 

__Solution:__

__Implementation:__

__Related:__ 

__Pros:__

__Cons:__

## Observer

__Problem:__ 

__Solution:__

__Implementation:__

__Related:__ 

__Pros:__

__Cons:__
