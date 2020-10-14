---
title: Monads
notebook: Declarative Programming
layout: note
date: 2020-10-04
tags: 
...

# Monads

[TOC]: #

## Table of Contents



## Notes: Computerphile Monads

Consider a data constructor for an expression which captures integer division:

```haskell
Data Expr = Val Int | Div Expr Expr
```

Let's write a function that can evaluate these expressions:

```haskell
eval :: Expr -> Int
eval (Val n) = n
eval (Div x y) = (eval x) `div` (eval y)
```

But this is unsafe: if you attempt division by 0 you'll get an error.  So let's define a safe division operation

```haskell
safediv :: Int -> Int -> Maybe Int
safediv n m = if m == 0 
                then Nothing 
                else Just (n `div` m)
```

Now we can rewrite `eval` to be safe:

```haskell
eval :: Expr -> Maybe Int
eval (Val n) = Just n
eval (Div x y) = case eval x of
                    Nothing -> Nothing
                    Just n -> case eval y of 
                                Nothing -> Nothing
                                Just m -> safediv n m
```

Now we have a program that will work safely.  But it's pretty ugly and verbose.
How can we make it better, and look more like the original code, while still being safe?

First observe that there's a common pattern here: 2 case analyses, doing the same thing.  Let's 
abstract this out, introducing `m, f`:

```haskell
case m of
    Nothing -> Nothing
    Just x -> f x
```

And let's give a name to this `m >== f`:

```haskell
m >== f = case m of 
            Nothing = Nothing
            Just m -> f m
```

With this definition, let's rewrite `eval`:

```haskell
eval :: Expr -> Maybe Int
eval (Val n) = return n
eval (Div x y) = eval x >>= (\n -> 
                 eval y >>= (\m -> 
                 safediv n m))
```

This is equivalent to the last definition of `eval`, but we've abstracted away all the case analyses.
But we can still do better, with the syntactic sugar of the `do` notation, which gives a helpful shorthand
for programs of this sort:

```haskell
eval :: Expr -> Maybe Int
eval (Val n) = return n
eval (Div x y) = do n <- eval x
                    m <- eval y
                    safediv n m
```

This is much nicer.  All the failure management is handled automatically.

### Where do the monads come in?

So what does all this have to do with monads?  Effectively we have rediscovered the `Maybe` monad, which comprises 
3 things: the `Maybe` type constructor, and 2 functions:

- `return :: a -> Maybe`: a bridge between the pure and the impure
- `>>= :: Maybe a -> (a -> Maybe b) -> Maybe b`: sequencing

That's all a monad is:

1. Type constructor `m`
2. `return` definition, a function of type `a -> m a` for injecting a normal value into the chaing.  It _returns_ a pure value
   into a monad
3. Bind: `>>=` definition, a function of type `a -> (a -> m b) -> m b` for chaining the output of one function
   to the input of another
   

### What's the point?

1. The same idea works for other effects: I/O, mutable state, non-determinism, ...  Monads give a uniform 
  framework for thinking about programming with effects.
2. Supports pure programming with effects: i.e. gives you a way to do impure things in a pure language
3. Use of effects is explicit in types: evaluator function here takes an `Expr` and returns a `Maybe Int`.  You 
  explicitly state what effects may be produced.
4. Provides ability to write functions that work for any effect, __effect polymorphism__.  Haskell has libraries of
  generic effect functions.

## Monad Jargon

- __monadic__: pertaining to monads
- __is a monad__: it's an instance of the `Monad` typeclass, i.e. it has a monadic triple of:
   (type constructor, injection function, chaining function).
- __the `Foo` monad__: talking about the type named `Foo`, which is an instance of `Monad`
- __action__: another name frame a moadic value

## 
