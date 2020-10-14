---
title: Dynamic Programming  
notebook: Design of Algorithms
layout: note
date: 2020-06-30
tags: 
...

# Dynamic Programming

[TOC]: #

## Table of Contents


## Knapsack: bottom up

```python
function KnapSack(v[1..n], w[1..n], W):
    # initialise first column with 0
    for i from 0 to n:
        K[i, 0] = 0
    
    # initialise first row with 0
    for j from 1 to W:
        K[0, j] = 0;

    # iterate over table
    for i from 1 to n:
        for j from 1 to W:
            if j < w[i]:
                K[i, j] = K[i-1, j]
            else:
                K[i, j] = max(K[i-1, j], K[i-1, j-w[i]] + v[i])

    return K[n,W]
```

## Breadth first search
