+++
title = "OrientDB work in progress update 2025 Q3"
description = "OrientDB work in progress update 2025 Q3"
insert_anchor_links = "none"
date="2025-10-15"
[extra]
menu = false
+++

The third quarter of this year also passed, here it is an update on what happened in OrientDB last three months

## Development

On the development side there have been steady progress on various areas of OrientDB, mostly around distributed, deprecated
APIs, Studio, and script engine, lets got through the details

##### Script Engine 
The script engine implementations have been moved outside the core, so now is possible to maintain multiple implementation of the script engine even if they handle 
the same languages, as well users now can choose what script engine include as a dependency or not include any at all, separating the implementation from the core it also reduces the amount of dependencies that are
necessary to use OrientDB as embedded or for the OrientDB Java client.
As result of this refactor now exists two new modules orientdb-nashorn and orientdb-polyglot that implement the script engine APIs for respectively Nashorn and Graal.  

##### Studio
On studio most of the work done was around the update of dependencies, this in some cases required also to fix incompatibilities in the code or in the build process, anyway studio still use
quite a few outdated tools and libraries and more work will be need to be done in future to upgrade them.

##### Deprecated APIs
There have been some easy but big work to reduce usage of deprecated APIs from main code and test cases, this is mostly required to be able to delete the deprecated APIs in the future, decreasing the complexity
and increasing the maintainability.

##### Distributed
This is the area that saw most of the development work, in the last few months have been defined new structures to keep the network topology in the meaning of tracking the list of nodes online and what node has what database, 
has been also defined a new protocol to handle the bootstrapping the network and the updates consistently, 
this new implementations also reduce dependency on external libraries.

## Maintenance
In the maintenance side have been shipped 3 patch releases in the last 3 months, with multiple fixes done by the core team and by external contributors. The relative fixes have been also ported
to the development version where applicable.

## Operations
The new website is up and running, with a fairly updated documentation and an automatic build for publish everything directly from the source, one important update is the [Support Page](https://orientdb.dev/support/) 
where you can find some contacts and plans for request OrientDB support.   

## Future
Future work will continue on the current path, focusing the finalization of the new distributed implementation, as soon that is done work will start to produce some packages for produce a first beta,
so users can start to test the new implementations.

