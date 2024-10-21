#import "../notebook/lib.typ": *

#show: note_page.with(
  "Bad Ideas in Practical Computer Science", 
  "Dr. Evil", 
  [], 
  "Meow", 
  "2024", 
  [This is an example abstract. #lorem(40)], 
  [Cranberry Lemon University]
)

#import "@preview/finite:0.3.0"
#import "@preview/finite:0.3.0": automaton

// shorthands
#let Pset = [$cal(P)$]
#let ar = [#sym.arrow]
#let SigmaStar = [$Sigma^*$]
#let SigS = [$Sigma^*$]
#let Enc(x) = $angle.l #x angle.r$
#let Str(x) = $quote.l.double #x quote.r.double$

= Deterministic Finite Automata

We want a good model of computation, but let's first see how far one can go with a simple and restricted model of computation.

== Terminology

To be able to define computation, we first build models for computation.

#def[
  Some terminology
  
  - *Computational model* — set of rules allowed for information processing
  - *Machine* — an instance of a computational model. This could be a physical realisation or mathematical representation. We usually work with the latter in TCS.
  - *Universal Machine / Programme* — a programme that can run many other programmes, such as a laptop.

  For now, $"Machine" = "Computer" = "Programme" = "Algorithm"$
]

For this chapter, we also assume:
1. There's no universal machine, viz. each machine does one thing
2. We only consider decision problems
  - the machine either accepts or rejects the input string
  - focus only on functional problems with some corresponding decision problem

== Defining Deterministic Finite Automata (DFA)

This is a _restricted_ model of computation. Often in the real world we do have restrictions. At the same time, designing a model that is as simple as possible can bring interesting properties.

Restrictions of DFA:
- Only one pass over the input string
- Very limited memory

Notation:
- Each node represents a state, usually indicated by $q_i$ for some $i$
- Double circles represent accept state, otherwise it's a reject state
- Initial state $q_0$ has arrow coming from nowhere
- Transition rules are arrow with alphabet corresponding to the transition
- To declutter, it's acceptable to say that missing arrow all goes to reject, etc.

#ex[
  
  #automaton((
      q0: (q0:0,q1:1),
      q1: (q2:(0,1)),
      q2: (q2:1,q3:0),
      q3: (q0:0,q2:1),
    ), 
    final: ("q2", "q1"),
    layout: finite.layout.circular.with(
      spacing: 2,
    ),
  )
    
]

=== Language and DFA

#def[
  Let $M$ be a DFA and $L subset.eq SigmaStar$. We say that $M$ solves $L$ if:
  - for all $w in L, M "accepts" w$
  - for all $w in.not L, M "rejects" w$

  We denote the language for which all strings a DFA $M$ accepts by $L(M)$
]

#ex[
  Example languages and DFAs

  1. $L(M) = "strings with even number of 1's"$ #automaton((
    qeven: (qeven:0,qodd:1),
    qodd: (qodd:0,qeven:1),
  ), final: "qeven")
  

  2. $L(M) = "strings with even number of characters"$ #automaton((
    qeven: (qodd:(0,1)),
    qodd: (qeven:(0,1)),
  ), final: "qeven")
  
  3. $L(M) = "strings that end in 0's and the empty string"$ #automaton((
    qeven: (qeven:0,qodd:1),
    qodd: (qodd:1,qeven:0),
  ), final: "qeven")

  4. $L(M) = "strings that end with 00"$ #automaton((
    q0: (q1:0,q0:1),
    q1: (q2:0,q0:1),
    q2: (q2:0,q0:1),
  ), final: "q2")
]

Notice we can do various things like:
- Maybe build a DFA for some language
- Translate DFA into some programme in code
- Get the complement of the language by flipping accept and reject states

=== Formal Definition of DFA

We want a few properties:
- Every state need to have $|Sigma|$ transitions out of it
- There is no direction for states (so you can go back to a previously visited state)
- DFA needs to tell you the output for every input

#def[
  A DFA is $M = (Q, Sigma, delta, q_0, F)$, in which
  - $Q$ is the set of states
  - $Sigma$ is the alphabet the DFA operates on
  - $delta$ is the transition function $delta : Q times Sigma -> Q$. It takes the current state, the characters being read, and outputs the next state.
  - $q_0$ is the start state
  - $F subset.eq Q$ is the set of accept states

  Let $q in Q, w in SigmaStar$, we write $delta^* (q,w)$ to indicate the state after running on $w$, viz. 
    $ delta^* (q,w) = delta(... delta(delta(q, w_1), w_2), ...) $ 

  $M$ *accepts* $w$ if $delta^* (q_0,w) in F$ , otherwise $M$ *rejects* $w$.  
]

A good way to capture the input and output of $delta$ is perhaps a table.

#def[ Computationpath for DFA
  Given a DFA $M = (Q, Sigma, delta, q_0, F)$ as previously defined, the *computational path* of $M$ on input $w in SigmaStar$ is a sequence of states $r_0, r_1, ..., r_n$ ($r_i in Q$) that the DFA visits as it reads $w$. Note this means $r_0 = q_0$.

]

=== Applications of DFAs

DFA is always linear time, so if we can efficiently build a DFA that solves some decision problem, we get $O(n)$ for free. An example is deciding whether $w$ contains some substring $s$.

== Regular and Non-Regular Languages

#def[
  We define regular languages $sans("REG")$ to be the set of all languages that can be solved by some DFA.

  $
  "regular languages" sans("REG") subset.eq "all languages" sans("ALL")
  $
]

But is it true in the other direction? Probably not. DFAs have limited memory and only scans in one direction (viz. forgets what it reads), but some language may require more memory to solve. We want to find the simplest counterexample to show that there exists non-regular language. One idea is to make use of the fact that DFAs are bad at counting—because $|Q|$ is finite, they can only keep track of $|Q|$ distinct situations.

Key limitations of DFAs:
- Finite number of states #ar limited memory
- Only reads input in one direction #ar can't go back to check something if not in memory

#strategy[
  Proving a language $L$ is not regular using the *Pigeonhole Principle* (PHP).

  1. Assume that the language is regular and there is a DFA with $k in NN^+$ states that solves $L$.
  2. Come up with a *fooling pigeon set* $P$ such that $|P| > k$
  3. By *PHP*, $exists x, y in P$ with $x != y$ must end up at the same state in the DFA, so $x z$ and $y z$ for some $z in SigmaStar$ end up in the same state
  4. Pick $z$ such that $x z in F$ xor $y z in F$. Contradiction.

  Note this strategy also works if one wants to prove a lower bound on the number of states a DFA needs to solve a certain language—assume a DFA with fewer states solves it, and derive a contradiction.
]

#thm[
  $L = {0^n 1^n | n in NN}$ is not regular.

  #proof[

    AFSOC $L$ is regular and there exists DFA $M = (Q, Sigma, delta, q_0, F)$ that solves $L$ with $|Q| = k, k in NN^+$.

    Consider $P = {0^i | 0 <= i < k+1}$. Then by PHP: $ exists x = 0^n, y = 0^m in P, x != y, delta^*(q_0, x) = delta^*(q_0, y) $

    But then let $z = 1^n$. So $x z in L$ but $y z in.not L$. But $delta^*(q_0, x z) = delta^*(q_0, y z)$. Contradiction.

  ]
]


=== Closure Properties of Regular Languages 

Regular languages are closed under:

- Complement
- Union
- Intersection
- Concatenation
- Star operation

For the proofs below, let $M^1 = (Q^1, Sigma, delta^1, q_0^1, F^1)$ solve $L_1$ and $M^2 = (Q^2, Sigma, delta^2, q_0^2, F^2)$ solve $L_2$.

#thm[
  Regular languages are closed under complement

  $
  L_1 subset.eq SigmaStar "is regular" => overline(L_1) = SigmaStar without L_1 "is regular"
  $

  #proof[
    
    $M' = (Q^1, Sigma, delta^1, q_0^1, Q^1 without F^1)$ solves $overline(L_1)$.
  ]
]

#thm[
  Regular languages are closed under union

  $
  L_1, L_2 subset.eq SigmaStar "are regular" => L_1 union L_2 "is regular"
  $

  Proof idea: construct new DFA with state $Q' = Q^1 times Q^2$, initial state $q_0' = (q_0^1, q_0^2)$ step both DFAs and accept if one of the final states is accept for one of the DFAs viz. $F' = {(q_1, q_2) | q_1 in F^1 or q_2 in F^2}$.
]

#thm[
  Regular languages are closed under intersection

  $
  L_1, L_2 subset.eq SigmaStar "are regular" => L_1 sect L_2 "is regular"
  $

  Proof idea 1: Write $L_1 sect L_2$ as $overline(overline(L_1) union overline(L_2))$

  Proof idea 2: very similar to union, but with $F' = {(q_1, q_2) | q_1 in F^1 and q_2 in F^2}$.

]

#thm[
  Regular languages are closed under concatination

  $
  L_1, L_2 subset.eq SigmaStar "are regular" => L_1 L_2 "is regular"
  $

  #proof[

    Define $M'$ by:
    $
    Q' &= Q^1 times Pset(Q^2) \
    Sigma' &= Sigma \
    q_0 ' &= cases(
      (q_0^1, emptyset) "if" q_0^1 in.not F^1,
      (q_0^1, {q_0^2}) "if" q_0^1 in F^1
    ) \
    delta'(a, B) &= cases(
      (delta^1(a, sigma), {delta^2(b, sigma) | b in B}) "if" delta^1(a, sigma) in.not F^1,
      (delta^1(a, sigma), {delta^2(b, sigma) | b in B} union {q_0^2}) "if" delta^1(a, sigma) in F^1,
    ) \
    F' &= {(a, B) in Q' | exists b in B, b in F^2}
    $
  ]
]

#def[
  Notice it's useful to have a set of states and step the entire set, so we define a *generalised transition function* $delta_cal(P) : Pset(Q) times Sigma -> Pset(Q)$ by:

  $
    delta_cal(P) (S, sigma) = {delta(q, sigma) | q in S}
  $
]

#thm[
  Regular languages are closed under star operation

  $
  L_1 subset.eq SigmaStar "are regular" => L_1^* "is regular"
  $

  #proof[
    
    We can solve $L_1^+$ by constructing $M'$:

    $
    Q' &= Pset(Q^1) \
    Sigma' &= Sigma \
    q_0 ' &= {q_0^1} \
    delta'(S) &= cases(
      delta_cal(P)^1(S, sigma) union {q_0^1} "if" delta_cal(P)^1(q, sigma) sect F^1 != emptyset,
      delta_cal(P)^1(S, sigma) "else" 
    ) \
    F' &= {S subset.eq Q^1 | S sect F^1 != emptyset}
    $


    Then we can use closure under union to construction $M''$ for $L_1^+ union {epsilon}$
  ]
]

=== Recursive Definition of Regular Language

It turns out the definition simple language is equivalent to that of regular language. Namely:

#thm[
  A regular language can be recursively defined as:
  - $emptyset$ is regular
  - ${sigma}$ is regular for all $sigma in Sigma$
  - If $L_1, L_2$ are regular, then $L_1 union L_2$ is regular
  - If $L_1, L_2$ are regular, then $L_1 L_2$ is regular
  - If $L_1$ is regular, then $L_1^*$ is regular

  Proof omitted.
]


= Turing Machines (TMs)

DFA with tape — the model for computation!

== Preamble

Recall what we want from a model of computation:
1. As simple as possible
2. As general as possible

Observations:
1. Computational devices need to be a finite object. Finite algorithms need to solve arbitrary-length input.
2. It has unlimited memory. That is, it can access more working memory if needed.

#blockquote[An algorithm is a finite answer to infinite number of questions]

=== Coming Up with TMs (Modern Perspective)

#ponder[
  *Attempt 1:* Define computable by what Python can compute!
  
  *Problems:*
  - But what is Python? 100 pages of definition?
  - Why Python? What's special about Python among the other programming languages

  This is general enough, but not simple

  #blockquote[We want a #underline([totally minimal]) (TM) programming language]
]

#ponder[
  *Attempt 2:* Upgrade DFA + Tape — enable write to tape and allow moving around tape.

  ```
  STATE 0:
    switch sigma:
      case 'a':
        write 'b';
        move LEFT;
        goto STATE 2;
      case 'b':
        ...
      ...
  ...
  ```

  That seems to work!
]

To represent a TM, we can draw state diagrams similar to those for DFAs. Just put the character to write and the direction to move on the transition.

=== Coming Up with TMs (Turing's Perspective)

#ponder[
  Recall that in Hilbert's time, mathematicians were trying to formalise what it means to have a finite procedure, such as in the Entscheidungsproblem. Computers back then were humans, and so a finite procedure would be instructions given to humans so that they could write proofs mechanically.

  But then we needed to define what the instruction looks like and what instructions a human can follow and execute.
]

A TM, then, must capture human computers' workflow. Observe that *a human computer reads and writes symbols on paper*.

- Human has finite mental states, thus finite number of states in a TM.
- Human computers are deterministic, so kind of like DFAs with deterministic state changes.
- Human knows finite number of symbols, and they can have a set of working symbols that is a superset of the input symbols.
- Human can work with papers with square cells and put one symbol in one cell.
- Human can always grab more papers.
- Human can work by reading/writing at one location at a time. (WLOG, if someone really needs to read/write more cells at a time, we can just have larger cells with a larger set of composite symbols)
- There is nothing special about 2D papers, so moving Left/Right is sufficient for computation.

So then if we define a TM to model a computer with finite number of states, finite number of symbols, and an infinite tape, they can perform equivalent computation as a human computer. Simple and general!

=== Key Differences Between DFAs and TMs

#columns(2, [
  *DFAs*
  - Multiple accept/reject states
  - Halt at string end
  - Always terminates
  - Finite cell access
  #colbreak()
  *TMs*
  - One accept state, one reject state
  - Halt on accept/reject
  - May loop forever
  - Can read/write infinite number of cells
])

== Formal Definition of TMs

#let qacc = $q_"acc"$
#let qrej = $q_"rej"$
#let q0 = $q_0$
#let blank = $⊔$

#def[
  A turing machine can be described by a mighty 7-tuple $M = (Q, Sigma, Gamma, delta, q0, qacc, qrej)$

  - $Q$ is the set of states
  - $Sigma$ is the set of input characters, such that $blank in.not Sigma$
  - $Gamma$ is the set of tape characters, satisfying $Sigma subset Gamma and blank in Gamma$
  - $delta : (Q without {qacc, qrej}) times Gamma -> Q times Gamma times {L, R}$ the transition function
  - $q0 in Q$ is the initial state
  - $qacc in Q$ is the accept state
  - $qrej in Q$ is the reject state, it must be that $qrej != qacc$

  The TM then operates on an infinite tape, with infinite blank symbols surrounding the input string and the tape head initially at the start of the input string.

  $M$ can then be thought of as a function $SigmaStar -> {0, 1, infinity}$, with $0$ being reject, $1$ being accept, and $infinity$ being loop forever.
]

#note[
  One can also set up a TM with a tape that's infinite only in one direction, but this does not make the TM any less powerful.
]

#def[
  Configuration of a TM

  A *configuration* of a TM consists of:
  1. The content on the tape
  2. Its state
  2. The location of the tape head

  We can specify the configuration formally by writing down $u q v in (Gamma union Q)^*$ where $u, v in Gamma^*$ and $q in Q$. The convention is that the tape head is at the first character of $v$, and the state is $q$. We say that a configuration is *accepting* if $q = qacc$ and rejecting if $q = qrej$.
]

#def[
  Language of a TM

  $
  L(M) = {w in SigmaStar | M "accepts" w}
  $

  Note that $M$ may loop forever for some input, but $L(M)$ only contains those that $M$ accepts.
]

== Universality of Computation

The idea is that a TM can perform any computation we want just with a finite set of instructions and an infinite scratchpad.

=== TM Subroutines, Tricks, and Description

- Move Left/Right until hitting $blank$
- Shift entire input by one cell to Left/Right
- Convert $blank x_1 x_2 x_3 blank$ to $blank x_1 blank x_2 blank x_3 blank$ 
- Simulate $Gamma$ with ${0, 1, blank}$ viz. alphabet reduction
- Mark cells with $Gamma' = {0, 1, 0^circle.filled.tiny, 1^circle.filled.tiny, blank}$
- Copy paste tape segment
- Simulate 2 TMs on the same tape
- Implement some data structure
- Simulate RAM by reading address and moving
- ...
- Simulate assembly

So *a Turing Machine can simulate all our programmes written in other programming languages*. Therefore, to describe a TM, it is sometimes sufficient to describe it at a higher level, knowing that it can compile down to a 7-tuple describing an actual TM. 

Levels of description:

- *Low* - state diagram, 7-tuple
- *Mid* - movement, behaviour
- *High* - pseudocode

=== Universal Machines

#def[
  A universal machine is a machine that can simulate any machine.
]

It follows that Turing's TM can simulate any TM, just like how human takes instructions and input, a TM can take the blueprint of another TM, some input, and simulate the input string on the input TM.

An important realisaion is that *code is data*, so any algorithm/programme can be encoded and fed into some other machine. The good thing is that we get universal machines, the maybe not so good thing is that we now have to deal with self reference.

== The Church-Turing Thesis

Is computation equivalent to any physical process?

#def[
  The $"Church-Turing Thesis"$ states that any computation allowed by the laws of physics can be done by a TM.
]

#def[
  The $"Church-Turing Thesis"^+$ states that any computational problem solvable by physical process is solvable by a probabilistic TM.
]

#def[
  The $"Church-Turing Thesis"^(++)$ states that any computational problem efficiently solvable by physical process can be efficiently solved by a Quantum TM.
]

Note that the Church-Turing Thesis is not a theorem, but something we believe to be true. At least we don't know of any counterexample yet.

== Decidability

#def[
  A *decidable language* is a language a TM can solve. Let $L subset.eq SigmaStar$, $L$ is dicidable if there exists $M$ a TM such that:
  - $forall w in L$, $M$ halts and accepts $w$
  - $forall w in.not L$, $M$ halts and rejects $w$
  In which case we call $M$ a *decider* for $L$.

  We write $sans("R")$ to indicate the set of all decidable languages.
]

#def[
  A *decider* TM is a TM that never loops.
]

#ex[
  Deciding $"isPrime" = {Enc(n) | n "is a prime"}$

  One can simply write some code to do it:
  #proof[
    ```py
    def M(n: int):
      if n < 2:
        return 0
      for i in [2, 3, ..., n - 1]:
        if n % i == 0:
          return 0
      return 1
    ```
    Since we can write code to solve it, we can compile it to a TM that solves it, so it is decidable.

  ]
]

#ex[
  Deciding behaviour of DFAs

  - $"ACCEPTS"_"DFA" = {angle.l D: "DFA", x: "str" angle.r | D "accepts" x}$ is decidable because we can just simulate the DFA and decide
  - $"SELF-ACCEPTS"_"DFA" = {angle.l D: "DFA" angle.r | D "accepts" Enc(D)}$ decidable, same as above
  - $"SAT"_"DFA" = {angle.l D: "DFA" angle.r | D "is satisfiable"}$ decidable, we can do a graph search to see if any of the accept states are reachable
  - $"NEQ"_"DFA" = {angle.l D_1: "DFA", D_2: "DFA" angle.r | L(D_1) != L(D_2)}$ decidable... but a bit more tricky.

  Proving that $"NEQ"_"DFA"$ is decidable by reduction. 

  #proof[
    First, we observe that this is equivalent to deciding if $(L(D_1) union L(D_2)) without (L(D_1) sect L(D_2))$ is empty.

    But we can rewrite that as $(L(D_1) sect overline(L(D_2))) union (overline(L(D_1)) sect L(D_2))$. By closure properties of regular languages, we can build a DFA to solve that using $D_1$ and $D_2$, and we can use a decider for $"SAT"_"DFA"$ to figure out if that region is empty. 

    We just reduced $"NEQ"_"DFA"$ to $"SAT"_"DFA"$. We write $"NEQ"_"DFA" <= "SAT"_"DFA"$.


  ]

]

=== Closure Properties of Decidable Languages

#thm[
  Decidable language is closed under complement.

  #proof[

    Let $L$ be a decidable language. Let $M$ de a decider for $L$. We can build a decider for $overline(L)$ by:

    ```sml
    fn x => (case M x of 1 => 0 | 0 => 1)
    ```
  ]
]

#thm[
  Decidable language is closed under union.

  #proof[
    Let $L_1, L_2$ be decidable languages. Let `M1`, `M2` be their deciders. We can build a decider for $L_1 union L_2$ by:

    ```sml
    fn x => (case M1 x of 1 => 1 | 0 => M2 x)
    ```

  ]
]

#thm[
  Decidable language is closed under intersection.

  #proof[
    Let $L_1, L_2$ be decidable languages. Let `M1`, `M2` be their deciders. We can build a decider for $L_1 union L_2$ by:

    ```sml
    fn x => (case (M1 x, M2 x) of (1, 1) => 1 | _ => 0)
    ```

  ]

]

=== Semi-Decidability

Decidability requires that the decider always outputs $0$ or $1$, but we may relax the requirement and find that some languages are only semi-decidable.

#def[
  A TM $M$ *semi-decides* $L$ if:
  $
  forall w in SigmaStar, w in L <==> M(w) = 1
  $

  viz. 
  - $w in L => M(w) = 1$
  - $w in.not L => M(w) in {0, infinity}$

  Which means our TM always says yes if the input is in the language, but may say no xor loop forever if it's not.

  A language is *semi-decidable* if there exists a semi-decider for it.

  We write $sans("RE")$ for the set of all semidecidable languages.
]

#corol[
  All decidable languages are semi-decidable.
]

#corol[
  So $sans("REG") subset.eq sans("R") subset.eq sans("RE") subset.eq sans("ALL")$.
]

#thm[
  A language $L$ is decidable iff both $L$ and $overline(L)$ are semi-decidable.

  Proof idea: for the forward direction, use complement closure property. For the other direction, construct a decider using the two semi-deciders (hint: step each TM in incremental number of steps until one of them halts).
]