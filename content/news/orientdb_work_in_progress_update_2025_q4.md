+++
title = "OrientDB work in progress update 2025 Q4"
description = "OrientDB work in progress update 2025 Q4"
insert_anchor_links = "none"
date="2026-01-08"
[extra]
menu = false
+++

The forth quarter of 2025 also passed, closing the year, here it is an update on what happened in OrientDB last three months, will follow also
another post with an update of what happen the whole year on OrientDB, but let's see this quarter

## Development

On the development side there have been steady progress on various areas of OrientDB, mostly around distributed, studio, storage, and query engine,
as well some meaning-full dependency updates, some of the changes also were done by external contributors and ported to OrientDB, but lets got through the details

##### Distributed
The bulk of the work in this quarter was around the distributed module, with big progress in the implementation of topology management, re-implementing
the handling of the databases topology, and the flows for create, join and drop of databases, with as well the integration in the engine itself,
reaching the level where already many integration tests run successfully with the new topology management, the work is not yet done though
more work will be done to reach the level where all the current passing integration tests will pass. One other important part was also 
the porting to develop of a Ridbag fix for distributed done on the stable version

##### Studio
More minor updates of deps where done in the studio, with relative code fixes, as follows up for the work on the previous quarter.

#### SQL Engine
Some work was done for optimize the query parsing and query execution, this was also triggered of some fixes done in the stable version.

#### Storage
With the evolution of OrientDB some internal abstraction layers were broken, in the specific the Storage interface, now the biggest refactor to return to 
an isolated storage implementation has been done, there are still bits here and there to correct, but the bulk of the work is done. 

#### Dependencies
The most important dependency update was on gremlin that was upgraded from 3.7 to 3.8 with relative fixes, with the aim 
of ship OrientDB with the latest stable gremlin implementation, other minor dependencies were also updated, with notably the replacement of 
the lz4 not maintained library with a fork now maintained (external contributors helped on this).

## Maintenance
In the maintenance side have been shipped 4 patch releases in the last 3 months, with multiple fixes done by the core team and by external contributors. The relative fixes have been also ported
to the development version where applicable.

## Operations
The documentation generation on the website was update to the last mdbook that provide a nicer layout and a better more complete index.

## Future
The work on the development side for the next quarter will focus on making the new distributed implementation stable and enabled by default, as soon as this is 
done will proceed with a bit of work on modernizing the configuration handling and starting to prepare packages for the first beta release. 


