---
title: "Application Layer: HTTP and Cookies"
notebook: Computer Systems
layout: note
date: 2020-03-05 23:53
tags: 
...

# "Application Layer: HTTP and Cookies"

[TOC]: #

## Table of Contents
- [Readings](#readings)
- [Principles of Network Applications](#principles-of-network-applications)
  - [Network Application Architectures](#network-application-architectures)
  - [Processes Communicating](#processes-communicating)
  - [Interface between process and network](#interface-between-process-and-network)
  - [Addressing processes](#addressing-processes)
  - [Transport Services](#transport-services)
  - [TCP services](#tcp-services)
  - [SSL](#ssl)
  - [UDP Services](#udp-services)
  - [Application Layer Protocols](#application-layer-protocols)
- [The Web and HTTP](#the-web-and-http)
  - [HTTP: HyperText Transfer Protocol](#http-hypertext-transfer-protocol)
  - [Non-persistent and persistent connections](#non-persistent-and-persistent-connections)
  - [HTTP Request Message](#http-request-message)
  - [HTTP Response Message](#http-response-message)
  - [Cookies](#cookies)
  - [Web Caching](#web-caching)
- [File Transfer Protocol: FTP](#file-transfer-protocol-ftp)
  - [FTP Commands and Replies](#ftp-commands-and-replies)
- [Email](#email)
- [DNS](#dns)




## Readings
- [x] K&R 2.1
- [ ] K&R 2.2

## Principles of Network Applications

### Network Application Architectures

- **client-server:** always on _server_ host services requests from many other _client_ hosts
  - clients do not directly communicate
  - server has static IP address
  - e.g. Web, FTP, Telnet, email
  - data centres with multiple hosts provide powerful server to handle
    large volume of requests
- **peer-to-peer (P2P)**: direct communication between intermittently connected _peer_ hosts
  - peers are not owned by service providers but by end users
  - e.g. BitTorrent, Skype
  - self scalable: peers introduce workload with requests but also add service capacity
    through file distribution etc
  - cost effective: minimal server infrastructure/bandwidth

### Processes Communicating

- **process**: instance of a program running in an end system
- processes on different hosts communicate by exchanging **messages** across the network
- in context of communication session between two processes:
  - _client process_ initiates communicaton
  - _server process_ waits to be contacted

### Interface between process and network

- **socket**: software interface that allows a process to send/receive messages from the network
  - aka API between application and network, as socket is programming interface
    with which network apps are built
  - app developer has control over everything app side of socket, very little control
    transport-layer side:
    - may have a choice of protocol (UDP/TCP)
    - may have ability to set some transport-layer parameters
![sockets](img/sockets.png)

### Addressing processes

To communicate with a process on a remote host, you need:
- **IP address** identifying a host
  - IPv4: 32-bit
- **port number** specifies receiving process in destination host
  - e.g. HTTP: 80, SMTP: 25

### Transport Services

Can be classified by these dimensions:
- reliable data transfer
  - guaranteed data delivery
  - without it app needs to be loss-tolerant
  - provided by TCP
- throughput
  - specification of bits/sec required
  - elastic applications make use of whatever throughput is available
  - not provided by Internet transport protocols
- security
  - encryption/decryption
  - data integrity
  - end-point authentication
  - TCP with SSL
- timing
  - e.g. guarantee that every bit pumped into the socket is received within 100ms
  - e.g. applications: telephony, gaming
  - not provided by Internet transport protocols

### TCP services

- **connection oriented service**: handshake to set up connection
  - **full-duplex**: two processes can send messages over the connection simultaneously
  - connection must be torn down once finished
- **reliable data transfer service**: communicating processes can rely on TCP
  to deliver all data sent without error and in proper order
- **congestion control**: serves Internet as a whole rather than communicating processes
  - throttles a sending process when network is congested
  - attempts to allocate fair share of bandwidth

### SSL

- TCP and UDP have no built-in encryption
- **Secure Sockets Layer (SSL)**: TCP enhancement providing encryption, data
  integrity, end-point authentication
  - not a transport protocol, but an enhancement in residing in application layer
  - to use SSL, you need to include the code in your application
  - similar API to TCP, but before the transmission occurs it is first encrypted, then
    passed to TCP socket

### UDP Services

- lightweight transport protocol with minimal services
- connectionless
- unreliable data transfer service:
  - no guarantee of delivery
  - messages may arrive out of order
- no congestion control

### Application Layer Protocols

- **application-layer protocol**: defines how application's processes on different hosts
  pass messages, in particular
  - type of messages e.g. requests/responses
  - syntax of message types: fields, delimiters
  - semantics: what values of fields means
  - rules determining when/how process sends/responds to messages
- application layer protocol $\not =$ network application; the protocol is one
  part of the application
  - e.g. the Web
    - application: includes standard for document formats (HTML), web browsers,
      web servers, application-layer protocol
    - protocol: HTTP

## The Web and HTTP

- before the Web, the Internet was used primarily by researchers, academics, university students
  primarily to transfer files, receive news, send email
- early 90s saw introduction of the Web, and general public was now using the Internet
  - on demand content
  - easy/low cost to publish content

### HTTP: HyperText Transfer Protocol

- HTTP 1.0 [RFC1945](https://tools.ietf.org/html/rfc1945)
- HTTP 1.1 [RFC2616](https://www.ietf.org/rfc/rfc2616.txt)
- HTTP 2.0 [RFC7540](https://tools.ietf.org/html/rfc7540)

- Web's application-layer protocol
- implemented on client program and server program, on distinct hosts, which communicate via
  HTTP messages
- HTTP defines structure of the messages and how the client/server exchange messages
- **web page** consists of **objects** - a file addressable by a single URL
- most web pages: **base HTML file** + several objects (images, CSS, javascript, ...)
  referenced by base HTML file
- once HTTP client sends message into socket interface, it is out of hands of client
  and in hands of TCP
- **stateless protocol**: HTTP server maintains no info about clients

### Non-persistent and persistent connections

- decision by app developer whether to use **persistent/non-persistent connection**
- **non-persistent connections**
  - TCP connection needs to be established for each object: lots of overhead
    and significant burden on the server
  - could use parallel TCP connections (typically up to 5-10) handling individual
    request-response transaction
- **three-way handshake**: each step involves transfer of TCP segment
  - client: requests connection
  - server: responds with acknowledgement
  - client: acknowledges connection + HTTP request
- **persistent connection**: server leaves TCP connection open after sending response
  - **pipelining**: back-to-back requests made without waiting for replies to pending
    requests; speeds up transfer
  - multiple web pages residing on the same server can be sent via a single persistent
    TCP connection
  - server closes connection after a timeout interval
  - default mode: persistent connections with pipelining

### HTTP Request Message

- `User-agent:` specifies browser type making request, allowing server to provide
  different versions of the same object depending on the user agent
- `Host:` necessary for Web proxy caches

![http_request](img/http_request.png)

### HTTP Response Message

Consists of
- status line
- header lines
- entity body: requested object itself

### Cookies

- **cookies** allow sites to keep track of users to identify users, either to restrict
  access or serve tailored content
- components
  - cookie header line in HTTP response message
  - cookie header line in HTTP request message
  - cookie file kept on user's end system, managed by the broswer
  - back-end database server-side
- when you access a site, it may respond with a Set-cookie: <id>, with that id and the server hostname
  being appended to a cookie file.  When you make HTTP requests this id is
  added to the header, and the server uses it for some cookie-specific action,
  such as maintaining intended purchases.

![cookies](img/cookies.png)

### Web Caching

- **web cache/proxy server**: network entity satisfying HTTP requests on behalf of
  origin web server
  - has storage on which it caches recently requested objects
  - browsers can be configured so that HTTP requests are first directed to
    the web cache
  - if the web cache doesn't have a copy of that object it requests it from the
    origin server
  - typically installed by an ISP or e.g. university campus
- **benefits:**
  - reduces response times for client requests if there is a high speed connection
    from client-cache c.f. client-origin
  - substantial reduction in traffic on access link (e.g. within campus), using less bandwidth
  - substantial reduction in Internet traffic, improving performance for all applications
- **conditional GET**: HTTP mechanism to verify objects are up to date
  - adds an `If-Modified-Since:` header line to a GET request
  - cache will issue this request if it has a cached object, using the `Last-Modified:` header line
    from the response header
  - if the object has not been modified, the server responds with a `304 Not Modified`
    and an empty entity body
  - conditional GET saves bandwidth and increases end user response times

## File Transfer Protocol: FTP

- local host wants to transfer files to/from remote host
- user provides remote hostname + authentication and then can transfer files using an FTP user agent
- runs on TCP, but uses two parallel connections to transfer a file
  - **control connection**: sending information e.g. credentials, put/get commands
    - this is **out-of-band**
    - port 21
  - **data connection**: send actual files
    - this is **in-band**
    - port 20
    - one connection per file transfer
- user **state** maintained:
  - control connection associated with an account
  - current directory
- need to keep track of state info constrains total number of simultaneous sessions

![ftp](img/ftp.png)

![ftp_connections](img/ftp_connections.png)

### FTP Commands and Replies

- [RFC 959](https://tools.ietf.org/html/rfc959)
- commands/replies sent across control connection in 7-bit ASCII format
- successive commands delimited by <cr><lf>
- commands are 4 uppercase characters, some with arguments
  - `USER username`
  - `PASS password`
  - `LIST`: file listing in current directory
  - `RETR filename`: retrieve file from current directory of remote host
  - `STOR filename`: put file
- replies: 3 digit numbers with optional message
  - `331 Username OK, password required`
  - `125 Data connection already open; transfer starting`
  - `425 Can’t open data connection`
  - `452 Error writing file`

## Email

## DNS


