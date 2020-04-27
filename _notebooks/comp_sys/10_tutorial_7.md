School of Computing and Information Systems
COMP30023: Computer Systems
Tutorial Week 7

Network Layer - IP Addresses and Packet Switching
1. Do routers have IP addresses? If so, how many?
2. Datagram networks route each packet as a separate unit, independent of
all others. Virtual-circuit networks do not have to do this, since each
data packet follows a predetermined route. Does this observation mean
that virtual-circuit networks do not need the capability to route isolated
packets from an arbitrary source to an arbitrary destination? Explain
your answer.
3. A network on the Internet has a subnet mask of 255.255.240.0. What is
the maximum number of hosts it can handle?
4. A router has just received the following new IP addresses: 57.6.96.0/21,
57.6.104.0/21, 57.6.112.0/21, and 57.6.120.0/21. If all of them use the
same outgoing line, can they be aggregated? If so, to what? If not, why
not?
5. A large number of consecutive IP addresses are available starting at 198.16.0.0.
Suppose that four organizations, A, B, C, and D, request 4000, 2000, 4000,
and 8000 addresses, respectively, and in that order. Each request is given
the lowest-numbered subnet available for it. For each of these, give the
first IP address assigned, the last IP address assigned, and the mask in
the w.x.y.z/s notation.
6. A router has the following (CIDR) entries in its routing table:

1

Address/mask
135.46.56.0/22
135.46.60.0/22
192.53.40.0/23
default

Next hop
Interface 0
Interface 1
Router 1
Router 2

For each of the following IP addresses, where does the router send the
packet if a packet with that address arrives?
(a) 135.46.63.10
(b) 135.46.57.14
(c) 135.46.52.2
(d) 192.53.40.7
(e) 192.53.56.7

7. List one motivation for a host to send an IP packet with the wrong source
IP address. List two ways that this can adversely affect the legitimate
owner of that IP address.
8. The IP packet header includes a time-to-live field that is decremented by
each router along the path. Why is the time-to-live field necessary?
9. Bonus for fun: IPv6 uses 16-byte addresses. If a block of 1 million addresses is allocated every picosecond, how long will the addresses last?

2

