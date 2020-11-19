---
title: Declarative Programming
notebook: Declarative Programming
layout: note
date: 2020-11-03
tags: 
...

# Declarative Programming

## Differences to Imperative Languages

- focus is on what to do, rather than how to do it
- higher level of abstraction
- easier to use powerful programming techniques
- clean semantics: can do things with declarative programs you can't do with imperative ones

## Paradigms

- __Imperative:__ based on __commands__, as instructions and statements
  - commands are executed
  - commands have an __effect__: update computation state.  Later code may depend on this update
- __Logic:__ based on finding values that satisfy a set of __constraints__
  - constraints may have 0 or many solutions
  - constraints have no effect
- __Functional:__ based on evaluation of __expressions__
  - expressions are evaluated
  - expressions have no effect

## Side Effects

- code has a __side effect__ if, in addition to producing a value, it also modifies some state,
  or has an observable interaction with calling functions/outside world.
- examples
  - modify global/static variable
  - modify an argument
  - raise an exception
  - write data
  - read data
  - call other functions that have side effects

## Destructive update

- imperative languages: natural way to insert an entry in a table is to modify the table in place
  - destroys the old table
- declarative languages: instead create a new version of the table, while the old version remains
  - drawback: language has to work harder to recover memory and ensure efficiency
  - benefit: don't need to worry about what other code is affected by the change
    - can keep previous version for comparison/undo
    - __immutability__ makes parallel programming significantly easier

## Strengths of Declarative Languages

- productivity: working at a higher level of abstraction
  - focus on big picture
- symbolic data processing simplified: 
  - algebraic data types 
  - parametric polymorphism
- reliability: 
  - compiler catches more errors
  - memory allocation automated
- simplified debugging: you can jump back in time
- maintainability: type system helps locate what needs fixing
  - typeclass system helps avoid unwanted coupling
- parallelisable: automatically parallelisable

## Strengths of Imperative languages

- performance
- existing libraries
- programming tools
- available expertise and programmers

# Interfacing with Foreign Languages

- applications often involve code written in several languages.  Reasons:
  - interface to existing libraries
  - write performant code in low-level languages
  - write each part in the most appropriate language
  - gradually migrate code base between languages
- achieved using a __foreign language interface__

## Application Binary Interface

- platform: ISA + OS
- each platform has an ABI, which dictates
  - where callers of functions put function parameters
  - where callee function should put result
- by compiling different files to the same ABI, functions in one file can call functions in a 
  separately compiled file (even compiled with a different compiler)
- traditional way to interface languages (C-Fortran, Ada-Java): compilers of both languages generate
  code conforming to the ABI


