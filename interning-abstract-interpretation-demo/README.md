This set of notes is designed for use in a grad-level program analysis
class such as UW CSE 503, after the students have been introduced to
abstract interpretation (i.e., they should know and understand terms
such as "abstract domain," "abstraction function," "concretization
function," "galois connection," "lattice/lattice point," "least upper
bound," etc.). The general assumption is that students have read an
introduction such as [this
one](https://homes.cs.washington.edu/~mernst/tmp159/program-analysis-book.pdf).

This demo is intended as a precursor to [this
exercise](https://github.com/kelloggm/div-by-zero-checker), which asks
the students to build an abstract interpretation for preventing
division-by-zero errors using the Checker Framework. The goal of these
notes is to relate the code in an existing Checker Framework checker
(the Interning Checker, in this demo) to the terminology of abstract
interpretation that are covered in a class.

These notes are written from the perspective of the instructor, as a
script for how to run the class. Running the demo takes about 45
minutes.

==============

**Introduce the problem**. Few, if any, will have encountered it
before, but it’s very important in Java. Do this on the whiteboard,
mostly based on the first part of the [Interning Checker
section](https://checkerframework.org/manual/#interning-checker) in
the Checker Framework manual. Discuss the requirements on the
arguments to `==` especially, and mention that the JLS guarantees that
`String` literals and all primitives are interned. Java also lets you
intern things yourself, e.g. via `String#intern`.

**Compile and run** the Java file `Compare.java`, which will show what
is and isn’t interned. Walk the students through the code to explain
the JLS rules.

Ask the students to get out a piece of paper and **draw a lattice**.
Mention that a goal is to ensure that the arguments of `==`
must be interned (that is, the design must be sound). (This should take
1-2 minutes.)

Typically, expect answers like:

   T
   |
Interned
   |
   丄

or 

         T
    /	     \
Interned   Not interned
    \	     /
        丄

Glance at their papers, and **ask one student who drew each candidate
lattice to draw it on the board**. Ask the class to discuss which makes
the most sense for the problem at hand.

Next, **explain that the CF chooses this lattice**:

Maybe interned
     |
 Interned

**Ask** them which lattice they drew on the board it’s most like.

**Relate** the CF’s lattice to the Java type system: CF chose this
lattice to make the resulting AI more familiar to users of that type
system.

* Does the Java type system form a lattice (yes)?  Ask them
what top (Object) and bottom (null) are.

* Ask for the lub function; maybe do the traditional Lion <: Mammal <: Animal
thing, and relate it back to an AI. If the class is digging it, ask how
interfaces + abstract classes fit in (easily). Making this comparison is
key. Consider also mentioning at this point that AI and type systems are
equally expressive (Patrick Cousot. Types as abstract
interpretations. POPL ’97).

**Show code**: `src/org/checkerframework/checker/interning`.

Open the **qual directory**: annotations that represent each lattice
point (bonus question to ask: how would this work for infinite
lattices? Annotation arguments!). (You may need to explain what Java
annotations *are* at this point, if the students haven’t seen them.)

From the qual directory, open `UnknownInterned.java`. This is the
annotation that represents the “maybe interned” lattice point. There
are a few things to point out/explain here:

* Lattice points are expressed declaratively, via meta-annotations.

* `@SubtypeOf{}` means that this is top (remind them of the relationship between subtyping and lattice subsumption that was covered earlier)

* Note the comment that says “not written by programmers”; why? What
  would `@UnknownInterned Object` mean that’s different than `Object`
  (nothing)? Explain that `@DefaultQualifierInHierarchy` meta-anno makes
  that so. What if top wasn’t the default (unsoundness). Would that
  ever make sense, and when (yes, depends on what you’re trying to
  prove - nullness is a good example to work through on the board -
  why does the CF default to `@NonNull`? Is that sound?)?

* Ask the class if there is an abstraction function here (yes -
  `DefaultQualifierInHierarchy`).

* Briefly mention the related annotations, and whether they should care:
  * `@Documented`: Javadoc hook, we don’t care
  * `@RetentionPolicy(RUNTIME)`: puts annotation in bytecode, we don’t care
  * `@Target(...)`: multiple kinds of annotations (expr. vs. decl), use these
    as is.
  * `@InvisibleQualifier`: CF error reporting magic, we don’t care.

Now open `Interned.java` in the same directory. Point out
similarities/differences from the previous one:

* Many of the same meta-annotations

* `@SubtypeOf` has the other anno as its argument. Emphasize that
  `@SubtypeOf` arguments are exactly the lattice lines you would draw on
  a whiteboard; CF handles transitivity for you.

* `@QualifierForLiterals` is a declarative abstraction function for
  literal primitives (`5`, `true`) and String (`“hello”`). The JDK
  automatically interns these, so our analysis needs to know that for
  precision or for soundness? (precision)

* `@DefaultFor` is similar, but applies to types rather than to
  literals. It’s saying that any e.g. boolean declaration (like
  `boolean b;`) is automatically interned, even if no literal was
  assigned to it. Why do we need both? (`Object b = true`, or booleans
  that we never see an assignment for, like method formals)

That’s the lattice points. Now we talk about **abstraction and transfer
functions**. (didn’t we just talk about the abstraction function? Most
of them, but not all can be declared (declaratively defined). The CF
lets you do some common things declaratively for convenience, but you
can also always do what you want by writing some code).

Open `InterningAnnotatedTypeFactory.java`. We won’t cover this whole
class (there’s a bunch of complexity in dealing with the JDK,
esp. Interning methods, that I want to ignore), so here are the
highlights to show them:

* `addComputedTypeAnnotations`: procedural way to do the abstraction function.

* `visitBinary`: this is (part of) the transfer function. Note the
  rules for concatenation (compile-time constants interned, others no)
  and for primitive and boolean comparisons (interned).

* `getUnboxedType`: result of unboxing Integer always
  interned. Transfer or abstraction (transfer)?

At this point, say that you’ve covered all the relevant
abstraction/transfer rules. Note that a lot of them involved weird
javac corner cases; for most problems we care about, this ends up
being true. You can also mention that the **HW uses a better separation
of concerns**, so the ATF will only handle the abstraction function, and
a transfer class will handle the transfer function. This example is
historical, because it does both in one class. Interning is technical
debt.

Ask them what’s still missing (rules for `==`). Next, show
`InterningVisitor.java`. This class handles error reporting. A lot of it
is plumbing (theirs will be too!), so only show them the `visitBinary`
method. You’ll want to focus on the beginning and end of the method,
and skip most of the middle:

* Note that the top stops the method if we’re not visiting `!=` or `==`.

* Bottom includes the “hasEffectiveAnnotation(INTERNED)” lines for
  right and left. Point out those, and that they lead to error
  reporting. You can mention compiler message keys here, and point out
  the HW handles that for you - you’ll just have to take a binary op
  and return a boolean: issue an error or no - and the rest will be
  taken care of.

Before concluding, be sure to emphasize is that, given the technical
debt, students should not copy from the Interning Checker, but should
work from scratch following the instructions in the assignment and/or
Checker Framework manual.
