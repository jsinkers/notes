---
title: Input/Output
notebook: Computer Systems
layout: note
date: 2020-07-06 22:45
tags: 
...

# Input/Output

[TOC]: #

## Table of Contents
- [OS Responsibilities](#os-responsibilities)
- [Principles](#principles)
  - [Block Devices](#block-devices)
  - [Character Devices](#character-devices)


## OS Responsibilities

- OS controls all computers I/O devices: issuing commands to them, catching interrupts,
  and handles errors
- OS provides simple, easy to use interface between devices and the rest of the system
  - interface should be device independent as far as possible
- I/O code represents significant fraction of total OS

## Principles

- I/O devices can be roughly categorised as block devices and character devices
- the boundary isn't always well defined, but the categorisation is usually decided
  based on typical use: a tape could be randomly-accessed as a block device with
  very slow delays in between, but this is not how they are normally used

### Block Devices

- **block device**: stores information in fixed-size, addressable blocks
- all transfers are in units of one or more entire, consecutive blocks
- essential property: each block can be read/written to independently of all others
- e.g. Hard disk, Blu-ray disc, USB stick

### Character Devices

- **character device**: delivers/accepts a stream of characters without any block
  structure
- not addressable
- no seek operation
- e.g. computer mouse, printer, network interface, most other non-disk devices
