---
title: Haskell 
notebook: Declarative Programming
layout: note
date: 2020-11-08
tags: 
...

# Functional Programming 

## Expression Evaluation 

- conceptually, you can consider Haskell runtime as executing a loop which
  - searches for a function call in the current expression
  - searches for a matching equation for the function
  - sets values of variables in matching pattern to corresponding arguments
  - replaces LHS of equation with RHS
- loop terminates when current expression contains no function calls
- what order should be chosen for rewriting?
  - Church-Rosser theorem: order doesn't matter for final value
  - does matter for efficiency

### Church-Rosser Theorem

- for rewriting system of lambda calculus, regardless of the order in which the 
  original term's subterms are rewritten, final result is always the same
- Haskell is based on variant of lambda calculus, so the theorem holds
- __not__ applicable to imperative languages

## Referential transparency

- __referential transparency:__ expression can be replaced with its value
  - requires expression has no side effects and is pure: must return same
    results on the same input 
- __impure functional language:__ e.g. Lisp, permits side effects like assignment
  so programs are not referentially transparent

## Single Assignment

- imperative/OO languages: variable has current value, which is mutable
- functional languages: variables are __single assignment__
  - no assignment statements
  - immutable: can define variable's value, but cannot redefine it

## Haskell type system

- type system is __strong, safe, static__
- strength refers to how permissive a type system is, with a stronger type
  system accepting fewer expressions as valid than a weaker one
- __strong__: type system guarantees a program cannot errors from trying to
  write expressions that don't make sense
  - no loopholes: cannot make an integer a pointer
    - C: `(char *) 42`
- __safe:__ running program will never crash due to a type error
- __static:__ types are checked when program is compiled
  - c.f. dynamic: types are checked when program is run
  - safe follows partially from static
- types can be automatically __inferred__

## Type classes

- membership of `Ord` implies membership of `Eq`, but not vice cersa

### Deriving

- deriving `Ord` uses ordering in declaration for the comparison function
  - lexicographic ordering used if there are multiple values in top level data constructor

## Disjunction and conjunction

```haskell
data Suit = Club | Diamond | Heart | Spade
data Card = Card Suit Rank
```

- __enumerated type:__ value of type `Suit` is __either__ `Club` or `Diamond` ...
  - disjunction of values
- __structure type:__ value of type `Card` contains a value of type `Suit` __and__
  a value of type `Rank`
  - conjunction of values
- most imperative languages permit types as disjunction or conjunction, but not 
  both at once
- Haskell doesn't have this limitation

### Discriminated Union Types

- __discriminated union types:__ can include both disjunction and conjunction
  - in C, you could create a similar union, but wouldn't be able to determine
    which field was applicable
  - in Haksell, data constructor tells you, hence __discriminated__
- __algebraic type system:__ permits combination of disjunction + conjunction
  - __algebraic types:__ types produced under algebraic type system

```haskell
data JokerColor = Red | Black
data JCard = NormalCard Suit Rank | JokerCard JokerColor
```

- value of `JCard` constructed
  - either using `NormalCard` constructor, containing a value of type `Suit` and a 
    value of type `Rank`
  - or using `JokerCard` constructor, containing a value of type `JokerColor`

## Representing Expressions in Haskell

```haskell
data Expr
    = Number Int
    | Variable String
    | Binop Binopr Expr Expr
    | Unop Unopr Expr

data Binopr = Plus | Minus | Times | Divide
data Unopr  = Negate
```

- very direct, much shorter than C/Java implementation, no comments required

### Errors 

The C implementation is error prone:

- able to access fields that aren't meaningful
  - caught by Haskell, Java compiler
- can forget to initialise fields
  - caught by Haskell compiler
  - not caught by Java
- can forget to process some alternatives
  - caught by Java
  - can be caught by Haskell (with particular flags)

### Memory

- C: requires 8 words per expression
- Java/Haskell: maximum of 4
  - can be __more__ efficient than a C program

### Maintenance

- adding a new expression:
  - Java: add new class
    - implement all methods
  - C: add new alternative to enum
    - add needed members to the type
    - add code for it to all functions handling that type
  - Haskell: add new alternative to the type
    - add code to all functions handling that type
- adding a new operation for expressions
  - Java: add new method to abstract `Expr` class
    - implement it for all classes
  - C: write one new function
  - Haskell: write one new function

## Non-Exhaustive Patterns

- Haskell: Detect with `-fwarn-incomplete-patterns`
  - if not handled, will throw an exception
- C: without default case program may continue and silently compute incorrect result
  - requires more implementation of default cases
- Java: forgetting to write a method for subclass will probably inherit the wrong 
  behaviour of the superclass

## Recursion vs Iteration

- functional languages have no constructs for iteration
- what you do with iteration in imperative languages is done with recursion in functional languages

- viewpoints
  - writing code
  - reliability
  - productivity
  - efficiency

- as Haskell uses lists instead of arrays, compiler can warn when you are going to do something
  wrong.  C compiler can't provide such warnings
- Haskell gives meaningful name to jobs done by loops
- functional program's structure is closer to what you would need to build a correctness 
  argument, helping make them more reliable
- named auxiliary functions helps readability

### Efficiency

- recursive versions of e.g. `search_bst` allocate one stack frame per node traversed
  - iterative version: 1 stack frame overall
  - recursive is less efficient: allocate, fill in, deallocate stack frames
  - recursive version also needs more stack space
- emphasis of compilers on optimisation of recursive code: in many cases they can produce
  iterative code in the target language
- declarative programs are typically slower than if written in C
- depending on which language/implementation, as well as the particular program the slowdown
  can be few percent to 100x.
- other popular languages (Python, Javascript) are also significantly slower than C, and often
  significantly slower than corresponding Haskell programs
- trade off between speed and level of programming language

## Sublists

- write a function `sublists :: [a] -> [[a]]` that returns a list of all sublists of a list
- a list `a` is a sublist of a list `b` iff  every element of `a` appears in `b` in the same order

```haskell
sublists "ABC" = ["ABC", "AB", "AC", "A", "BC", "B", "C", ""]
sublists "BC" = ["BC", "B", "C", ""]
```

Notice: combining "A" with `sublists "BC"`, followed by `sublists "BC"`, gives `sublists "ABC"`
The base case: the only sublist of `[]` is `[]`, so list of sublists is `[[]]`
The recusrive case: sublists of a list is the sublists of its tail, both with and without the head
added to the front of each list

```haskell
sublists :: [a] -> [[a]]
sublists [] = [[]]
sublists (x:xs) = map (x:) tail ++ tail
  where tail = sublists xs
```

## Immutable data structures

- data structures are __immutable__ in declarative languages, i.e. once created they cannot be 
  changed
- to update:
  - create another version of the data structure with changes, and use the new version
  - you can also keep the old version if needed: e.g. undo, statistics, ...

## Polymorphism

- __monomorphic__
- __polymorphic__

## `Data.Map`

- polymorphic tree in standard library is `Map` from the `Data.Map` module
- key functions:

```haskell
insert     :: Ord k => k -> a -> Map k a -> Map k a
Map.lookup :: Ord k => k -> Map k a -> Maybe a
(!)        :: Ord k => Map k a -> k -> a -- infix operator
size       :: Map k a -> Int
```

## `let` vs `where`

- `let` clauses can be used for any expression
- `where` clauses can only be used at the top level of a function

- introduce a name for a value used in the main expression

```haskell
let name = expr in mainexpr
mainexpr where name = expr
```

## Higher Order Functions

- 1st order values: data
- 2nd order values: functions whose arguments, results are 1st order values
- 3rd order values: functions whose arguments, results are 1st or 2nd order values
- __nth order values:__ functions whose arguments, results are values of order up to $(n-1)$
- __higher order values:__ belong to an order higher than 1st
- higher order programming is central to Haskell, and often allows you to avoid writing recursive
  functions

### Higher order functions in C

- function pointers: `Bool (*f)(int)`
  - ugly, complicated

### Higher order function in Hskell

- much simpler and more natural, but also polymorphic

```haskell
filter :: (a -> Bool) -> [a] -> a
filter f (x:xs) = if f x then x:filter xs else filter xs
```

### Partial Application

- __partial application:__ giving a function that takes $n$ arguments $k$ arguments, $k < n$
- produces a __closure__, recording the identity of the function and the values of those $k$ 
  arguments
- closure behaves like a function with $n-k$ arguments
- a call of the closure leads to a call of the original function with both sets of arguments
  - see e.g. definition I gave of `sublists` above

### Operators and sections

- __section:__ by enclosing an infix operator in parentheses, you can partially
  apply it by enclosing it with __either__ left or right operand

```haskell
> map (5 `mod`) [3,4,5]
[2,1,0]
> map (`mod` 3) [3,4,5]
[0,1,2]
```

### Currying

- you can keep transforming the function type until every single argument is supplied separately

```haksell
f :: at1 -> (at2 -> (at3 -> ... (atn -> rt)))
```

- __currying:__ transformation from function type with all arguments supplied
  together to a function type with all arguments supplied one-by-one
- in Haskell __all function types are curried__
- this is why it uses the arrow syntax for function types
- NB arrow is right associative
- what do you get when you've supplied all arguments?  Either
  - closure containing all the functions arguments, or
  - result of evaluation of the function
- in C, and most other languages, these would be different, but in Haskell, they are equivalent

### Function Composition

```haskell
(f . g) x = f (g x)
```

- __point-free style:__ writing functions without arguments e.g. `minimum = head . sort`
- function composition expresses a sequence of operations: `step3f . step2f . step1f`
- this forms the basis of monads
