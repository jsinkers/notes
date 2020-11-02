---
title: Summary
notebook: Software Modelling and Design
layout: note
date: 2020-10-07
tags: 
...

# Summary

## Table of Contents


## Use Cases

- __use case__: informally: text story of an actor using a system to meet goals
  - emphasises user goals and perspective
    - who is using the system?
    - what are their typical scenarios of use?
    - what are their goals?
  - formally: collection of related success/failure scenarios that describe an actor using the SuD to 
    support a goal
  - primarily capture functional requirements
  - define a contract of how a system will behave
- __SuD:__ system under discussion
- __actor:__ something with behaviour; e.g. person, computer system, organisation
- __scenario/use case instance:__ specific sequence of actions/interactions between actors and SuD

### Level of Detail 

- __brief:__ terse one-paragraph summary of the main success scenario
- __casual:__ informal multi-paragraph format covering various scenarios
- __fully dressed:__ formal writing of each step and variations in detail, with supporting material

### Use case variants

- __main success scenario:__ ideal use case; mandatory element
  - "happy path", typical flow
  - usually has no conditions/branching
- __alternative scenario:__ optional, enhances understanding, provides some alternative behaviour
  - covered in Extensions section when fully dressed

### Actors

- __primary actor:__ has user goals fulfilled through using services of SuD
- __supporting actor:__ provides a service to SuD to clarify external interfaces/protocols
  - typically a computer system (e.g. payment authorisation system) but can be an organisation or person
- __offstage actor:__ has an interest in behaviour of the use case, but is not primary/supporting
  - e.g. tax agency
  - important to include to ensure all stakeholder requirements are captured

### Importance

- influences design, implementation, project management
- key source of information for OO analysis/testing
- use cases should be strongly driven by project goals

### Use case Model

- __Use case model:__ model of system functionality/environment
  - _primarily:_ set of _written_ use cases
  - _optionally:_ includes UML use case diagram

### Use case Diagram

- show primary actors on LHS
- show supporting actors on RHS

![Use case diagram](img/use-case-diagram.png)

![Use case notation](img/use-case-notation.png)

### Relevance of Use cases

To check whether use-cases are at the right level for application requirements analysis, you can apply a number of tests.

- __Boss test:__ your boss must be happy if, when asking you what you have been doing, you respond with the use case
- __Elementary business process test:__ a value-adding process undertaken by one person in one location in response to a business event
- __Size test:__ tasks shouldn't be a single step.  They shouldn't be too many steps.
  - Fully dressed: 3-10 pages

__Example:__

- negotiate a supplier contract: much broader/longer than an EBP
- handle returns: OK with the boss.  Seems like EBP.  Good size.
- Log in: fails boss test
- Move piece on game board: single step - fails size test.

### Include relationship

- used to reduce repetition in multiple use cases
- refactor common part of use cases into subfunction use case

```text
Extensions: 

6b. Paying by credit: Include Handle Credit Payment.

```

![Use case include relationship](img/use-case-include.png)

### Extend relationship

- used to add new extensions/conditional steps to a use case
  - base case is complete without the extension
  - extension relies on base case
  - base case doesn't know about extension
- extension analogous to wrapper or subclass
- used infrequently: most often when you cannot modify the original
- where possible, modify use case text instead

![Use case extend and include](img/use-case-extends.png)

## OO Analysis

- __OO analysis:__ creating description of domain from OO perspective
  - analyse use cases and identify objects/concepts in problem domain
  - concepts/behaviours captured in Domain models and Sequence diagrams
  - abstract level of intention
  - intended to help understand the domain
- domain models and system sequence diagrams are the primary artifacts

## Domain Models

- __domain model:__ representation of real-situation conceptual classes
  - not a software object
  - shows noteworthy domain concepts/objects
  - is an OO artifact
  - focus on explaining things and products important to the particular business domain
- represented visually using UML class diagram: show conceptual classes, attributes and associations
- __no method signatures__ defined
- visual dictionary of noteworthy abstractions, domain vocabulary, information content of the domain
- should be recognisable to a non-programmer from the domain
- captures __static context__ of system
- attribute or class?
  - if X not considered a number/text in the real world, X is probably a conceptual class, not
    an attribute
- don't use attributes as foreign keys: show the association

### Identifying conceptual classes

Approaches:

- noun phrase analysis: use carefully, but often suggestive
- use published category list/existing models for common domains

### Associations

- __association:__ relationship between classes indicating a meaningful/interesting connection
- include associations when
  - significant in the domain
  - knowledge of the relationship needs to be preserved

### Attributes

- __attribute:__ logical data value of an object
- include when requirements suggest a need to remember information
- do not show visibility: this is a design detail

### Creating a Domain Model

1. find conceptual classes
2. draw as classes in UML class diagram
3. add associations and attributes

### Description Class

- __description class:__ contains information that describes something else
- used when:
  - groups of items share the same description
  - items need to be described, even when there are currently no instances

![Description class example 1](img/description-class-1.png)

![Description class example 2](img/description-class-2.png)

## System Sequence Diagrams

- __system sequence diagram:__ shows chronology of system events generated by external actors
- captures __dynamic context of system__ 
- one SSD for one scenario of a use case
- helps identify external input events to the system (i.e. system events)
- indicates events design needs to handle 
- treat system as a black box: describe what it does without describing implementation details
- choose system events that don't tie you to an implementation
  - events should remain abstract: show intent, not the means
  - e.g. `enterItem` better than `scan`
- all external actors (human or not) for the scenario are shown
- can show inter-system interactions, e.g. POS to external credit payment authoriser

![System Sequence Diagram](img/system-sequence-diagram.png)

## Object-Oriented Design Models

### OO Domain Models

- __Analysis:__ investigation of problem and requirements
- __OO Software Analysis:__ finding and describes objects/concepts in the problem __domain__

### OO Design Models

- __Design:__ conceptual solution that meets the requirements of the problem
- __OO Software Design:__ defining software objects and their collaboration

### OO Implementation 

- __Implementation:__ concrete solution that meets the requirements of the problem
- __OO Software Implementation:__ implementation in OO languages and technologies

### Input Artifacts to OO design

- __Use case text__ describes functional requirements that design models must realise
- __Domain models__ provide inspiration for software objects in design models
- __System sequence Diagram__ indicates an interaction between users and system

### OO Software Design

- process of creating conceptual solution: defining software objects and their collaboration
- __architecture__
- __interfaces__: methods, data types, protocols
- assignment of __responsibilities__: principles and patterns

### Output Artifacts of OOSD

- Static model: Design class diagram
- Dynamic model: Design sequence diagram

## Static Design Models

- __static design model:__ representation of software objects, defining class names, attributes
  and method signatures
  - visualised via UML class diagram, called __design class diagram__ 

### Comparison to Domain models

- Domain model: conceptual perspective
  - noteworthy concepts, attributes, associations in the domain
- Design model: implementation perspective
  - roles and collaborations of software objects
- Domain models __inspire__ design models to __reduce the representational gap__
  - talk the same language in software and domain

## Dynamic Design Models

- __dynamic design model:__ representation of how software objects __interact__ via messages
  - visualised as __UML Sequence diagram__ or __UML Communication diagram__
- __Design Sequence diagram:__ illustrates sequence/time ordering of messages between software
  objects
  - helpful in assigning responsibilities to software objects

### SSD vs DSD

- System Sequence Diagram treats the system as a black box, focusing on interactions between 
  actors and the system
- Design sequence diagram illustrates behaviours __within__ the system, focusing on interaction
  between software objects

### Lifeline Notation

![Lifeline Notation](img/dsd-lifeline-notation.png)

### Reference frames

![Reference Frames](img/uml-reference-frames.png)

### Loop frames

![Loop Frame](img/uml-loop-frame.png)

## Visibility

- __visibility:__ ability of an object to see/refer to another object
- objects require visibility of each other in order to cooperate
- e.g. for `A` to send a message to `B`, `B` must be visible to `A`

### Achieving visibility

`A` can get visibility of `B` in 1 of 4 ways:

1. `B` is an attribute of `A`
2. `B` is a parameter of a method of `A`
3. `B` is a (non-parameter) local object in a method of `A`
4. `B` has global visibility

## Translating design models to code

- build least-coupled classes first, as more highly coupled classes will depend on these
- use `Map` for key-based lookup
- use `List` for growing ordered list
- declare variable in terms of the interface (e.g. `Map` over `HashMap`)

## 
