---
title: Concurrency
notebook: Modelling Complex Software Systems
layout: note
date: 2021-03-05
tags: 
...


## Concurrent Programming Abstraction

- concurrency is an abstraction to help reason about the dynamic behaviour of programs
  - the abstraction can be related to machine language instructions, however there are no important
    concepts that cannot be explained at the higher level of abstraction
- __concurrent program:__ finite set of sequential processes, composed of a finite number of atomic statements
- execution of a concurrent program proceeds via execution of sequence of atomic statements from the processes
  - sequence formed as an __arbitrary interleaving__ of atomic statements of the processes
  - __computation/scenario:__ possible execution sequence resulting from interleaving
  - NB sequential processes implies ordering of steps is maintained
- __control pointer:__ of a process indicates next statement that can be executed  

![Arbitrary Interleaving](img/arbitrary-interleaving.png)

- arbitrary interleaving lets us ignore real-time behaviour, making programs more amenable to formal analysis
- program properties are then invariant under hardware

## Correctness

- correctness of non-terminating concurrent programs is defined in terms of properties: safety, liveness
- __safety properties:__ property must always be true.  For safety property $P$ to hold, it must be true that in every state
  of every computation, $P$ is true. "Always, a mouse cursor is displayed"
  - safety properties often take form _always, something bad is not true_
  - nothing bad will ever happen
  - e.g. absence of __interference__
- __liveness properties:__ property must eventually become true. For liveness property $P$ to hold, it must be true that in every computation 
  there is some state in which $P$ is true. "If you click on a mouse button, eventually the mouse cursor will change shape"
  - something good eventually happens
  - e.g. absence of __deadlock__
- safety, liveness are duals of each other: the negation of a safety property is a liveness property and vice versa
- for a concurrent program to be correct it must be correct for _all_ possible interleavings


