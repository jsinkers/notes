---
title: Graph Traversal
notebook: Design of Algorithms
layout: note
date: 2020-04-20 18:17
tags: 
...

# Graph Traversal

[TOC]: #

## Table of Contents
- [Depth first search (DFS)](#depth-first-search-dfs)
- [Breadth first search](#breadth-first-search)


## Depth first search (DFS)

- search for the brave
- start at an arbitrary vertex, mark as visited
- on each iteration, proceed to unvisited adjacent vertices
- continue until you reach a dead end (no more unvisited adjacent vertices)
- back-track up one edge, and check for unvisited vertices
- algorithm halts after backing up to starting vertex, reaching a dead end
- all vertices in a connected component with the starting vertex must have been
  visited
- restart on any other unvisited vertices
- DFS search produces a **DFS forest** with start vertex at root
- DFS forest of an undirected graph has:
  - **tree edge**: edge leading a previously unvisited vertex
  - **back edge**: edge leading to previously visited vertex, other than immediate
    predecessor
- DFS forest of a directed graph may have, in addition:
  - **forward edge**: edge leading to a non-child descendant
  - **cross edge**: edge leading to a vertex in a different sub-tree

## Breadth first search