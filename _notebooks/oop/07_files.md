---
title: Files
notebook: Object Oriented Programming
layout: note
date: 2020-03-24 13:27
tags: 
...

# Files

[TOC]: #

## Table of Contents
- [Input: Command line arguments](#input-command-line-arguments)
- [Input: Scanner](#input-scanner)
  - [Read in various data types](#read-in-various-data-types)
  - [Scanner example](#scanner-example)
  - [Boilerplate: reading plaintext with `Scanner`](#boilerplate-reading-plaintext-with-scanner)
- [Reading files](#reading-files)
  - [Boilerplate for reading plaintext files](#boilerplate-for-reading-plaintext-files)
  - [Reading CSV files](#reading-csv-files)
- [Writing files](#writing-files)
  - [Boilerplate for writing plaintext files](#boilerplate-for-writing-plaintext-files)


## Input: Command line arguments

```java
void main(String[] args)
```
- `args`: variable storing command line arguments as array of `String`s
- [Guide](https://www.jetbrains.com/help/idea/creating-and-editing-run-debug-configurations.html)
  to configuring IntelliJ for command-line args

Write a program that creates a `Person` object from 3 command line arguments (age, height, name), and
then outputs the object as a string
```java
class Program {
    static void main(String[] args) {
        int age = Integer.parseInt(args[0]);
        double height = Double.parseDouble(args[1]);
        String name = args[2];
        Person person = new Person(age, height, name);
        System.out.println(person);
    }
}
```

## Input: Scanner

- [Documentation](https://docs.oracle.com/javase/8/docs/api/java/util/Scanner.html)
- `import java.util.Scanner`
- create scanner: `Scanner scanner = new Scanner(System.in);`
- `System.in`: object representing standard input stream
- only ever create **one** `Scanner` for each program
- `nextLine()`: reads a single line of text up until a newline character
  - this is the only method that **eats** newline characters
  - in some instances you need to follow `nextXXX` with `nextLine` if input
    is on multiple lines
- `next()`: returns next complete token from the scanner (i.e. up to next delimiter)

### Read in various data types

Scanner reads in a single value matching the method name

```java
boolean b = scanner.nextBoolean();
int i = scanner.nextInt();
double d = scanner.nextDouble();
```

- `Scanner` does not automatically downcast (e.g. `float` to `int`)
- when using `nextXXX` it is up to programmer to ensure input matches what
  code expects
- `hasNext()`: returns `true` if there is any input to be read
- `hasNextXXX()`: returns `true` if the next _token_ matches _XXX_

### Scanner example

Write a program that accepts three user inputs, creates an IMDB entry for an `Actor`
and prints the object:
- `String name`: name of character
- `double rating`
- `String review`

```java 
import java.util.Scanner;

public class Program {
    public static void main(String[] args) {
        String name = scanner.nextLine();
        double rating = scanner.nextDouble();
        scanner.nextLine();
        String review = scanner.nextLine();
        Actor actor = new Actor(name, rating, review);
        System.out.println(actor);
    }
}

public class Actor {
    public static final int MAX_RATING = 10;
    public String name;
    public double rating;
    public String review;
    
    public Actor(String name, double rating, String review) {
        this.name = name;
        this.rating = rating;
        this.review = review;
    }
    
    public String toString() {
        return String.format("You gave %s a rating of %f%d\n",
            name, rating, MAX_RATING) +
            String.format("Your review: '%s'", review);
    }
}
```

### Boilerplate: reading plaintext with `Scanner`

- can also use `Scanner`, allowing you to parse lines into tokens, read as integers, ...

```java
import java.util.scanner;
try (Scanner scanner = new Scanner(new FileReader("test.txt"))) {
    while (scanner.hasNextLine()) {
        // do stuff
    }
}
```

## Reading files

### Boilerplate for reading plaintext files

```java
import java.io.FileReader;      // low level file for simple character reading
import java.io.BufferedReader;  // higher level file object that reads Strings
import java.io.IOException;     // handle exceptions

public class ReadFile {
    public static void main(String[] args) {
        try (BufferedReader br = new BufferedReader(new FileReader("test.txt"))) {
            String text;
            while ((text = br.readLine()) != null) {
                // do stuff with text
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

```

- `BufferedReader` is a wrapper that encompasses `FileReader`, allowing you to
  manipulate files
  - well suited to large files and fast processing
- can use `Scanner` to read files, allowing you to parse text as you read it
  - smaller buffer size
  - slower than `BufferedReader`
  - works well for small files


### Reading CSV files

```java
String[] columns = text.split(",");
```

## Writing files

### Boilerplate for writing plaintext files

```java
import java.io.FileWriter;  
import java.io.PrintWriter;  
import java.io.IOException;

public class Program {
    public static void main(String[] args) {
        try (PrintWriter pw = new FileWriter("test.txt")) {
            pw.println("Hello World");
            pw.format("Test a %s and an integer %d", "string", 10);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

