---
title: Recipes and Formulae
notebook: Machine Learning
layout: note
date: 2021-06-15
tags: 
...

## Probability

### Basics 

- A and B are independent iff $P(A\cap B) = P(A)P(B)$
- disjoint: the probability of 2 disjoint events $A\cap B$ = 0, is $P(A \vee B) = P(A)+P(B)$
- product rule: $P(A\cap B) = P(A|B)P(B) = P(B|A)P(A)$
- chain rule: lets you choose the factorisation you want

$$P(A_1\cap...\cap A_n) = P(A_1)P(A_2|A_1)P(A_3|A_2\cap A_1)...P(A_n|\cap_{i=1}^{n-1} A_i)$$

### Bayes' Rule

$$P(A|B) = \frac{P(A)P(B|A)}{P(B)}$$

- $P(A|B)$: posterior probability, degree of belief having accounted for $B$
- $P(A)$: prior probability, initial degree of belief in $A$.
  - probability of $A$ occurring given no additional information about $A$
- $P(B|A)$: likelihood, support $B$ provides for $A$
- $P(B)$: evidence
- allows update of prior belief based on empirical evidence

### Marginalisation

- idea: we want to know probability of event $A$ irrespective of outcome of another event $B$
  - we can do so by summing over all possible outcomes $\mathcal{B}$ of $B$
- marginalise over the set of outcomes of $B$ as:

$$P(A) = \sum_{b\in\mathcal{B}}P(A,B=b) = \sum_{b\in\mathcal{B}}P(A|B=b)P(B=b)$$

$$P(A|C) = \sum_{b\in\mathcal{B}}P(A|C,B=b)P(B=b|C)$$
### Expectation Value 

$$E[f(x)] = \sum_{x\in X} f(x)Px)$$

## Optimisation 

### Exact optimisation

- establish objective function/loss function $f(\theta)$
  - maximise objective function
  - minimise loss function
- take first derivative w.r.t. $\theta$
- set to 0
- solve for $\theta$

### Gradient Descent

$$\theta \leftarrow \theta - \eta\nabla f(\theta)$$

- $\eta$: learning rate/step size
- $\nabla = [\frac{\partial}{\partial\theta_i}]$: gradient; vector of partial derivatives

## Distance - Categorical Features

### Simple matching coefficient

- number of matching features divided by number of all features in the sample
- normalised
- $d$: distance
- $m$: total number of features
- $k$: number of matching features

$$d = \frac{m - k}{m}$$

### Hamming

- number of differing elements in 2 strings of equal length

### Jaccard

- Jaccard Similarity $J$: intersection of 2 sets divided by their union
  - how much overlap is there between the two sets?

$$J = \frac{|A\cap B|}{|A\cup B|} = \frac{|A\cap B|}{|A|+|B|-|A\cap B|}$$

$$d = 1-J$$

## Distance - Numerical features

### Manhattan - L1

$$d(x,y) = \sum_i |x_i - y_i|$$

### Euclidean - L2

$$d(x,y) = \sum_i (x_i - y_i)^2$$

### Cosine

- cosine of angle between 2 vectors: 

$$\cos(a,b) = \frac{a \cdot b}{|a||b|}$$

- distance: 

$$d(a,b) = 1-\cos(a,b)$$

- as normalised by magnitude of each feature vector, you can compare items of different size
  - e.g. word counts: article vs book
  - e.g. pixels: high vs low res image

## Distance - Ordinal Features

### Normalised Ranks

- sort values, return a rank $r \in {1,...,m}$
- map ranks to evenly spaced values between 0 and 1:
$$z = \frac{r}{m}$$
- then use a numeric distance function

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

### Classification Loss Function

- negative conditional log-likelihood

- for instance $i$:

$$\mathcal{L}^i = -\log P(y^i|x^i;\theta)$$

- for all instances:

$$\mathcal{L} = -\sum_i \log P(y^i|x^i;\theta)$$

#### Binary classification

$$\hat y_1^i = P(y^i=1|x^i; \theta)$$

$$\mathcal{L} = -\sum_i [y^i \ln(\hat y_1^i)+(1-y^i)\ln(1-\hat y_1^i)]$$

#### Multiclass classification

$$\mathcal{L} = -\sum_i\sum_{j\in Y} y_j^i \ln(\hat y_j^i)$$

- $y_j^i = 1$ if $j$ is the true label for instance $i$, else 0
- $Y$ is the set of labels

### Regression Loss Function

#### Mean Squared Error (MSE)

$$\mathcal{L} = \frac{1}{N}\sum_i^N (y^i - \hat y^i)^2$$

### Output Function

#### Binary Classification

- neuron with step function:

$$\hat y = \begin{cases} 1: \sigma(\theta^Tx)>0.5 \\ 0 : \text{otherwise}\end{cases}$$

#### Multiclass classification

- one node per class
- apply __softmax__ to normalise $K$ outputs from the last hidden layer into a probability distribution over classes

$$p(y^i = j|x^i;\theta) = \frac{\exp{z_j}}{\sum_{k=1}^K \exp z_k}$$

#### Regression Classification

- identity function: no transformation applied
- could use sigmoid, tanh

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

- bottom-up clustering

```
initialise all instances as individual clusters
while (# clusters) > 1
  compute triangular elements of proximity matrix between each cluster centroid
  locate the smallest proximity: cluster these instances
  compute updated cluster centroid (typically group average)
```

### Bisecting k-means

- top-down clustering
- idea: to obtain $K$ clusters, split all points into 2 clusters.  
  - Select one of these clusters to split
  - repeat until $K$ clusters produced

```
initialise cluster list with a single cluster containing all points
repeat
  Pick a cluster to remove from list (e.g. largest cluster)
  // Perform trial bisections of the chosen cluster
  for i = 1..num trials
    Bisect selected cluster via k-means
  endfor
  Select the 2 clusters from bisection with minimum total SSE
  Add these 2 cluster to cluster list
until cluster list contains k clusters
```

### Unsupervised Evaluation 

#### Cluster Cohesion

- high cluster cohesion desirable: instances in a cluster should be closely related
- inverse of total distance between each pair of instances

$$\text{cohesion}(C_i) = \frac{1}{\sum_{x,y\in C_i} d(x,y)}$$

#### Cluster separation

- high cluster separation desirable: instances distinct from one another if in different clusters

$$\text{separation}(C_i, C_j) = \sum_{x\in C_i, y\in C_j} d(x,y)$$

#### Scatter/Sum of Squared Error (SSE)

- $k$ clusters
- $m_i$: representative point for cluster $C_i$, e.g. centroid
- error is distance to nearest cluster

$$SSE = \sum_{i=1}^k\sum_{x\in C_i} d(m_i, x)^2$$

- as $k$ increases, $SSE\rightarrow 0$ as each instance is in its own cluster
  - sometimes add penalty term $\propto \log k$

### Supervised Evaluation

- how consistent are class labels within/across clusters

#### Purity

- probability of the class with highest representation in each cluster
- higher is better

$$\text{purity} = \sum_{i=1}^{k} \frac{|C_i|}{N} \max_j P_i(j)$$

#### Entropy

- entropy of distribution over labels per cluster
- lower is better

$$\text{entropy} = \sum_{i=1}^k \frac{|C_i|}{N}H(x_i)$$

- $x_i$: distribution of class labels in cluster $i$

## Semi-Supervised Learning

### Self-training/Bootstrapping

- $L = \{(x^i, y^i)\}_{i=1}^{l}$ labelled instances
- $U = \{x^i\}_{i=l+1}^{l+u}$ unlabelled instances
- need a safety net: move bad instances back into unlabelled pool

#### Algorithm

- Repeat
  - Train model $f$ on $L$ using supervised learning method
  - Apply $f$ to predict labels on all instances in $U$
  - identify $U'\subset U$ with high confidence labels
  - move elements from $U$ to $L$: $U\leftarrow U\backslash U'$, $L\leftarrow L\cup U'$, with classifier predictions as labels
- Until $L$ doesn't change

### Query Strategies for Active Learning

#### Least confident

- select queries where classifier is least confident of classification

$$x = \argmax_x(1-P(\hat y|x))$$

#### Margin sampling

- select queries where classifier is least able to distinguish between 2 categories

$$x = \argmin_x(P(\hat y_1|x;\theta)-P(\hat y_2|x;\theta))$$

#### Entropy


- look across whole class probability distribution for instances: which instance has the highest uncertainty?

$$x = \argmax_{x} -\sum_i P(\hat y_i|x;\theta)\log_2 P(\hat y_i|x;\theta)$$

#### Query by committee (QBC)

- ensembling approach
- train multiple classifiers on labelled data
- use each to predict on unlabelled data
- select instances with highest disagreement, e.g. entropy

- assumes uncorrelated errors between classifiers
