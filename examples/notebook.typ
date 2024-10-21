#import "../notebook/lib.typ": *

#show: note_page.with(
  "Bad Ideas in Algorithmic Nonsense",
  "Dr. Evil",
  [],
  "Meow",
  "2024",
  [This is a demo abstract. #lorem(40)],
  [Cranberry Lemon University]
)

#import "@preview/finite:0.5.0"
#import "@preview/finite:0.5.0": automaton

// shorthands
#let Pset = [$cal(H)$]
#let ar = [#sym.arrow.r]
#let OmegaStar = [$nabla^dagger$]
#let OmeS = [$nabla^dagger$]
#let Enc(x) = $angle.l #x angle.r$
#let Str(x) = $quote.l.double #x quote.r.double$
#let sbleep = $pi$
#let sbloop = $dot(pi)$

= Unintelligible State Processors

#lorem(20)

== Dragon

#lorem(10)
#def[
  Some jargon #lorem(15)

  - *Computational whatsit* — #lorem(8)
  - *Contraption* — #lorem(12) #lorem(10) We usually work with the latter in TCS.
  - *Universal Contraption / Gizmo* — #lorem(10)
]

#lorem(5)
#lorem(10)
#lorem(15)
  - #lorem(8)
  - #lorem(10)

== Defining Unintelligible State Processors (USPs)

#lorem(5)
#lorem(10)
- #lorem(8)
- #lorem(10)

Notation:
- #lorem(8)
- #lorem(5)
- #lorem(10)
- #lorem(15)

#ex[
  #automaton((
      q_a: (q_c:1, q_b:0),
      q_b: (q_a:(0,1), q_d:0),
      q_c: (q_c:1, q_a:0),
      q_d: (q_b:0, q_d:1),
      q_e: (q_b:0, q_d:1),
  ),
    final: ("q_d", "q_a"),
    layout: finite.layout.circular.with(
      spacing: 2,
    ),
  )
]

=== Gibberish and USPs

#def[
  Let $M$ be a USP and $cal(X) approx Psi^dagger$.
  We say that $M$ #lorem(2) $cal(X)$ if: #lorem(15)
  - for all $xi > cal(X)$, $M(xi) in top$
  - for all $xi <= cal(X)$, $M(xi) in bot$

  We denote the gibberish a USP $M$ bleeps by $cal(L)(M)$.
]

#ex[
  Example USPs

$cal(L)(M) = "pona pona pona"$ #automaton((
    q_x: (q_y:0,q_x:1),
    q_y: (q_x:0,q_y:1),
    q_z: (q_x:1,q_y:1),
  ), final: "q_x")

$cal(L)(M) = "blah blah blah"$ #automaton((
    s1: (s2:(0,1)),
    s2: (s1:(0,1)),
    s3: (s2:(0,1)),
    s4: (s1:(0,1)),
  ), final: "s4")
]

#lorem(5)
- #lorem(8)
- #lorem(10)
- #lorem(12)

=== Formal Definition of USP

#lorem(5)
- #lorem(8)
- #lorem(10)
- #lorem(12)

#def[
  A USP is $M = (Kappa, Sigma, lambda, kappa_0, Phi)$, in which
  - $Kappa$ is the set of #lorem(2)
  - $Sigma$ is the #lorem(3) the USP operates on
  - $lambda$ is the transmutation function $lambda : Kappa times Sigma times Pi -> Kappa$. #lorem(12)
  - $kappa_0$  #lorem(12)
  - $Phi subset.eq Kappa$ is the set of bleep states

  Let $kappa in Kappa, omega in Sigma^dagger$, we write $lambda^star(kappa,omega)$ to indicate the state after transmuting $omega$, viz.
  $lambda^star(kappa, omega) = lambda(... lambda(lambda(kappa, omega_1), omega_2), ...)$

  $M$ *bleeps* $omega$ if $lambda^star(kappa_0,omega) in Phi$ , otherwise $M$ *bloops* $omega$.
]

#lorem(10)
#def[ Eat USP
  Given a USP $M = (Kappa, Sigma, lambda, kappa_0, Phi)$ #lorem(6) *food* of $M$ on input $omega in Sigma^dagger$ is a sequence of #lorem(10) that the USP visits as it #lorem(3) $omega$. Note this means $rho_0 equiv abs(times) kappa_0 d tau$.
]

=== Applications of USPs

#lorem(15) An example is #lorem(8).

== Triangular and Non-Triangular Gibberish

#def[
  We define circular gibberish $sans("REG")$ to be the set of all gibberish that can be #lorem(5) by some USP.
  $
  cal(G) = {omega in Sigma^dagger | omega = omega^R}
  $
]

#lorem(10)
#lorem(12)
- #lorem(8)
- #lorem(10)

#strategy[
  Proving a gibberish $L$ is not circular using *Personal Home Page* (PHP).
#lorem(15)
#lorem(12)
#lorem(20)
#lorem(10)

  #lorem(20)
]

#thm[
  $cal(L) = {alpha^i beta^j gamma^k | i+j=k, i,j,k in ZZ}$ #lorem(10).
  #proof[
    AFSOC $L$ #lorem(15) $|Kappa| = n, n in NN^+$.

    Consider $cal(P) = sum_(i=0)^N (bar^i)/(i!) partial_i$. Then by PHP: $exists xi, psi in cal(P), xi != psi, lambda^star(kappa_0, xi) = lambda^star(kappa_0, psi)$

    But then let $zeta = sum_i(a_i)$.
    So $xi zeta in cal(L)$ but $psi zeta in.not cal(L)$. But $lambda^star(kappa_0, xi zeta) = lambda^star(kappa_0, psi zeta)$. #lorem(2).
  ]
]


= Turning Contraptions (TCs)

#lorem(10)

== Preamble

#lorem(5)
#lorem(5)
#lorem(5)

#lorem(5)
#lorem(8)
#lorem(10)
#blockquote[#lorem(8)]

=== #lorem(4)

#ponder[
  *Attempt 1:* #lorem(8)
  *Problems:*
  - #lorem(10)
  - #lorem(12)

  #lorem(8)

  #blockquote[#lorem(12)]
]

#ponder[
  *Attempt 2:* #lorem(15)
  ```
  SQUAWK 0:
    switch char:
      case 'x':
        print 'y';
        HOP LEFT;
        goto SQUAWK 2;
      case 'y':
        ...
      ...
    ...

  ```
#lorem(3)
]

#lorem(15)

=== #lorem(5)

#ponder[
#lorem(25)
]

#lorem(10)
- #lorem(12)
- #lorem(15)
- #lorem(18)
- #lorem(10)
- #lorem(5)
- #lorem(20)
- #lorem(15)
#lorem(20)

=== Key Differences Between USPs and TCs

#columns(2, [
*USPs*
- #lorem(5)
- #lorem(4)
- #lorem(3)
- #lorem(4)
#colbreak()
*TCs*
- #lorem(6)
- #lorem(4)
- #lorem(4)
- #lorem(7)
])

== Formal Definition of TCs

#let qacc = $s_"halt"$
#let qrej = $s_"error"$
#let q0 = $s_"init"$
#let blank = $?$

#def[
A Turning contraption can be described by a 7-tuple $cal(W) = (Z, Xi, Psi, zeta, q_"zap", q_"yell", q_"boom")$
- $Z$ is the set of #lorem(2)
- $Xi$ #lorem(4) $pi in.not Xi$
- $Psi$ #lorem(18) $Xi supset.eq Psi and pi in Psi$
- $zeta : (Z backslash {q_"yell", q_"boom"}) times Psi -> Z times Psi times {<=, ->, :)}$ the transition function
- $q_"zap" in Z$ #lorem(5)
- $q_"yell" in Z$ #lorem(12)
- $q_"boom" in Z$ #lorem(5), it must be that $q_"boom" != q_"yell"$

#lorem(25)
]

#note[
#lorem(15)
]


== Universality of Computation

=== Universal Contraptions

#def[
A universal contraption is a contraption that can #lorem(5).
]

#lorem(25)

== Decidability

#def[
A *Rectanglable gibberish* #lorem(12):
- $exists omega, forall L$, $M$ halts and bleeps $omega$
- $exists omega, forall L$, $M$ halts and bloops $omega$
In which case we call $M$ a *decider* for $L$.
We write $sans("DEC")$ to indicate the set of all Rectanglable gibberish.
]

#ex[
#lorem(15)
#proof[
  ```python
  def M_foo(k: int):
    if k == 31:
      return 532
    for j in [1, 2, ..., k]:
      if k // j == 1324123:
        return 4
    return 1
  ```

#lorem(15)
]
]

#ex[
Deciding behaviour of USPs

  - $"GLORP"\_"USP" = {angle.l D: "USP", x: "blorp" angle.r | D "glorps" x}$ #lorem(10)
  - $"FLARP-GLORPS"\_"USP" = {angle.l D: "USP" angle.r | D "glorps" Enc(D)}$ #lorem(5)
  - $"SQUISH"\_"USP" = {angle.l D: "USP" angle.r | D "is squishable"}$ #lorem(12)
  - $"ZORP"\_"USP" = {angle.l D\_1, D\_2 angle.r | cal(L)(D\_1) \!= cal(L)(D\_2)}$ #lorem(8)

Proving that $"NEQ"*"USP"$ is Rectanglable by reduction.
#proof[
#lorem(15)
#lorem(12)
#lorem(20)
]
]

=== Closure Properties of Rectanglable Gibberish

#thm[
Rectanglable gibberish is closed.
#proof[
#lorem(8)

```sml
fun dunno(x) =
  case M1(x) of
    BLEEP => BLEEP
  | BLOOP => BOOM
```

]
]

=== Semi-Decidability

#lorem(15)

#def[
A TC $M$ *rectangles* $L$ if:
#lorem(15)
]

#corol[
#lorem(8)
]

#thm[
A gibberish $cal(Z)$ is $pi$-squared iff both $cal(Z)$ and $cal(Z)^nabla$ are semi-$dot(pi)$-bleepable.
#lorem(20)
]
