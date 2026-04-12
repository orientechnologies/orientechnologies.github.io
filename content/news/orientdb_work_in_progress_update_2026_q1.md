+++
title = "OrientDB work in progress update 2026 Q1"
description = "OrientDB work in progress update 2026 Q1"
insert_anchor_links = "none"
date="2026-04-12"
[extra]
menu = false
+++

A new quarter passed and here is the new update!

### Development

The work progressed on the same path of last year, mainly focusing on
making the distributed stable.

Since last year the first tests were already starting to pass with the new topology structure, and more work has been done trying to cover 
new use-cases, the biggest part of this quarter was spent on solving a quite tricky use case that OrientDB has been using since the first implementation of distributed support, in the specific OrientDB
allow you to boot a node in distributed mode, and to execute operations with only one node, so with quorum 1. After that though you can join to it with another node, that have been booted with the same configuration,
this implies that when two nodes with quorum 1 join each others the strategy needed to do the merge is 
more or less the same of a split-brain strategy, this means is quite hard to make it work, but limiting the number of cases where 
this is possible allow to implement a solution that actually work fine.

In the specific the implementation done in the last quarter, allow a node with a network with only itself and quorum 1 to merge into another
network with one node and quorum 1, or a network with multiple nodes and higher quorum, but not to merge two or more networks
with two or more nodes, also before merge the network, checks are run on existing databases to see if there are incompatibilities,
 in case of incompatibilities the network will not be merged.

To implement this use case was quite important also because a lot of tests in the test suite of OrientDB rely on this kind of setup.

Other work was done for remove old implementation not needed anymore due to the new design and doing the usual dependency updates and 
porting bug fixes.

### Maintenance

In terms of maintenance there have been 3 patch releases for the 3.2.x with some minor fixes, done by OrientDB maintainer and 
by external contributors

That's all for this quarter.
