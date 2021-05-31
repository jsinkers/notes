---
p> " 'Q' in normal mode enters Ex mode. You almost never want this.
title: Concurrency
notebook: Modelling Complex Software Systems
layout: note
date: 2021-03-05
tags: 
...

## Concurrency

### What?

- concurrency is a design principle: structuring programs to reflect potential parallelism
- sequential vs concurrent program: 
- sequential: single thread of control: one instruction pointer is sufficient to manage execution
- concurrent: multiple threads of control, allowing multiple calculations to occur at the same time,
  and simultaneous interaction with external events
- threads/processes in a concurrent program share data or communicate with 1+ threads in that program

### Why?

- natural model: e.g. user interface with keyboard + mouse + multiple windows
- necessity: e.g. autonomous robot requires multiple threads to respond appropriately
- performance: increased performance with multiple processors

### What makes it hard?

- processes need to interact:
- __communication:__ communication by accessing shared data/message passing
- __synchronisation:__ processes need to synchronise certain events: P mustn't reach p until after Q has reached q.
- __non-determinism:__ execution is non-deterministic - hence model checkers to formally establish properties

### Concurrent Language Paradigms

- __shared-memory:__ uses monitors
- e.g. Concurrent Pascal, Java, C#
- __message-passing:__ Hoare's idea of __Communicating Sequential Processes (CSP)__
- e.g. Go, Erlang, Occam

### Speed Dependence

- __speed-dependent:__ when concurrent programs are dependent on relative speeds of components' execution
- fluctuations in processor/IO speed are sources of non-determinism
- __real-time systems:__ when absolute speed of system matters (in embedded systems)

### Arbitrary interleaving

- model of concurrent behaviour: at level of atomic events, no 2 events occur at exactly the same time
- e.g. process P performs atomic actions a, b.  process Q performs x, y, z.
- 10 possible interleavings of these actions while maintaining order
- arbitrary interleaving model: these 10 sequences are the possible outcome of running P and Q concurrently

### Concurrent Programming Abstraction

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

### Atomicity

- assignments such as `n := n+1` are not atomic in most programming languages, as most compilers break them up
into more basic machine code instructions:  `load, increment, store`
- if 2 processes attempt to increment a shared variable simultaneously, the interleaving of these atomic instructions
could be `P.load, Q.load, P.increment, Q.increment, P.store, Q.store`, such that the result is only `n+1`
- each process falsely assumes exclusive access to n in the _read-change-write_ cycle
- __race condition/interference__
- requires __mutual exclusion__

### Correctness

- for a concurrent program to be correct it must be correct for _all_ possible interleavings
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

## Java Threads

- in Java processes are called threads

### Creation

Two ways to create:
  - extend `java.lang.Thread`: as Java doesn't support multiple inheritance this is not always possible
  - implement `Runnable` interface: recommended approach

### States

Alive thread is in one of these states:
- __running:__ currently executing
- __runnable:__ not currently executing, but ready to execute
- __non-runnable:__ not currently executing, not ready to run
  - e.g. waiting on input or shared data to become unlocked

![Java thread states](img/thread-states.png)

### Primitives

- `start()` causes JVM to execute `run()` in a dedicated thread, concurrent with the calling code
- a thread stops executing when `run()` finishes
- `sleep(long milliseconds)` allows you to suspend thread for specified time
- `isAlive()`: indicates whether thread is running
- `yield()`: causes current thread to pause (running -> runnable)
- transition from runnable -> running is up to runtime system's scheduler
- `t.join()` suspends caller until thread `t` has completed (i.e. two threads join together)

### More states

Additional states:
- having called `sleep()`
- having called `join()`
- waiting for a lock to be released: having called `wait()`

### Interruption

- Threads can be __interrupted__ via `Thread.interrupt()`
- if interrupted in one of the 3 above states, the thread returns to a __runnable__ state, causing
  `sleep(), join(), wait()` to throw an `InterruptedException`

## Mutual Exclusion (Mutex)

- N processes executing infinite loops, alternating between __critical__ and __non-critical__ sections
- process may halt in __non-critical__ section, but not in __critical__ section
  - shared variables are only written to in the critical section: to avoid race condition, only one thread can be in 
    critical section at any time

```java
class P extends Thread {
  while (true) {
    non_critical_P();
    pre_protocol_P();
    critical_P();
    post_protocol_P();
  }
}

class Q extends Thread {
  while (true) {
    non_critical_Q();
    pre_protocol_Q();
    critical_Q();
    post_protocol_Q();
  }
}
```

### Properties of mutex solution

- __mutual exclusion:__ only 1 process may be active in critical section at a time 
  - safety: ensure interference prevented
- __no deadlock:__ if 1+ processes trying to enter their critical section, one must eventually succeed
  - liveness
- __no starvation:__ if a process is trying to enter its critical section, it must eventually succeed

Also desirable:
- __lack of contention:__ if only one process is trying to enter critical section, it must succeed with minimal overhead
  - efficient

### Assumptions

- no variable used in protocol is used in critical/non-critical sections and vice-versa
- load, store, test of common variables are atomic operations
- must be progress through critical sections: if a process reaches critical section, it must eventually reach the end of it
- cannot assume progress through non-critical sections: a process may terminate or enter an infinite loop

### Attempt 1

- single protocol variable: token passed between processes `static int turn = 1;`
- processes wait for their turn
- properties:
  - mutex: yes.  Only 1 thread can enter a critical section at a time
  - no deadlock: yes. `turn` can only have values 1 or 2, so one process can always enter
  - no starvation: no: Q can be waiting for its turn while P executes non-critical section indefinitely.  Q never gets a turn - starvation.

### Attempt 2

- give each thread a flag.  Each thread can only modify its own flag
- a thread can only enter the critical region when the other process has lowered its flag.
- a thread raises its flag after waiting, as it is entering its critical region
- properties:
  - mutual exclusion: no. Possible for both processes to enter critical region simultaneously

### Attempt 3

- as in attempt 2, give each thread a flag.  Each thread can only modify its own flag
- now each process sets the flag prior to waiting
- properties:
  - mutual exclusion: yes
  - no deadlock: no. Both processes set flag prior to entering critical region.  Neither can proceed
  - no starvation: no, as there can be deadlock, both processes will starve
  - lack of contention: yes. if P is in non-critical section Q can enter its critical section

### Attempt 4

- as in attempt 3, give each thread a flag.  Each thread can only modify its own flag
- each process sets the flag prior to waiting
- if both processes have the flag raised, momentarily lower then re-raise the flag
- properties:
  - mutual exclusion: yes
  - no deadlock: yes. Lowering of flags removes deadlock
  - no starvation: no. Can get livelock, with infinite sequence of both processes lowering/raising flags without either entering critical region
  - lack of contention: yes, per attempt 3

__Livelock:__ processes are still moving, but critical section is unable to be completed

### Attempt 5: Dekker's Algorithm

- use flags + turn token
```java
static int turn =1;
static int p = 0;
static int q = 0;
```
- whoever previously entered critical section has lower priority to enter the critical section

```java
while (true) {
  non_critical_P();
  p = 1;
  // repeat while Q has flag raised
  while (q != 0) {
    // if it is Q's turn
    if (turn == 2) {
        // lower flag
        p = 0;
        // wait until its P's turn
        while (turn == 2);
        // raise p's flag
        p = 1;
    }
  }
  critical_P();
  turn = 2;
  p = 0;
}

while (true) {
  non_critical_Q();
  q = 1;
  // repeat while P has flag raised
  while (p != 0) {
    // if it is Q's turn
    if (turn == 1) {
        // lower flag
        q = 0;
        // wait until its Q's turn
        while (turn == 1);
        // raise Q's flag
        q = 1;
    }
  }
  critical_Q();
  turn = 1;
  q = 0;
}
```

- properties:
  - mutex: yes.  P only enters critical section if `q != 0`
  - no deadlock: yes, thanks to flag lowering
  - no starvation: yes, no livelock as in attempt 4 due to turn priority
  - lack of contention: yes.  If P is in non-critical section Q can enter critical section
- hard to generalise to programs with > 2 processes

### Peterson's Mutex Algorithm

- 1981 solution, scales more readily than Dekker's algorithm
- also uses flags and turn token

```java
static int turn = 1;
static int p = 0;
static int q = 0;

while (true) {
  non_critical_P();
  p = 1;
  turn = 2;
  // give Q a turn.  wait till it is complete
  while (q && turn == 2);
  critical_p();
  p = 0;
}
```
## Java: Monitors and synchronisation 

- correct algorithms for mutex are tedious and complex to implement
- concurrent programming languages offer higher-level synchronisation primitives
- Java offers
  - __synchronised methods/objects:__ a method/object can be declared `synchronized` - only 1 process can execute/modify it at a time
  - __monitors:__ set of synchronized methods/data that queue processes trying to access the data

### Synchronised methods

- `synchronized` keyword declares method/object as being executable/modifiable by only 1 process at a time
  - marks method as __critical section__

```java
synchronized void increment() { ... }
```

### Synchronized object

- can declare an object as synchronised, making entire object mutually exclusive:
- disadvantage: requires user of shared object to lock the object, rather than placing this inside shared object and encapsulating
- if user fails to lock object correctly, race conditions can occur

```java
class SynchedObject extends Thread {
  Counter c;

  public SynchedObject(Counter c) { this.c = c; }

  public void run() {
    for (int i = 0; i < 5; i++) {
      synchronized(c) {
        c.increment();
      }
    }
  }
}
```

### Volatile variables 

- declaring variable  `volatile` directs JVM to reload its value every time it needs to refer to it
  - otherwise compiler may optimise code to load value once only

### Monitors

- language feature that provides mutual exclusion to shared data
- in Java, a monitor is an object that encapsulates some private data, with access via synchronized methods
  - manages blocking/unblocking of processes seeking access
- e.g. bank account shared between parent and child
- leaving responsibility of wait to client of shared object is bad because
  - user has to continually poll: wasteful
  - code needs to be replicated for multiple clients
  - an incorrect implementation of any client means interference can occur
- monitors alleviate these issues by making the encapsulating class do the work
- __monitor:__ encapsulated data + operations/methods 
  - maintains queue of processing wanting access
- all objects in Java have monitors, having a lock that allows holding thread to access synchronized methods of the object
- `Object` contains 3 relevant methods:
  - `void wait()`: causes current thread to wait until another thread invokes `notify()` or `notifyAll()` for
    this object. (i.e. `wait()` causes the thread to block, and relinquishes the lock the thread holds to other waiting threads)
  - `void notify()`: wakes up a _single_ thread waiting on this object's lock
    - choice of thread is arbitrary (up to JVM)
    - not needed for this course
  - `void notifyAll()`: wakes up all threads waiting on object's lock

```java
class MonitorAccount extends Account {
    public synchronized void withdraw(int amount) {
        while (balance < amount) {
            // withdrawal cannot proceed.  get thread to wait until balance updates
            try {
                wait();
            } catch (InterruptedException e) {}
        }
        super.withdraw(amount);
    }

    public synchronized void deposit(int amount) {
        super.deposit(amount);
        // after deposit, notify all threads waiting for updated balance
        notifyAll();
    }
}
```
## Java: Semaphores 

- 
