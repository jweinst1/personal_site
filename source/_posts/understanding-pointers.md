---
title: Understanding Pointers
categories:
- guides
- C
tags:
- C
- coding
- tutorial
- guide
- learning
- beginner
---

The following is an in-depth, step by step method of understanding pointers, along with their core concepts.

## Intro

For many beginners in programming and software engineering, pointers can prove a difficult idea to grasp. Memory, addresses, dereferencing, these terms on their own have tricky definitions. In part, because they are usually not taught with practical examples. Here, we will explore the fine details of pointers, memory, and their true powers in programming. 

The main programming language used here will be C. It's the most effective for learning pointers as it let's you focus on raw pointers, not hiding anything behind the scenes. Additionally, C allows more in-depth exploration of the different memory types relevant for pointers. `new` and `delete` hide some details of the way pointers can access memory in `C++`.


## Fundamentals

In C, all variables have both a *type* and a *value*. Every *type* has some specific size. Every type's size in C, C++, and similar languages is defined in terms of *bytes*. A byte is for nearly all cases, an unsigned 8-bit integer. Below are some example C types:

```c
int a = 5;
long x = 7500;
float b = 3.4;
char c = 'e';
```

These types represent different varieties of data, and also have different sizes. In C and C++, you can determine the size of a value by using the `sizeof` operator. The size of any type *never* changes. Let's look at sizes of common C types by printing their respective `sizeof` calls.

```c
printf("sizeof int is %lu\n", sizeof(int));
printf("sizeof int is %lu\n", sizeof(a));
printf("sizeof long is %lu\n", sizeof(x));
printf("sizeof char is %lu\n", sizeof(c));
```

Which will print:

```
sizeof int is 4
sizeof int is 4
sizeof long is 8
sizeof char is 1
```

*Note*: When a variable is passed to `sizeof`, it's size is inferred from it's type. Calling `sizeof` on a type or a variable is identical in behavior.

Next, let's talk about memory.

### Memory

Previously, we discussed *types*, and their sizes. All values, data, and variables, whatever you want to name them, are stored in *memory*. For the purposes of this article, let's think of memory as a finite collection of bytes. In C, there are 3 main types of memory: *static*, *stack*, and *heap* memory.

> stack: Memory used within a function's call frame. It only exist while the stack frame of a function has not yet hit a *return* statement.
> heap: Memory allocated from functions like *malloc*, *calloc*, or *realloc*. This memory exists until it is deallocated with *free*.
> static: Memory used by declaring a variable *static*. This type of memory lives for the entire time the program is running, and usually is located in the data segment of the executable from the C program being run.
