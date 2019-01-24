---
title: projects
date: 2019-01-22 14:06:23
---

Below are the projects I am currently working on. These include both software projects and books about C/C++ or other software.

## dr4

[Website](https://dr4f.github.io/site/)


`dr4` is a revolutionary data format that allows, quick, scalable, and organized access to object oriented data. It's readily usable for data science, logging, machine learning, web applications, and much more.

However, unlike file and data formats such as JSON or XML, `dr4` is unique in that it's binary. dr4 is also designed to be readable and writable without any parsing or handling overhead. Additionally, it can also be used much like CSV, easily appendable or joinable with other dr4 documents, without the extra hassle.

What makes `dr4` unique is that, unlike other binary data formats, it's not limited by a specific size of bytes for the entire document, and can easily be grown without reading the entire file. With formats such as BSON, the entire file is sized by a signed 32-bit integer at the beginning. With dr4, files and documents are treated as unsized collections of objects and data. A small amount of version and meta data is kept at the start of the file, but beyond that, it's pure data!

## Wind

[Book](https://www.amazon.com/Wind-Flow-based-Programming-Joshua-Weinstein/dp/1720190577)

[Repository](https://github.com/jweinst1/Wind)

Wind is a flow-based programming language intended for ultra fast performance, and high portability. It's a language meant to be used on embedded systems, or for resource-constrained systems. Wind allows fast, efficient manipulation and processing of dynamically typed data, without using dynamic memory allocation. 

It supports common collection operations such as mapping, filtering, and reduction. This book details the paradigm of flow-based programming in a new perspective, dealing with optimizing small scale environments for large scale work. The first section of the book covers the fundamentals of flow-based programming relevant to understanding the Wind language. The next section delves into the syntax and type system of Wind. One of the huge advantages of Wind is it uses a compact, byte-sized type system that can write data to files and easily load it again later. 

This section also covers the commands and flow of source code to optimize programming in Wind. Lastly, the final section covers the implementation of Wind and the techniques used under the hood to ramp up performance and scalability.

