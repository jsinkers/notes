---
title: FTP, SMTP, DNS
notebook: Computer Systems
layout: note
date: 2020-03-15 17:30
tags: 
...

# FTP, SMTP, DNS

[TOC]: #


1. The file transfer protocol (FTP) is one of the earliest Internet protocols. It is used to copy
files between servers, and delete files on remote servers. It has a persistent control connection,
on which a user issues commands and the remote site sends status responses. For each file
transferred, it has a new data connection. The TCP port number of the file connection is
sent over the control connection.
What are the benefits and disadvantages of using a separate control channel?
    - benefits:
      - you can initiate multiple transfers, terminate transfers, etc. while the
      - maintenance of state e.g. current directory
        transfer is happening, without having to wait for transfer to complete
    - disadvantages:
      - additional overhead associated with maintaining multiple TCP connections
      - security concerns
2. Describe the commonalities and differences between SMTP and (persistent) HTTP.
    - commonalities:
      - uses TCP in transport layer
      - both transfer files from host to client
    - differences:
      - HTTP operates between server and client (typically browser), while SMTP
        operates between mail servers
      - HTTP primarily pull; SMTP is a push protocol
      - SMTP messages must be ASCII, HTTP messages don't have this limitation
      - HTTP: one response per object; SMTP: all objects in one response
3. Suppose that John just set up an auto-forwarding mechanism on his work email address,
which receives all of his business-related emails, to forward them to his personal email
address, which he shares with his wife. John's wife was unaware of this, and activated a
vacation agent on their personal account. Because John forwarded his email, he did not set
up a vacation daemon on his work machine. What happens when an email is received at
Johns work email address?
    - email is forwarded to the personal account
4. Consider a situation in which a cyberterrorist makes all the DNS servers in the world crash
simultaneously. How does this change people's ability to use the Internet?
    - assuming this includes all DNS caches, this would drastically affect the
      ability of people to use the Internet, as e.g. HTTP requests only use hostnames
      and rely on DNS resolution to be able to send the request.  Services with static
      IPs which are widely known would be able to continue use
5. Is it possible for an organizations Web server and mail server to have exactly the same alias
for a hostname (for example, foo.com)? How does a DNS server distinguish these two types
of mapping, namely, hostname-web server IP and hostname-mail server IP?
    - Yes: the DNS client requests the MX record from the resource record for a given
  hostname to get the mail server, and requests the CNAME record for the web server
6. DNS uses UDP instead of TCP. If a DNS packet is lost, there is no automatic recovery. Does
this cause a problem, and if so, how is it solved?
    - DNS will attempt to repeat query, attempt a query to another name server, or
      or notify application the query was unsuccessful
7. Suppose you can access the caches in the local DNS servers of your department. Can you
propose a way to roughly determine the Web servers (outside your department) that are
most popular among the users in your department? Explain.
    - count number of times local DNS servers receive a request for a domain before
      they are forwarded to the DNS hierarchy (presumably if the entry is cached
      these won't be forwarded to DNS hierarchy)
    - count length of time between domain being added to the cache: the most popular
      ones will be close to the TTL, while the less popular ones may have a period
      longer than the TTL

