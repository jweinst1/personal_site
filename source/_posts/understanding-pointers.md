---
title: Understanding Pointers
date: 2019-02-02 00:10:18
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

Unlike stack memory, heap memory is never freed automatically during the runtime of the program. C++ classes have destructors or smart pointers which can do this, but C does not. Abandoning the last pointer to a chunk of heap memory without freeing it results in a *memory leak*, a situation where allocated memory on the heap can no longer be reached in order to be freed.

Below are examples of pointers to different types of memory:

```c
static int foo = 6;
int doo = 3;
int* static_ptr = &foo;
int* heap_ptr = malloc(sizeof(int));
int* stack_ptr = &doo; 
```

Here, `foo` is declared as `static`, rendering it static memory. Although we are not inside a function body, assume that `doo` is a stack allocated variable and not a *global* variable. The pointer `static_ptr` is initialized via using the addressof operator, `&`. Yet, `heap_ptr` is not. That's because the function `malloc` already returns a pointer, not a value. The addressof operator is used to determine the address of a value. Specifically, these are values that are not lvalues. For now, let's talk about addresses.

## Pointers

Now that we have discussed some fundamentals of C sizes and data types, let's dive into the main topic, pointers.

### Addresses

All bytes in memory, be it stack memory, static memory, or heap memory carry some *address*. An address is a unique, integer location of where a value currently exists in memory. Much like real residental and business addresses, each address is unique, and can tell us how to find where someone lives, or where some business operates. Similarly, values and data can move between addresses, if a program reads and writes them accordingly. Just as people move to new residences, and so on.

Unlike real people though, values in C, and related languages can exist without an address. This distinction is known as *lvalues* and *rvalues*. An *lvalue* in C is a value that's normally found on the left side of an assignment statement `=`. While an *rvalue* is normally found on the right side. For example,

```c
int x = 4;
int* y /*lvalue*/ = &x; /*rvalue*/
``` 

In the above example, `int * y` is an lvalue because it's a declaration. It's not a quanatitive or data-based value. We can perform operations *on* y. `&x` is an rvalue, because it's an address, an immutable integer. We can't perform operations on `&x` because it's an immutable constant.

### Indirection

The primary purpose of pointers is to pass around values without having to copy the entire value every time it moves. A part of that purose is also to be able to read and write to the address in memory that a pointer *points* to. This is done through pointer *indirection*. Indirection is an expression, an lvalue, that corresponds to the data a pointer points to. The following is a full program example to illustrate this.

```c
#include <stdio.h>

int main(void) {
	int a = 5;
	int* b = &a;
	while(a < 50) {
		*b += 5;
		printf("a is now %d\n", a);
	}
	return 0;
}
```

This program will print several messages to `stdout` like so:

```
a is now 10
a is now 15
a is now 20
a is now 25
a is now 30
a is now 35
a is now 40
a is now 45
a is now 50
```

In this program, a stack-allocated integer, `a`, is being continuously added to by a pointer to it's address, `b`. The pointer manages this by *indirection*. It uses the unary `*` operator to create an lvalue that allows binary operations like addition, in this case. Furthermore, it is always true that, `a == *b`. Thus, the statements `a += 5;` and `*b += 5` are equivalent.

### Pointer Arithmetic

Pointers can be modified via arithmetic. Previously, we have seen pointers moved with the increment and decrement operators, `++` and `--` respectively. However, pointers can also be modified via *relative expressions*. In one of the first sections, we explored pointers represent different *sizes* of data.

When pointers are expressed via arithmetic, they are expressed in respect to the size they represent. For example:

```c
#include <stdio.h>

int main(void) {
    int bin[5];
    int* b = bin;
    while(b < bin + 4) {
        printf("the value of b is %d, while the address is %p\n", *b, b);
        b++;
    }
    return 0;
}
```

The program above iterates through on array of integers, printing the address of each integer and it's value. This example also brings up another concept, the similarity between *arrays* and *pointers*. For now though, let's break down what's going on:

```c
while(b < bin + 4)
```

In this `while` condition, we are comparing the addresses of pointers, as well as expressing a pointer four addresses *forward*. In memory, addresses are sequential, and increase as each successive stack frame is created. The `<` operator for pointers, and similar logical operators, act in respect to the size of data the pointer points to. We can see this in the output of the program:

```
the value of b is 0, while the address is 0x7ffeefbff560
the value of b is 0, while the address is 0x7ffeefbff564
the value of b is 0, while the address is 0x7ffeefbff568
the value of b is 0, while the address is 0x7ffeefbff56c
```


