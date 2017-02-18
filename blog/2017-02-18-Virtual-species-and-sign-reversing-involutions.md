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

A function $f:S\to S$ is an *involution* if it is its own inverse, or,
in symbols, $f(f(x))=x$. Assume that a function $\epsilon:S\to\{-1,1\}$
is given. We then refer to $\epsilon(x)$ as the *sign* of $x$. Now, $f$
is a *sign-reversing involution* if for each non fixed point $x$ in $S$
the sign of $x$ is reversed by $f$; that is,
$\epsilon(f(x))=-\epsilon(x)$.

Note that the number of fixed points in $S$ is
$\sum_{x\in S}\epsilon(x)$.


</div>
