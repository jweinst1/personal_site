---
title: The Chop Chop Hash
date: 2019-02-11 00:15:18
categories:
- C
- Crypto
tags:
- crypto
- blockchain
- cryptography
- hash
- cryptocurrency
- programming
- C
---

## Intro

The *chop chop* hash is a hashing algorithm that utilizies word *slices* and states to form a hash digest. Chop chop hashing performs operations with one slice or subportion of both the digest and the data being hashed at any particular time. Chop chop hashing is meant to be a high performance, high entropy algorithm, with modifications for cryptographic criteria. One of the most unique aspects of this algorithm is that, the state of the hash is not determined strictly by the input, and can be decoupled to varying degrees. 

*Chop chop* hashing intends to provide a medium between fast hashing functions and cryptographic functions, by sticking to an *implicit* algorithm, but allowing vast modification for different use cases. The *Chop chop* algorithm can also be used to generate random numbers.

## Algorithm

As mentioned previously, the chop chop algorithm can be modified in many ways to serve different purposes. However, in this section, the base, fundamental properties of the algorithm will be highlighted and laid out.

### Definition

The *chop chop* hashing algorithm can be defined as:

> Let *S* be a sequence of *N* integers, with size *Z*.
> Let *w* be a word, of size *r*, where `r % Z = 0`
> Let *Q* be a set of states of count *a*, where `a = r / Z`
> Each state shall represent a number of bits to left shift *S*,
> For all states *q* in *Q*, `q < bits(S)`, where `bits(S)` is the length of S in bits.
> Let *F(q1) -> q2* be a transition function, that has a both a domain and range of *Q*
> For all integers in *S*:


