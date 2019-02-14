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
> Let *q_i* be the initial state, and *q_c* be the current state.
> For all integers in *S*:
>> Let *c* be an integer from *S*
>> Shift *w* to the left by *q_i* bits.
>> Perform a bitwise operation on *w* and *c*
>> Apply the state transition function `q_c = F(q_i)`
>> Repeat, starting with *q_c* if the initial state is already transitioned.

The above definition results in *w* becoming hash digest. The "chop" name comes from the use of the left shift operator to perform XOR operations on only a slice or subset of the entire word. The varying slice of *w* being altered helps increase entropy in 32-bit, 64-bit, or greater sizes of digests. The variability of both *S* and *F(q1) -> q2* make the chop chop hash a great one way function, and extremely difficult to reverse.

### Implementation

For the most fundamental version of the *chop chop* algorithm, we can implent a function in C. This function shall take a C-string, (`\0` terminated sequences of `char`) as input, and return an unsigned 32-bit integer, representing the hash digest. The following implementation assumes `sizeof(unsgined) == 4`:

```c
unsigned chop_chop_hash(const char* text)
{
	unsigned chop_word = 0x4F3F28DB;
	int state = 0;
	while(*text) {
		chop_word = chop_word ^ ((*text++) << state);
		state += (state == 24 ? -24 : 8);
	}
	return chop_word;
}
```

Lets break down the above code to map the parts of the algorithm to what's in the code.

#### S: Sequence of Integers

In this function, *S* would be the `text` parameter,

```c
(const char* text)
```

#### w: A Word

Here, *w* is `chop_word`, the unsigned integer created at the top of the function:

```c
unsigned chop_word = 0x4F3F28DB;
```

`chop_word` begins with a large, non-relevant value. This is to allow smaller inputs to not have hash digests that are also too small. Hashes often get modded down, and if too many inputs result in low digests, more collisions will occur. 

#### Q: A set of states

`state` represents the set of states. Now, this isn't a true set. That's because for the most fundamental chop chop, the state is just incremented. It then resets after it reaches the state of `24`. In this implementation, the states represent the 8bit boundaries at which to left shift *w*.

```c
int state = 0;
```

#### Bitwise Operation on Word

The bitwise operation on the word described in the definition of the algorithm is this line:

```c
chop_word = chop_word ^ ((*text++) << state);
```

We take the current integer, which is really a `char` in this case, from *S*, shift it to the left according to the state, the XOR with *w*.

#### Transition Function

The transition function for the set of states in this case is the following line:

```c
state += (state == 24 ? -24 : 8);
```

This will keep incrementing the state by 8 bits, or normally the `CHAR_BIT` amount of bits, and reset once it gets to `24`. It resets at 24 due to the digest being 32bits in size. The expression `c << 24` allows the XOR operation in the previous line to target the most significant byte within the hash word.

For more varied and secure implementations, the state values can be intentionally misplaced. That way, the hash word is not really treated as a word containing *r integers of size Z*, where the nth integer of the input and the nth integer of the word undergo XOR, but rather the word acting as a *pool* of bits. Here, the states can take on any number of bits within the size of the word.

## Fine State Version

In the last section, a fundamental, clean version of *chop chop* was discussed. Now, let's look at a somewhat different version, that allows state in *fine* bit values. Using more states allows for finer digests, because the *chop* of bits in the word that are affected by XOR is more variable. This will increase entropy for larger inputs.

Here is a sample implementation:

```c
unsigned chop_chop_fine(const char* text)
{
    unsigned chop_word = 0x4F3F28DB;
    int state = 5;
    while(*text) {
        chop_word = chop_word ^ ((*text++) << state);
        state += (state == 31 ? -26 : 1);
    }
    return chop_word;
}
```

The only change in this function is the state. Instead of starting at `0`, the state starts at 5 and goes up to 31. This is to allow XOR slicing at uneven segments, in an attempt to produce more *fine* digests.

To more easily gauge how the hash digest changes with the input, we can use a simple macro:

```c

#define PRINT_HASH(string, fn) printf("The hash of '%s' is %u\n", string, fn(string))
```

And some example results:

```
The hash of 'hello' is 1329576091
The hash of 'world!' is 1329538299
The hash of 'Cardiologists' is 1334230011
The hash of 'my cat is named tom' is 1825024571
The hash of 'my name is bob, what's yours?' is 2936732315
```

Compared to the previous hash function:


```
The hash of 'hello' is 592661980
The hash of 'world!' is 592275144
The hash of 'foo' is 1330661309
The hash of 'key' is 1330007472
The hash of 'my name is bob, what's yours?' is 1027949521
```

**Notes**
* The base chop chop function has a higher entropy for smaller inputs.
* The fine function has more spread out digests for larger inputs.
* The most siginificant bits in a digest are the best for producing more entropy.
