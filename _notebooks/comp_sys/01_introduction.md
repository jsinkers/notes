---
title: Intro to internet/layers
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


