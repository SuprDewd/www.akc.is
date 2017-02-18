---
title: akc.is/blog
id: blog
---

# Virtual species and sign-reversing involutions

<div class="blog">

Given a finite set $U$ with $n$ element. Assuming $n$ is positive, how
would you prove that there are as many subsets of $S$ with even
cardinality as there are with odd cardinality? One way is to use the
binomial theorem:
$$
0^n = (1-1)^n = \sum_{k=0}^n{n \choose k}(-1)^k
    = \sum_{\text{$k$ even}}{n \choose k} - \sum_{\text{$k$ odd}}{n \choose k}.
$$
That's neat, but not very combinatorial. For a more combinatorial proof
we can use a so called sign-reversing involution.

A function $f:X\to X$ is an *involution* if it is its own inverse, or,
in symbols, $f(f(x))=x$. Assume that a function $\epsilon:X\to\{-1,1\}$
is given. We refer to $\epsilon(x)$ as the *sign* of $x$. Now, $f$
is a *sign-reversing involution* if for each non fixed point $x$ in $X$
the sign of $x$ is reversed by $f$; that is,
$\epsilon(f(x))=-\epsilon(x)$. If $f$ is a sign-reversing involution of
$X$, then
$$\newcommand{Fix}{\mathrm{Fix}}
\sum_{x\in X}\epsilon(x) = \!\!\sum_{x\in \Fix(f)}\!\!\!\epsilon(x),
$$
where $\Fix(f)=\{x\in X: f(x)=x\}$ denotes the set of fixed points of
$f$.  This is because, under $f$, each negative non fixed point is
paired with a unique positive non fixed point, and vice versa. For
counting purposes we usually also require  that all fixed
points of $f$ have the same sign, and thus the right hand sum is
$\pm|\Fix(f)|$.

In the example of counting subsets of a nonempty set $U$ with respect to
parity, a natural sign function is defined by $\epsilon(S) =
(-1)^{|S|}$, for $S\subseteq U$. Assuming $U$ is equipped with a total
order and that $\hat 0$ denotes the smallest element of $U$, a sign
reversing involution is given by
$$
f(S) =
\begin{cases}
  S \setminus \{\hat 0\} & \text{if $\hat 0\in S$}, \\
  S \cup \{\hat 0\}      & \text{if $\hat 0\notin S $}.
\end{cases}
$$
For instance, if $U=\{1,2\}$ then $f(\emptyset)=\{1\}$,
$f(\{1\})=\emptyset$, $f(\{2\})=\{1,2\}$, and $f(\{1,2\})=\{2\}$. Note
that $f$ is fixed point free; thus $\Fix(f)=\emptyset$ and
$$
\#\{S : S\subseteq U, \text{$|S|$ even}\} -
\#\{S : S\subseteq U, \text{$|S|$ odd}\} = |\Fix(f)| = 0.
$$
Now, that's a simple and beautiful proof, but is this a proof from The
Book, as Paul Erdős might have asked? Is there a more general and
"natural" combinatorial proof? E.g. do we have to assume a total order
on $U$ and do we have to mention special elements, such as $\hat 0$?
Before proceeding to the next paragraph you might want to take a moment
and try to come up with such a proof.

Let $E$ be the [combinatorial
species](https://en.wikipedia.org/wiki/Combinatorial_species) of sets,
defined by $E[U]=\{U\}$. Its exponential generating function is
$E(x)=e^x$. The multiplicative inverse of $E$ is a [virtual
species](https://byorgey.wordpress.com/2017/02/10/virtual-species-suffice/)
$E^{-1}$ such that $E\cdot E^{-1}=1$, where $1[U]=\{U\}$ if $U=\emptyset$ and
$1[U]=\emptyset$ otherwise. Here we find that
$$
E^{-1} = (1+E_+)^{-1} = \sum_{k\geq 0} (-1)^k(E_+)^k,
$$
where $E_+$ denotes the species of nonempty sets. Thus, $E^{-1}$ is the
species of signed ballots (also called ordered set partitions) where the
sign $\epsilon(B_1\dots B_k)$ of a ballot $B_1\dots B_k$ is $(-1)^k$;
that is, the parity of the number of blocks. For instance,
$\{d\}\{a,c,e\}\{b\}$ is a ballot of $U=\{a,b,c,d,e\}$ and its sign is
$(-1)^3=-1$.

</div>
