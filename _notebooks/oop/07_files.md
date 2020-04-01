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
- [Reading files](#reading-files)
  - [Boilerplate for reading plaintext files](#boilerplate-for-reading-plaintext-files)
  - [Boilerplate: reading plaintext with `Scanner`](#boilerplate-reading-plaintext-with-scanner)
  - [Reading CSV files](#reading-csv-files)
- [Writing files](#writing-files)
  - [Boilerplate for writing plaintext files](#boilerplate-for-writing-plaintext-files)


## Reading files

### Boilerplate for reading plaintext files

```java
import java.io.FileReader;      // low level file for simple character reading
import java.io.BufferedReader;  // higher level file object that reads Strings
import java.io.IOException;

public class Program {
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

### Boilerplate: reading plaintext with `Scanner`
- can also use `Scanner`, allowing you to parse lines into tokens, read as integers, ...
```java
try (Scanner scanner = new Scanner(new FileReader("test.txt"))) {
    while (scanner.hasNextLine()) {
        // do stuff
    }
}
```

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

