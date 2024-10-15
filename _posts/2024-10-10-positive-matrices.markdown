---
layout: default
title:  "Positive Matrices as Generalizations of Positive Numbers"
date:   2024-10-10
categories: jekyll update
subtitle: "A conceptual intuition of positive matrices from which most core properties of definite matrices can be derived"
---
{% katexmm %}
This is the first part of what is hopefully a sequence of posts to help build intuition on linear algebra. I'm certainly not the first person to think of this - Gregory Gundersen has an extremely similar and arguably more intuitive post [here](https://gregorygundersen.com/blog/2022/02/27/positive-definite/), but I stumbled across the idea myself and was proud of it so I'm writing this here anyways.

Here's an interesting, perhaps obvious property of positive numbers: when you multiply a positive number $p$ by any non-zero number $a$, the result lies on the same side of the number line as the original number $a$ did. Let's take the positive number $2$ as an example:
$$
\begin{align*}
2 \cdot 3 = 6 &\qquad \text{6 is on the same side of the number line as 3}\\
2 \cdot (-5) = -10 &\qquad   \text{-10 is on the same side as -5}
\end{align*}
$$

In other words, positive numbers are sign-preserving when viewed as multiplicative operators. To formalize that last part, a positive number $p$ corresponds to a linear map $p: \R \to \R$ defined by $p(a) = p \cdot a$ (show for yourself this is linear!)

If you've taken a good linear algebra course, then you'll know that matrices correspond to linear maps. Then we can view positive definite matrices as generalizations of positive numbers to $\R^k$: **a positive definite matrix $P$ corresponds to a linear map that sends any non-zero vector $v$ to another vector $Pv$ that lies on the same half of the vector space as $v$ was.**

How do we define "same half of the vector space as $v$"? With respect to $v$ itself! If you consider the set of all possible vectors that are orthogonal to $v$, the entirety of this set takes the shape of a hyperplane which divides your vector space in half. Then the 'side' that $v$ is on is simply the set of vectors $w$ such that the inner product $v^\top w > 0$. From this and our conceptual generalization above, we can derive the first definition of positive definite matrices $P$:

### Definition 1: $v^\top P v > 0, \ \forall \ v \neq 0$
In other words, we view the quadratic product $v^\top Pv$ as the inner product between $v$ and $Pv$. Notice how in the positive number/1D case, the dot product reduces to multiplying scalars: for all $a \neq 0, \newline$ $a \cdot (p \cdot a) = a^2 p > 0$, which indeed holds for positive $p$.

Before we continue, we should note that this conceptual framework restricts positive matrices to being square matrices: in our 1D case, positive numbers mapped from $\R$ to $\R$, and in higher dimensions it doesn't really make sense to take inner products between vectors of different sizes. It should also follow (though not very obviously) that positive matrices must be symmetric. We know the quadratic product $v^\top P v$ is a scalar, so it is equal to its transpose $v^\top P^\top v$. Then we can set 



<!-- 
Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/ -->

{% endkatexmm %}