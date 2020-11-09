---
title: Security
notebook: Distributed Systems
layout: note
date: 2020-10-15
tags: 
...

0 TODO: add link to comp systems summary <15-10-20, yourname> 0

[[toc]]

## Worst case assumptions

- interfaces are exposed: e.g. socket interface is open to the public
- networks are insecure: messages can be looked at, falsified, copied
- limit the lifetime and scope of each secret 
- algorithms and program code are available to attackers: 
  - the larger the secret the greater the risk of its disclosure
  - open source provides benefit in finding security problems, and scrutiny of methods
- attackers may have access to large resources
  - note Moore's law: resources of attackers are likely to grow exponentially over the lifetime of 
    the product
- minimise the trusted base

## Cryptography

### Standard participants

- Alice, Bob, Carol, Dave: general participants
- Eve: eavesdropper
- Mallory: malicious
- Sara: server

### Notation

- $k_B$ Bob's secret key
- $k_{ AB }$ shared secret key between Alice and Bob
- $k_{A\text{ priv }}$ Alice's __private__ key: known only to Alice
- $k_{ A\text{pub}}$ Alice's __public__ key: shared freely
- $\{M\}_k$ message $M$ __encrypted__ with key $k$
- $[M]_k$ message $M$ __signed__ with key $k$
- $\{M\}_k = E(M, k), M = D(\{M\}_k, k)$
  - $E$ encryption algorithm
  - $D$ a decryption algorithm

### Scenario 1: Secret communication via shared secret key

Alice and Bob share a secret key $k_{AB}$, and agree upon an encryption/decryption algorithm.

If the decrypted message makes sense or contains an agreed upon-value (checksum etc), Bob can be confident: 

- the message came from Alice
- the message hasn't been tampered with

__Issues__
- how to securely __send the shared key__?
- how can Bob know any message is not a __replay__?

Alice needs to send something with the message so that Bob can verify it isn't a replay

### Scenario 2: Authenticated communication with a server

- Alice wants to access Bob's resource.
- Sara is a securely managed authentication server.
- Sara issues passwords to all users, and knows secret keys $k_A, k_B$, as they are derived from the passwords.
  - user passwords aren't transmitted over the network
- __ticket__: encrypted item issued by authentication server, containing the identity of the principal 
  and a shared key generated for the current communication session

1. Alice sends a plaintext message to Sara stating identity and requesting a ticket for access to Bob
2. Sara sends a ticket $\{K_{AB}, \text{Alice}\}_{K_B}$ to Alice encrypted with $k_A$ containing ticket encrypted by $k_B$, and a
   new secret key $k_{AB}$: $\{\{\text{Ticket}\}_{K_B}, K_{AB}\}_{K_A}$
3. Alice decrypts with $K_A$, giving a ticket for Bob and a shared key: 
     - Alice can't tamper with the ticket, as it's encrypted with $K_B$
4. Alice sends the ticket to Bob with her identity and request $R$ to access a file: $\{\text{Ticket}\}_{K_B}, Alice, R$
5. Bob decrypts the ticket with $K_B$, allowing him to confirm Alice's identity, and establishes a shared session key $K_{ AB }$



0 TODO:  <15-10-20, yourname> 0

__Issues__
- how to trust server?
- how to enrol in the system?

### Scenario 3: Challenge-response

- common use: avoid sending passwords in the clear

### Scenario 4: Authenticated communication with public keys

- Alice accesses key distribution service Sara to obtain a __pub-key certificate__ `Cert`
  giving Bob's public key
  - 


## Digital Signature

- __digital signature__: binds an identity to a message
  - for public/private key exchange, the _identity_ is the key pair itself
- __digest__: maps an arbitrary message to a fixed length message 

## Certificates

