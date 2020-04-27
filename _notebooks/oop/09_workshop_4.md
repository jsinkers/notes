---
title: Tutorial 4
notebook: Object Oriented Programming
layout: note
date: 2020-04-20 21:36
tags: 
...

# Tutorial 4

[TOC]: #

## Table of Contents
- [Input/Output](#inputoutput)
- [Maven](#maven)



## Input/Output

1. What is the difference between Scanner.next() and Scanner.nextLine()?
- Scanner.next() reads the next token to a specific delimiter, while Scanner.nextLine() reads
  until the newline character is read, and eats the newline character.  Scanner.next()
  does not eat the newline character
2. Do you need to remember the code for setting up file input and output in the test and exam?
- No but you need to understand how it works

## Maven

Maven is a project management tool. Similar to Makefiles in C, it allows you to specify structure, compiler
settings, and dependencies for Java projects. Maven projects are specified in a file called pom.xml.
1. What are some of the important considerations when sharing software projects with other developers?
- other people should be able to build your project, maybe allowing for different
  system setups
2. What is a dependency in software engineering?
- external library used in your code that you do not maintain
3. Rather than requiring users to manually download dependencies like Makefiles, Maven has an ecosystem of
online packages that are downloaded as required. What are the benefits and drawbacks of this approach?
- benefits: makes it simpler to install external packages, incorporate updates
- drawbacks: may end up with a lot of extra code you aren't using

