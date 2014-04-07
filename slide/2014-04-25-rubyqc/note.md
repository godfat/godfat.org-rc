
# Note for RubyQC -- A conceptual QuickCheck library for Ruby

## 1

Today I'll talk about RubyQC, a conceptual QuickCheck library for Ruby.
If you don't know about what's QuickCheck, don't worry, I'll explain the
concept. Actually, that's the main point of this talk today, less about
RubyQC itself. It's merely an example to demonstrate the idea.

That means, if you already know what's QuickCheck, sorry, you might not
find this talk very interesting. You could checkout this slide, following
this URL (point at the URL to the slide), moving forward, or read RubyQC
source (point at the RubyQC words), this is the link to the source on Github.

## 2

So let me introduce myself first. godfat is usually my account name on
the Internet, and Lin Jen-Shin is my real name. C is my first programming
language, and later on I learned object-oriented programming with
ActionScript, that is, the programming language used in Macromedia Flash,
at the time before Adobe purchased it. Next I did some C++ programming,
and now I am mostly working with Ruby.

Haskell, I don't yet really work with it, I hope in the future, but I didn't
get a chance yet, and that's where I learned about QuickCheck, which is a
Haskell's library for writing tests.

Haskell is really a fascinating programming language, so I really want to
bring some goodies back to Ruby, making my daily life better. There are some
QuickCheck like libraries for Ruby, but none of them are popular nor complete.
Therefore in the end I decided to do my own.

## 3

Correctness. Since QuickCheck is a testing library, we talk about correctness.
(next bullet) Here's an excerpt from Wikipedia. (point at the excerpt)

> In theoretical computer science, correctness of an algorithm is asserted
> when it is said that the algorithm is correct with respect to a
> specification.

> 在理論電腦科學裡，正確性是指一個演算法是否正確地符合規格。

## 4

Or informally (非形式地), we could say, correctness is about if the program
would do what we expected (according to the specification), but not what we
said (wrote the program). You know, computers are stupid, they can't think
for you, and sometimes we just didn't mean what we said... For human beings,
we have intelligence, we have knowledge, we have culture, we have common
sense, so we could intelligently infer what the speaker or author might
really want to say, instead of simply reading the words.

In other words, what we said might not mean what we thought, and we need
some way to verify if what we said does really mean what we thought,
therefore we could make sure we're not misunderstanding and therefore
we're not misbehaving.

(probably find some images for showing this instead of putting words)

So, to verify, we could either: (next slide)

## 5

Prove it. (next slide)

## 6

Bah, but we're not talking about proving it formally here. There are tools like Agda or Coq could help you prove the programs, but since I am not good
at this. Let's leave it to the scholars, maybe...

## 7

Today we're talking about tests, which is the other approach to verify if
our programs are correct. We could think this way: (next slide)

## 8

The blue circle illustrates the universe, meaning all the possible programs,
input/output combinations, behaviours, you name it. The red circle
illustrates our program, which we want to verify. It's a subset of the
universe, of course. A very small subset.

## 9

Proofs are the superset of our program, well, ideally. Of course we might
not have any proofs or only prove a very small part of the program, then
they are not a superset of the program. The point is that we want the proofs
be the superset of our program.

For example, we could prove that Socrates is mortal, but we don't have to
kill Socrates in our program to prove that. Proofs are saying our program
would never do something outside the range of them. They limit our program.

(next bullet)

Tests take the other approach. They are the instances of runtime behaviours
of our program, given fixed input and produce fixed output. The fixed outputs
are our expectation. Since we can't really exhaust all the possible inputs,
or if we do, that would be exactly the same set as our program... and then
of course we would know all the possible consequence, therefore we would know
exactly what our program really mean. For non-trivial programs, this is not
really possible and realistic.

So, tests would be a very small subset of our program, in most cases.

(some images here?)

## 10

Tests. The simplest ones are scenario based. Given some preconditions,
when something is happening, then we would expect blah, blah, blah...
Easy to understand, easy to write, and since it's actually some kind of
use cases, or user stories, or whatever... We have tons of terminologies,
to me, they share the same concept.

(next bullet)

The other approach, yes, QuickCheck. We'll walk through it. Also note that
this is not an exhausted list for all kinds of possible tests. We're
inventing methodologies and terminologies all the time...

Let's walk through an example.

## 11

Plus. Suppose we're writing a program which could do addition.
We might write this...

## 12

That's probably silly since this is merely an alias of the built-in plus.
Anyway, some algorithm here. (next bullet)

For scenario based tests, we wrote (point at the tests). This looks like
RSpec but personally I use bacon, they share similar API.

Given 1 and 1, when we put them together, we expect the result should be 2.
Given 1 and 2, when we put them together, we expect the result should be 3.
Given 2 and 1, when we put them together, we expect the result should be 3.
Given 2 and 2, when we put them together, we expect the result should be 4.

Instances of the possible execution. (next bullet) Of course they are only
a small subset of the program. We're not testing the other possible inputs.

## 13

What if we want to test all possible inputs? Something like this?
(point at the code)

From the least number to the greatest number... this doesn't run but you
get the idea. Also forget about duck typing here, suppose we're writing
numeric addition.

(next bullet) We can't iterate through infinity in limited time.

## 14

What if we only sample it 100 times? Now we could just take some random
numbers. (point at rand) This is not ideal since we know that rand is not
really random and it does not really sample from infinity, but you get the
idea, again.

## 15

Kinda work, but... what should we fill here? (point at the question mark)

## 16

x plus y? (point at it) Actually this would work, suppose we have some
reference implementation here, for example, we could launch Python to
verify if it did the same thing as Ruby... or ask Google...

## 17

Or this one? (point at the code) You could think this as calling an
alternative implementation...

## 18

Or this one?

## 19

See, we flip the arguments. This is not doing the same thing as the
original addition. If we don't know what's the program we're testing
here, we can't do this. But since we know that, we're doing addition
here, we know that this is actually the same thing, and this is called...

## 20

Commutativity (交換律). x plus y is equal to y plus x. And we also know that
(next bullet) Addition is associative (結合律), that is (point at the code)
we could change the parentheses without affecting the result. Here in Ruby
it would also mean the order of execution.

## 21

So in RubyQC, we would write this. (point at the code) Given two fixed
numbers x and y, x plus y is equal to y plus x. Which x and y are generated
from RubyQC. Here you know that it's implemented based on rand. By default,
RubyQC would run the block 100 times, so we test 100 samples from all
possible inputs.

We say we quickly check the commutativity for addition for 100 times.

## 22

We do the same thing for testing associativity. Might be a bit uglier,
but that's what would happen if we don't have binary operators.

## 23

Another example. Sort.

## 24

Here's the full code. require bacon, require RubyQC, tell bacon to summary
on exit, making RubyQC API visible in bacon tests, and here's the thing.
(point at test case)

What properties does array sort have?

We know that for any former elements, any latter elements relative to the
former elements would be greater or equal to the former elements. We don't
really have to check all the combinations, according to mathematical
induction, we only need to verify for each cons of two.

Using RubyQC API here (point at [Fixnum]*100) means we want a random array
which consists with 100 fixed numbers, and (point at times(10)) we only
verify 10 arrays instead of 100 arrays.

We could tweak the numbers (point at [Fixnum]*100 and times(10)) if we have
faster machines, or if we don't care if the tests would run slow.

The greater numbers they are, the more confidence we would have.

## 25

(should have more examples here)

So with RubyQC, we think properties instead of scenarios. It complements
scenarios based tests, not replaces them. We need both of them.

## 26

The design of RubyQC. It's testing framework agnostic, so you could
integrate it with any testing frameworks you like. Since it's framework
agnostic, we could also treat it as an arbitrary object generator.
We could easily extend RubyQC to generate custom instances, all due to
the nature of combinator, making us compose generators easily.

And, we test RubyQC with RubyQC.

## 27

Recap. RubyQC is a conceptual QuickCheck library for Ruby, taking the other
approach to test and verify if our programs are correct, forcing you to think
about the properties your programs have, instead of all those special cases...

## 28

Any questions? You could checkout the source,
and install and play with it now.
