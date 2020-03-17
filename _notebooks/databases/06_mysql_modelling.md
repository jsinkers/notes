---
title: Modelling with MySQL Workbench
notebook: Database Systems
layout: note
date: 2020-03-17 13:11
tags: 
...

# Modelling with MySQL Workbench

[TOC]: #

## Table of Contents
- [Conceptual to Logical Design](#conceptual-to-logical-design)
  - [Binary One-One relationship](#binary-one-one-relationship)



## Conceptual to Logical Design

Checklist
1. Flatten composite and multi-valued attributes
    - Multi-value attributes can be made into another table: do this when the
      number is likely to be variable/is unknown
2. Resolve many-many relationships
3. Add foreign keys at crows-foot end of relationships (many side)

### Binary One-One relationship

- move the key from the _one_ side to the other side
- the _optional_ side of the relationship should get the foreign key
  - reduces number of `NULL` values

