---
title: "Internet: Protocols and Service Models"
notebook: Computer Systems
layout: note
date: 2020-03-03 16:14
tags: 
...

# Intro to internet/layers

[TOC]: #

## Table of Contents
- [History](#history)
- [Outcome](#outcome)
- [Network Models](#network-models)
- [Connection-oriented vs connectionless](#connection-oriented-vs-connectionless)
- [TCP/IP vs OSI](#tcpip-vs-osi)
- [OSI philosophy](#osi-philosophy)
- [OSI model](#osi-model)
- [TCP/IP model](#tcpip-model)
- [Protocol Stack](#protocol-stack)
- [Internet by nuts and bolts](#internet-by-nuts-and-bolts)
  - [ISPs](#isps)
  - [Protocols](#protocols)
- [Internet by services](#internet-by-services)
- [Protocol Layers](#protocol-layers)
- [IP Stack](#ip-stack)
  - [Application Layer](#application-layer)
  - [Transport Layer](#transport-layer)
  - [Network Layer](#network-layer)
  - [Link Layer](#link-layer)
  - [Physical Layer](#physical-layer)
- [OSI Model](#osi-model-1)
  - [Presentation layer](#presentation-layer)
  - [Session Layer](#session-layer)
- [Encapsulation](#encapsulation)

Readings
[x] K&R 1.1, 1.5


- aggregation of many smaller networks
- history in 3 phases
  - 60s-70s: ARPANET
  - 70s-80s: NSFNET
  - 80s: on Internet
- social media + Web 2.0: individual users can add content

![]()
- Tier 1 ISP: guarantees routing of packet

## History

- multiple teams with opposing approaches and philosophies
- *ARPANET*
  - funded by US DoD
  - developed TCP/IP
  - robustness built in due to unreliable communication links
- international network working group (1972)
  - packet switched datagram based network standard proposed
- *OSI model* (open system for interconnection)
  - rivalry between ARPANET and OSI teams
  - became published ISO
  - slow development led to frustration
- *NSFNet* by National Science Foundation 1986 to provide researchers with
  supercomputer access
- late 80s:
  - commercial ISPs appear
  - CERN develops TCP/IP
- protocols were designed without consideration of adversaries on the network
  - security was retrofitted, many insecure protocols are still in use e.g. DNS
- "palace revolt" 1992: OSI solution to IPv4 limitations was rejected; so IPv6 only
  introduced in 1996 and isn't widely used

## Outcome

- two protocol stacks:
  - TCP/IP standards post-hoc
  - OSI standardised before the fact, not widely implemented
- why is a model necessary?
  - ensure interoperability: open rather than proprietary
  - reference model to develop and validate against independently
  - simplify design process through abstraction

## Network Models

- _model_ network as stack of layers
- each layer offers services to layers above it
- inter-layer exchanges per protocol
- in reality layering violations do occur, but a helpful abstraction

![]()

- *service*: set of primitives that a layer provides to a layer above it (think API)
- *protocol*: rules which governs format and meaning of packets exchanged by peers within layer
  - packets are sent between peer entities
![]()

## Connection-oriented vs connectionless

- connection-oriented (TCP)
  - connect, use, disconnect
  - negotiation inherent in connection setup
  - think telephone call
- connectionless (UDP)
  - think postal service or sending text message: you don't notify you are sending text messages
- choice affects
  - reliability
  - cost
  - quality of service

## TCP/IP vs OSI

- TCP/IP model reflects what happens on internet
- OSI model reflects more what _should_ happen

## OSI philosophy

- layers should be created iff a different abstraction needed
- each layer should perform well defined function
- layer boundaries should minimise information flow across interfaces
- number of layers should be
  - small enough that architecture isn't unwieldy
  - big enough that multiple functions aren't grouped together in a layer by necessity

## OSI model

- Application
- Presentation
- Session
- Transport
- Network
- Data link
- Physical

## TCP/IP model

- Application
- Transport
- Internet
- Host-to-network

![comparison between TCP/IP and OSI models]()

## Protocol Stack

- application: TELNET, FTP, SMTP, DNS
- transport: TCP, UDP
- network: IP
- physical, data-link: SATNET, LAN


## Internet by nuts and bolts

- network inerconnecting hundreds of millions of computing devices,
  **hosts** aka **end systems**
- **communication links** connect hosts
  - physical media: coaxial cable, copper wire, optical fibre, radio spectrum
- **packet**: data + header
  - sent through network to destination host
- **packet switch**: forwards packet from ingoing to outgoing communication link
  - e.g. **router**, **link-layer switch**
- **route**/**path**: sequence of communication links and packet switches

### ISPs

- **Internet service providers**: network of packet switches and communication links
  providing Internet access to end systems
- ISPs, with lower tiers being connected through national and international
  upper-tier ISPs
- upper-tier ISPs: high speed routers interconnected with high speed fibre-optic links

### Protocols

- internet's principal protocols are ****TCP/IP**
  - **Transmission Control Protocol (TCP)**
  - **Internet Protocol (IP)**
- **internet standards** developed by Internet Engineering Task Force (IETF)
  - standards documents are **requests for comments (RFCs)**
- IEEE 802 LAN/MAN Standards committee: specifies Ethernet, wireless WiFi standards

## Internet by services

- Internet can be considered _infrastructure that provides services to applications_
  - e.g. email, web surfing, social networks, VoIP, streaming, ...
- applications are **distributed applications** because they involve multiple
  end systems exchanging data, and run on end systems (not in packet switches)
- **application programming interface (API)**: defines how a program on one end system
  can deliver data to a destination program running on another end system
  - _analogy: sending a letter ~ postal service API._  You need to label envelope with name and address + post code
    affix a stamp and drop in a post box.
- **protocol**: defines format and order of messages exchanged between communicating
  entities, and actions taken on transmission/receipt of message/event

## Protocol Layers

- **protocols layer**: used to group protocols, and associated hardware and software implementing them into layers
  - provide **services** to layer above
  - depend on services of layer below
- **protocol stack**: set of protocol layers
- layers may use a mix of hardware and software
  - HTTP on application layer: software
  - network layer: software + hardware
  - Ethernet on physical layer: hardware
- pros of layering:
  - modularity
- cons of layering:
  - potential duplication of lower-layer functionality
  - functionality at one layer may need information from another layer, which violates
    the goal of layer separation

## IP Stack

### Application Layer

- where network applications live e.g. HTTP (web), SMTP (email), FTP (file transfer), DNS
- **message**: (K&R) packet of information at application layer

### Transport Layer

- transports application-layer messages between application endpoints
- either TCP, UDP
- Transmission Control Protocol (TCP):
  - connection-oriented service to applications
  - guaranteed delivery
  - flow control (speed matching)
  - breaks long messages into shorter segments
  - congestion-control
- User Datagram Protocol (UDP):
  - connectionless service
  - no frills: no reliability, no flow control, no congestion control
- **segment**: (K&R) packet of information at transport-layer

### Network Layer

- aka IP layer
- transports datagrams between hosts
- **datagrams**: network-layer packets
- transport-layer protocol in a source passes segment and destination address to network layer
  - network layer provides delivery of segment to transport layer in destination host
- Internet Protocol (IP) + routing protocols

### Link Layer

- serves the network layer by delivering datagram to next node along its route
- at the next node the link layer passes datagram up to network layer
- protocols include Ethernet, WiFi
- along route from source to destination a datagram may be handled by different link-layer
  protocols e.g. WiFi and Ethernet
- **frames**: (K&R) link-layer packets

### Physical Layer

- move individual bits within frame from one node to the next
- protocols dependent on physical transmission medium (e.g. twisted-pair copper wire, fibre optic cable)

## OSI Model

- Open Systems Interconnection (OSI) model
- adds presentation and session layers
- absence of these layers from IP stack implies that it is up to the
  application developer to implement this functionality if it is desired

### Presentation layer

- provides services that allow communicating applications to interpret
  the meaning of data exchanged
  - data compression
  - data encryption
  - data description

### Session Layer

- provides for delimiting and synchronisation of data exchange
  - checkpointing and recovery scheme

## Encapsulation

![layer_encapsulation](img/layer_encapsulation.png)

- application-layer message has transport layer header $`H_t`$ appended
- ... so on through the stack until bits are transmitted along the physical
  medium
- at each layer a pack typically has:
  - header: e.g. at network layer, source and destination host IP addresses
  - payload field: packet from the layer above
