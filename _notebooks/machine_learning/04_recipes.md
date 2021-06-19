---
title: Recipes and Formulae
notebook: Machine Learning
layout: note
date: 2021-06-15
tags: 
...

## Gradient Descent

$$\theta \leftarrow \theta - \eta\nabla f(\theta)$$

- $\eta$: learning rate/step size
- $\nabla = [\frac{\partial}{\partial\theta_i}]$: gradient; vector of partial derivatives

## Distance

### Manhattan - L1

$$d(x,y) = \sum_i |x_i - y_i|$$

### Euclidean - L2

$$d(x,y) = \sum_i (x_i - y_i)^2$$

### Cosine

### Jaccard

### Hamming


## K-Nearest Neighbours

- compute distances between test point and training points
- sort distances
- choose top $k$ as neighbours
- compute weight for each neighbour
- aggregate neighbour weights for each class
- assign training instance to class with highest weight

### Uniform Weighting

- $w_i = 1$

### Inverse Distance Weighting

- introduce small parameter $\epsilon$

$$w_i = \frac{1}{d_i+\epsilon}$$

### Inverse Linear Distance Weighting

$$w_i = \frac{d_k-d_i}{d_k-d_1}$$

- $d_i$: distance of $j$th neighbour
- $d_k$: maximum distance amongst neighbours
- $d_1$: minimum distance amongst neighbours

## Naive Bayes

- assumption: conditional independence given class:

$$P(x_1,...,x_m|y) \approx \prod_iP(x_i|y)$$

### Epsilon Smoothing

- if we calculate $P(x_m|y) = 0$ then set $P(x_m|y)=\epsilon \ll \frac{1}{N}$
- reduces most comparison to cardinality of $\epsilon$: fewest wins

### Laplace Smoothing

- add pseudocount $\alpha$ (typically 1) to every feature count observed during training
- $M$: number of distinct values of attribute $x_m$

$$P(x_m = j | y = k) = \frac{\alpha + \text{count}(y=k,x_m=j)}{M\alpha + \text{count}(y=k)}$$

### Classifier

$$\hat y = \argmax_{y\in Y}P(y)P(x_1,...,x_m|y) = \argmax_{y \in Y} P(y)\prod_{i=1}^m P(x_i|y)$$

To construct the model:

```
for each attribute x_i 
  for each class value c
    for each attribute value v
      count instances with x_i=v and label c
    compute proportions
```

- then to make a prediction, compute for each class

$$P(y)\prod_{i=1}^m P(x_i|y)$$

### Underlying probabilistic model

$$P(x,y) = \prod_{i=1}^n P(y^i)\prod_{m=1}^M P(x_m^i|y^i)$$

## Logistic Regression

$$\hat y = \begin{cases} 1: \sigma(\theta^Tx)>0.5 \\ 0 : \text{otherwise}\end{cases}$$


## Decision Tree

### Entropy

- entropy for discrete random variable $x$ without possible outcomes $1, ..., n$: 
$$H(x) = -\sum_{i=1}^n P(i)\log_2{P(i)}$$

### Mean Information

- Mean information: $m$ attribute values of $x$
  - $H(x_i)$: entropy of class distribution for instances at node $x_i$
  - $P(x_i)$: proportion of instances at sub-node $x_i$
$$\text{mean-info}(x_1, ..., x_m) = \sum_{i=1}^m P(x_i)H(x_i)$$

### Information gain

$$IG(R_A|R) = H(R) - \text{mean-info}(R_A)$$

- when using $IG$ as split criterion, choose the attribute with the highest $IG$
- biased towards attributes with many values

### Split Information
- Split information: entropy of a given split: evenness of distribution of instances to attribute values

$$SI(R_A|R) = H(R_A) = -\sum_{i=1}^m P(x_i)\log_2{P(x_i)}$$

### Gain Ratio 

$$GR(R_A|R) = \frac{IG(R_A|R)}{SI(R_A|R)}$$

- when using $GR$ as split criterion, choose the attribute with the highest $GR$
- discourages selection of attributes with many uniformly distributed values

### ID3

Recursive function: 
```
function id3(root):
  if all instances of same class, or other stopping criterion met:
      stop
  else:
      select a new attribute to use to partition node instances (IG or GR)
      create a branch for each distinct attribute value
      partition root instances by value
      for each leaf node leaf_i:
          id3(leaf_i)
```

## Perceptron 

### Forward pass

$$\hat y = f(\theta^T x)$$
- $f$ may be step, in which case: 

$$
f(z) = 
\begin{cases}
 1 : z > 0 \\
-1 :otherwise
\end{cases}
$$

### Perceptron update rule

$$\theta \leftarrow \theta + \eta(y^i-\hat y^i)x$$

## Neural Network update

### Sigmoid

$$\sigma(z) = \frac{1}{1+e^{-z}}$$
$$\sigma'(z) = \sigma(z)(1-\sigma(z))$$

### Backpropagation Algorithm

- design Neural Net
- initialise $\theta$
- one epoch: repeat for each training instance
- forward pass: work from left to right
  - activation for node $i$ of layer $l$: 
$$a_i^l = \sigma({\theta_i^l}^T x)$$
  - for output node: $\hat y$ = activation of last node
- compute error $E = \frac{1}{2}(y - \hat y)^2$
- backpropagate: 
  - compute $\delta_i^l$ for node $i$ of layer $l$:

$$\delta_i^l = \sigma'(z_i^l)(y-\hat y) : \text{final layer}$$

_- use $\hat y =$ output activation_
_- i.e. look at gradient, and the deviation in activation_

$$\delta_i^l = \sum_j \sigma'(z_i^l)\theta_{ij}^{l+1}\delta_j^{l+1}: \text{hidden layer}$$

_- find weighted sum of all $\delta$s from the nodes of the next layer, weighted by $\theta$ between those nodes_

  - compute $\Delta\theta$ for all nodes, in any order.  For node $i$ in layer $l$:
$$\Delta\theta_i^l = -\eta \nabla E(\theta)=\eta\delta_i^l a_i^{l-1}$$
_- i.e. multiply learning rate, $\eta$, the node's $\delta$, and the node's input $a_i^{l-1}$_
  - update all $\theta$s at once.  For node $i$ in layer $l$
$$\theta_i^l \leftarrow \theta_i^l +\Delta\theta_i^l$$
- continue until stop criteria reached

## Unsupervised Learning

### k-means

```
initialise k seeds as cluster centroids
repeat 
  compute distance of all points to cluster centroids
  assign points to the closest cluster
  recompute cluster centroid
until clusters don't change
```

### Agglomerative clustering

```
initialise all instances as individual clusters
while (# clusters) > 1
  compute triangular elements of proximity matrix between each cluster centroid
  locate the smallest proximity: cluster these instances
  compute updated cluster centroid (typically group average)
```

### Cluster - entropy


### Cluster - purity


## Evaluation

### Accuracy

$$Acc = \frac{TP+TN}{TP+TN+FP+FN}$$

### Error

$$E = 1-Acc$$

### Precision 

$$P = \frac{TP}{TP+FP}$$

### Recall

$$R = \frac{TP}{TP+FN}$$

### F-Score

$$F_\beta = \frac{(1+\beta)^2 PR}{\beta^2 P +R}$$

$$F_1 = \frac{2PR}{P +R}$$

### Macro-average

- calculate per class, then average, e.g. precision

$$P_M = \frac{1}{c}\sum_i P_i$$

### Micro-average

- combine all test instances into a pool, then compute

$$P_\mu = \frac{\sum_i TP_i}{\sum_i (TP_i+FP_i)}$$

### Weighted Average

- weight per-class values by proportion of instances per class

$$P_w = \sum_i \frac{P_in_i}{N}$$

## Feature Selection

### Pointwise Mutual Information (PMI)

- discrepancy between observed joint probability of attribute $A$ and class $C$ and the expected joint probability if $A$ and $C$ independent

$$PMI(A,C) = \log_2\frac{P(A,C)}{P(A)P(C)}$$

- $PMI\gg 0$: useful; $A,C$ occur much more often than random
- $PMI = 0$: useless
- $PMI \ll 0$: $A,C$ negatively correlated

### Mutual Information

- expected value of PMI over all possible events (all combinations of $a,\bar a,c, \bar c$)
- define $0\log 0 \equiv 0$

$$MI(A,C) = \sum_{i\in\{a,\bar a\}}\sum_{j\in\{c,\bar c\}}P(i,j)PMI(i,j) = \sum_{i\in\{a,\bar a\}}\sum_{j\in\{c,\bar c\}}P(i,j)\log_2\frac{P(A,C)}{P(A)P(C)}$$

- for each attribute 
  - produce contingency table of counts of $\{a,\bar a\}$ vs counts of $\{c,\bar c\}$, and totals
  - compute MI for each attribute
- select attributes with highest MI

### Evaluation 

## Semi-Supervised Learning



