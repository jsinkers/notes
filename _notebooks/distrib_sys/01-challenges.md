---
title: Distributed Systems - Challenges
notebook: Distributed Systems
layout: note
date: 2020-08-12
tags: 
...

[TOC]: #

## Table of Contents


## Distributed Systems 

- __distributed systems__
  - networked system components communicate and coordinate actions through message passing alone
  - collection of independent computers that appears to users as a single, coherent system
- key points
  - _multiple_ components in the system
  - _communication_ between components
  - _synergy_ between components, such that they achieve more than the sum of individual components

### Computer Networks vs Distributed Systems

- computer network: independent, interconnected computers that exchange messages based on particular
  protocols
- distributed system: multiple computers on the network __collaborating__ as a system.  Spatial 
  separation and communication aspects are hidden from users

### Benefits

- __resource sharing__
  - hardware: disks, printers, scanners
  - software: files, databases
  - other: processing power, memory, bandwidth
- __benefits of resource sharing__
  - economy
  - availability
  - reliability
  - scalability

### Consequences

- __concurrency:__ services provided by DS will be accessed by multiple users simultaneously
  - system design needs to account for this use case, and implement concurrency techniques
- __no global clock:__ 
  - individual computers have independent clocks
  - limits to the degree of clock synchronisation as all communication is via message passing
  - system design needs to handle absence of global clock, and implement synchronisation techniques
- __independent failures:__ some components may fail while others continue to run
  - failure of some components will not be known immediately by others

## Wireless networks

Paradigms making heavy use of wireless networks:

- __Mobile/nomadic computing:__ users can perform computing tasks on the move,
  while being part of a DS
- __Ubiquitous computing:__ small, cheap embedded computing devices used as part of a DS
- __IoT:__ everyday objects are addressable and connected to the Internet.

# Challenges

## Heterogeneity

- disparate hardware and software.  Big challenge
- e.g. different browsers implement many different features
- variation in:
  - networks
  - computer hardware
    - e.g. representation of integer data types: big endian/little endian
  - operating systems: different system calls
  - programming languages
  - implementations by different developers

### Approaches

  - standard protocols
  - agreed upon message formats and data types
  - adhering to an API
  - using middleware
  - portable code (Java)

### Middleware

- __middleware:__ software layer between distributed application and OS
  - provides programming abstraction
  - masks heterogeneity of underlying resources (hardware, OS, ...)
- may only address a subset of heterogeneity issues
- e.g. Java RMI doesn't address programming language heterogeneity 

#### Middleware models

- Distributed file systems
- RPC (procedural languages)
- RMI (OO languages)
- distributed documents
- distributed databases

### Mobile Code

- __mobile code__ is sent from one computer to another to be run at the destination
  - e.g. Java applets
- code compiled in one OS doesn't run on another architecture, OS
- __Virtual machine__ approach: compiler produces code interpreted by the VM, allowing code
  executable on any hardware
- cross-platform compilation also works

## Openness

- __openness:__ ability to extend the system by adding hardware/software resources
- e.g. Skype: closed
- e.g. Internet: open protocols has allowed it to scale

### Approaches

- publish key interfaces
- ensure all implementations adhere to published standards

## Security

- __Confidentiality__: protection against disclosure to unauthorised individuals
- __Integrity:__ protection against alteration/corruption
- __Availability:__ protection against interference with means of access (e.g. DoS)
  - measure of proportion of time system is available for use 

- security against mobile code: executables as attachments

### Approaches

- encryption (e.g. RSA)
- authentication (e.g. passwords, public key authentication)
- authorisation (e.g. Access control lists)

## Scalability

- __scalability:__ ability to handle growth of number of users 

- __controlling cost of resources:__ ideally scales linearly with number of users
  - always will have some overhead to manage resources
- __controlling performance loss:__ dependent on underlying distributed algorithms
  - $O(n^2)$ would not be scalable
  - $O(\log{n})$ is scalable
- __preventing resources running out:__ e.g. IPv4 addresses; use of particular data types
- __avoiding performance bottlenecks:__ resolved with decentralised architectures/algorithms

## Failure Handling

- __detection__: 
  - some failures can be detected e.g. with checksums 
  - others are hard to be certain of, e.g. remote server failure
- __masking__: hide/ameliorate effects of failure
  - e.g. message retransmission after timeout
  - e.g. Zoom may mask errors by interpolating frames
- __tolerating__: sometimes better to tolerate errors, rather than try to handle them
  - e.g. render video with a frame dropped, or report failure to user
- __recovery__: ability to rollback if failure produces corrupted data
- __redundancy__: tolerate failure through redundancy
  - __failover:__ multiple servers provide the same service

## Concurrency

- multiple clients accessing a shared resource at the same time
- sequential access could handle it but slows down system
- semaphores used by OS to handle concurrency
- e.g. starting up a system also poses concurrency issues: comment that if all
  of Google was switched off it couldn't be restarted

## Transparency

- hiding components of distributed system from user and application programmer
  - system doing something at a lower level that isn't seen by the user
- e.g. on a mobile phone, while moving around, the hardware will change between
  cells and frequencies without user being aware of it
- sometimes you don't want transparency: some failures need to involve the user e.g. if
  the Ethernet cable is unplugged

- __network transparency:__ combination of access/location transparency.  Most important: strongly
  affects utilisation of distributed resources 
  - e.g. email address `username@domain.com`: consists of username and domain name.  To send mail
    you don't need to know physical/network location of mail server, and it is independent of the
    location of the recipient
- __access transparency__: e.g. distributed file system.  API you use to access
  files locally should be the same as the API you use to access remotely.  That way
  applications don't need to change depending on whether you're accessing locally/remotely.  
  - e.g. GUI with folders behaves/looks the same whether files are local or remote
- __location transparency:__ access resources without knowledge of physical/network location
- __mobile transparency:__ movement of resources/clients in a system without affecting operation of
  users or programs
  - e.g. moving between cell towers while on a phone call: participants are unaware of change
- Note: __location transparency__ is more about server side-changes, while __mobile transparency__ is more about client-side changes
- __concurrency transparency:__ several processes can operate concurrently on shared resources 
  without interference
- __replication transparency:__ multiple resource instances can be used for reliability and 
  performance without knowledge of replicas by users/application programmers
- __failure transparency:__ concealment of faults, so that users can complete their tasks despite
  failures
- __performance transparency:__ reconfiguration of system to improve performance as load varies
- __scaling transparency:__ allows system to expand in scale without change to system structure
  or applications

## Quality of Service

- main non-functional properties:
  - reliability
  - security
  - performance
  - adaptability
  - availability

## Web Services and APIs

- __web services:__ allows programs (other than browsers) to be clients for web programs
- data passed as XML/JSON
- __SOAP protocol__ allows clients to invoke web services (XML format)
- __REST (REpresentational State Transfer) architecture:__

