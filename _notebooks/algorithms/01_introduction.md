---
title: Subject introduction
notebook: Design of Algorithms
layout: note
date: 2020-03-03 13:06
tags: 
...

# Subject introduction

[TOC]: #

## Table of Contents
- [Algorithms](#algorithms)
- [Greatest common divisor](#greatest-common-divisor)
- [Sieve of Eratosthenes](#sieve-of-eratosthenes)
- [Algorithmic Problem Solving](#algorithmic-problem-solving)
- [Important problem types](#important-problem-types)
- [Linear data structures](#linear-data-structures)
  - [Array](#array)
  - [Linked list](#linked-list)
  - [List](#list)
  - [Stacks](#stacks)
  - [Queue](#queue)
  - [Priority queues](#priority-queues)
- [Graphs](#graphs)


## Algorithms

- Sequence of *unambiguous* instructions for solving a problem to obtain
  required output for *legitimate input* in a *finite* amount of time
- multiple valid solutions with different efficiency

## Greatest common divisor

Euclid's algorithm ```gcd(m, n) = gcd(n, m mod n)```

For example

```
gcd(24, 60) = gcd(60, 24)
            = gcd(24, 12)
            = gcd(12, 0)
            = 12
```

Since `gcd(m, 0) = m`

## Sieve of Eratosthenes

- algorithm to generate consecutive primes not exceeding a given integer `n > 1`
- procedure:
  - generate a list of prime candidates from 2 to n
  - loop over the list, each time eliminating candidates that are multiples of
    2, 3, ...
  - no pass for 4 is necessary as all multiples of 4 have already been
    eliminated
  - algorithm continues until no more numbers can be eliminated; remaining
    numbers are prime

- what is largest `p` whose multiples can still remain on the list to make
  further iterations of the algorithm necessary?
  - if `p` is a number whose multiples are being eliminated on the current pass,
    first multiple we should consider is `p.p` because all smaller multiples
    `2p, ..., (p-1)p` have been eliminated on earlier passes
  - `p.p` should be less than `n` otherwise it isn't a candidate, i.e.

  ```math
  p \leq \lfloor\sqrt{n}\rfloor
  ```

## Algorithmic Problem Solving

- understand the problem
- understand the capabilities of the hardware
- decide between exact/approximate solution
- choose design techniques
- design algorithm and data structure
- prove correctness: prove that algorithm yields required result for every
  legitimate input in finite time
  - often uses mathematical induction
  - for approximation algorithms you need to show error does not exceed defined
    limit
- analysis
  - time efficiency: run time
  - space efficiency: memory
  - generality
- implement the algorithm

## Important problem types

- sorting: rearrange list items in non-decreasing order
  - stable: preserves relative order of equal elements
  - typically algorithms that switch keys far apart are not stable but are
    faster
  - in-place: doesn't require extra memory to run
- searching: find a given value (_search key_) in a given set
- string processing
  - e.g. string matching
- graph problems
  - graph is a collection of vertices, connected by edges
  - e.g. graph traversal, shortest path
  - graph-coloring: assign smallest number of colors to vertices of a graph such
    that no two adjacent vertices are the same color (event scheduling)
  - travelling salesman problem: shortest tour through n cities that visits each
    city only once
- combinatorial problems
  - ask to find a combinatorial object satisfying constraints (e.g. permutation,
    combination, subset)
  - typically most difficult class of problems: number of objects grows
    extremely fast with problem size
- geometric problems: points, lines and polygons
  - e.g. computer graphics, robotics, tomography
  - closest-pair problem: given n points in the plane, find the closest pair
    among them
  - convex-hull problem: smallest convex polygon that contains all points of a
    set
- numerical problems: mathematical objects of continuous nature
  - solving systems of equations, computing integrals, evaluating functions

## Linear data structures

### Array

- sequence of `n` items of the same data type stored contiguously in memory
- accessible by **index**
- each element of an array can be accessed by an identical constant amount of
  time (c.f. linked lists)
- useful for **strings**

### Linked list

- sequence of **nodes** each containing data and **pointers** to other nodes
- **singly linked list**: each node (except last) contains a single pointer to the
  next element
- nodes are accessed by traversing the list: time dependent on node's location
- doesn't require preliminary reservation of memory
- efficient insertions and deletions
- **header**: special node at start of list, points to first item in list, could
  contain:
  - metadata about list e.g. current length
  - pointer to last element in list
- **doubly linked list**: each node contains a pointer to the next and previous
  node

![array and singly linked list](img/array_and_singly_linked_list.png)
![doubly linked list](img/doubly_linked_list.png)

### List

- **list**: finite sequence of data items
- operations:
  - search for
  - insert
  - delete

### Stacks

- **stack**: list in which insertions and deletions are performed at the end
  (**top**) of the list
  - last-in-first-out
  - picture vertical stack of plates

### Queue

- **queue**: elements added to rear, and removed from the front
  - **dequeue**: elements deleted from the **front**
  - **enqueue**: elements added to the **rear**
  - first-in-first-out
  - think queue of customers in line

### Priority queues

- *priority queue*: useful for selection of an item of highest priority from
  dynamically changing candidates
  - collection of data items from a totally ordered universe (e.g. integer/real
    numbers)
- operations:
  - find largest element
  - delete largest element
  - add a new element
- *heap* is the most efficient solution to this problem

## Graphs

- collection of points, called **vertices** or **nodes**, with some connected by
  **edges**
- a graph $`G = \langle{V,E}\rangle`$, is a pair of two sets
  - finite nonempty set V, vertices
  - set E of pairs of these items, edges
- if these pairs of vertices is unordered i.e. $`(u, v)`$ is the same as $`(v, u)`$,
  v and u are **adjacent**, connected by **undirected edge** $`(u,v)`$
- vertices _u_ and _v_ are **endpoints** of edge $`(u, v)`$
  - _u_ and_v_ are **incident** to this edge (and vice versa)
- a graph is **undirected** if all edges are undirected
- **directed** edge $`(u, v)`$ means vertices $`(u, v)`$ are not the same as vertices $`(v, u)`$
  - from **tail** u to **head** v
- a graph is **directed** if all edges are directed (aka **digraphs**)

- convenient to label vertices with letters or numbers
- graph with 6 vertices and 7 undirected edges

```math
V = \{a, b, c, d, e, f\}
\newline
E = \{(a,c), (a,d), (b,c), (b,f), (c,e), (d,e), (e,f)\}
```
![undirected_graph](img/undirected_graph.png "Undirected graph")
- digraph with 6 vertices and 8 directed edges

```math
  V = \{a, b, c, d, e, f\}
\newline
E = \{(a,c), (b,c), (b,f), (c,e), (d,a), (d,e), (e,c), (e,f)\}
```

![directed_graph](img/directed_graph.png "Digraph")

- this definition allows **loops**, including edges connecting vertices
  to themselves, however unless stated will be expected to have no loops
- definition disallows multiple edges between the same vertices of an undirected graph:
  - number of edges $`|E|`$
  - number of vertices $`|V|`$
  - $` 0 \le |E| \le |V|\frac{(|V|-1)}{2}`$
- graph is **complete** if every pair of vertices is connected by an edge
  - complete graph with $`|V|`$ vertices: $`K_{|V|}`$
- graph with few missing edges is **dense**
- graph with few edges present is **sparse**




