---
title: Classical to Quantum
notebook: Quantum Computing
layout: note
date: 2020-12-05
tags: 
...

## Modelling System Dynamics with Graphs

- a weighted digraph can be represented as an adjacency matrix
- classical deterministic systems can be modelled without weights (i.e. all weights are 0 or 1)
- classical probabilistic systems can be modelled with real weights
- quantum systems can be modelled with complex weights

## Classical Deterministic Systems

- e.g. marbles moving between vertices
- the states of a system correspond to column vectors (state vectors) $\bold{x}$
- dynamics of a system as a digraph with weight whose weights are in ${0, 1}$ have corresponding matrix $M$
- the progression from one state to another in one time step, multiply the state vector by a matrix $M\bold{x}$
- multiple step dynamics are obtained via matrix multiplication $M^k\bold{x}$

## Classical Probabilistic Systems

- in quantum mechanics 
  - there is inherent __indeterminacy__ in our knowledge of a physical state
  - states change according to __probabilistic__ laws: the laws governing a system's evolution are given by describing how states transition from
    one to another with a certain likelihood

### Adjacency Matrix

- e.g. marbles moving between vertices with some probability
- to capture probabilistic scenarios, the state of the system corresponds to the probability e.g. of a marble being on a vertex
- weights therefore are real-valued numbers between 0 and 1
- corresponding adjacency matrix is __doubly stochastic:__ sum of each row and sum of each column is 1

### Time Symmetry

- row vector $\bold{w}$ also corresponds to a state of the system
  - $\bold{w}M = \bold{z}$
- the transpose of $M$, $M^T$ corresponds to the original digraph with reversed arrows
- this is akin to travelling back in time
- left multiplication of $M$ takes states from time $t$ to $t+1$
- right multiplication of $M$ takes states from time $t$ to $t-1$
- __time symmetry__ of quantum mechanics is important
- system dynamics are entirely symmetric: replacing column vectors with row vectors, and forward evolution with backward evolution,
  the laws of dynamics still hold

### Summary

- the vectors representing states of a probabilistic system express indeterminacy about the exact physical state
- matrices representing dynamics express indeterminacy about how the system will change over time
- the matrix entries allow calculation of likelihood of transitioning from one state to the next
- the progression of the system is simulated by matrix multiplication

## Quantum Systems

### Interference

- in quantum systems, a weight is represented by a normalised complex number $c$, such that $|c|^2$ is a real number between 0 and 1.
- what is the difference between using real probabilities directly and indirect probabilities (via complex numbers)? __interference__
  - real number probabilities can __only__ increase when added
  - e.g. $p_1, p_2 \in [0, 1] : (p_1+p_2) \ge p_1 \wedge (p_1+p_2) \ge p_2$
  - complex numbers can cancel each other out and lower their probability
  - e.g. $c_1, c_2 \in \mathbb{C}$. $|c_1+c_2|^2$ is not necessarily bigger than $|c_1|^2, |c_2|^2$

### Adjacency Matrix

- in quantum realm, graphs are represented by matrices with complex entries
- rather than doubly stochastic, adjacency matrices are __unitary__, i.e. $U^\dagger U = I = UU^\dagger $
- the element-wise squared modulus of a unitary matrix is doubly stochastic
  - i.e. if $U$ is unitary with elements $u_{ij}$, then the matrix with elements $|u_{ij}|^2$ is doubly stochastic
- from the graph-theory perspective, if $U$ is the unitary matrix taking a state from $t$ to $t+1$, 
  then $U^{\dagger}$ is the matrix taking a state from $t$ to $t-1$
- consider the following sequence of operations:

$$
\bold{v} \rightarrow U\bold{v} \rightarrow U^\dagger U\bold{v} \rightarrow I\bold{v} = {v}
$$

- you get the identity matrix: in graph terms this means "stay where you are".  $U^\dagger$ undoes the action of $U$, leaving you
  with probability 1 where you started

### Double Slit

- probability of measuring photon at centrepoint classically: non-zero
- interference on the wall at the centrepoint of slits: 0 probability of photon at this location, even if the experiment
  was conducted with a single photon
- this suggests interpretation of the state vector as representing the probabilities of the photon being at a particular state is inadequate
- to have some state vector suggests that the photon is in all states simultaneously: the photon passes through both slits simultaneously, and when it does so
  it can cancel itself out
- photon is in a __superposition__ of states
- the reason we see particles in one position is because we have performed a __measurement__
- new definition of state: a system is in state $\bold{x}$ if after measuring it, it will be found in position $i$ with probability $|c_i|^2$
- superposition of states is the power behind quantum computing: while classical computers are in a single state at any moment, consider putting
  a computer in all states at once - lots of parallel processing
  - only possible in the quantum realm 

### Summary

- states in a quantum system are represented by column vectors of complex numbers whose sum of moduli squared is 1
- the dynamics of quantum systems is represented by unitary matrices, and is therefore reversible
- undoing is obtained via algebraic inverse: the adjoint of the unitary matrix which represents forward evolution
- probabilities of quantum mechanics are given as the modulus square of complex numbers
- quantum states can be superposed: a physical system can be in more than one basic state simultaneously

## Assembling Systems

- consider composite classical probabilistic systems, with results applicable to quantum systems
- composite systems: e.g. red marble follows graph $G_R$, and blue marble follows graph $G_B$, with corresponding adjacency matrices $A, B$
  - state for the two-marble system is the __tensor product__ of the state vectors of each system
  - dynamics for the two-marble system is the __tensor product__ of the adjacency matrices: this corresponds to the Cartesian product of 2 weighted digraphs

### Entangled States

- in the quantum world there are many more possible states than just states that can be combined from smaller ones
- __entangled states__ are those that are not the tensor product of smaller states
- there are also many more possible actions on a combined quantum system than simply that of the tensor product of individual system's actions

### Exponential growth

- Cartesian product of $n$ vertex graph with $p$ vertex graph is an $np$ vertex graph
- if you have an $n$ vertex graph G with $m$ different marbles, you need to look at the graph

$$
G^m = G \times G \times ... G
$$

which has $n^m$ vertices
- if $M_G$ is the associated adjacency matrix, we will be interested in

$$
M_G^{\otimes m} = M_G \otimes M_G \otimes ... \otimes M_G
$$

which is an $n^m$-by-$n^m$ matrix

- consider a bit as a 2-vertex graph with a marble on the 0 vertex/1 vertex
- to represent $m$ bits, each with a single marble, one would need a $2^m$ vertex graph, with a $2^m$-by-$2^m$ matrix
- this means exponential growth in resources needed for the number of bits under discussion
- this was the motivator for Feynman to start discussing potential of quantum computing
