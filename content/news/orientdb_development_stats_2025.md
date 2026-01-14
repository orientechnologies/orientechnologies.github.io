+++
title = "OrientDB development statistics of 2025"
description = "OrientDB development statistics of 2025"
insert_anchor_links = "none"
date="2026-01-14"
[extra]
menu = false
+++

2025 year is finished, so I think is a good time to give out some overall update with some stats on what happen on
OrientDB last year, most of the work happen on the main repository on a couple of branches, the develop
branch is where the new development is happening, and the 3.2.x branch is where the fixes of the stable release are done.

## Development

In terms of development the work has been steady on almost all fronts, in the specific 
removing deprecated APIs and implementations, like legacy `ODatabaseDocumentTx`, re-designing the query engine planning and execution, 
 with the result of avoiding some exponential parsing and memory allocation, isolating the storage implementation from the rest of the engine making 
sure that concurrency and parallelism are handled correctly, re-designing the distributed topology management to improve stability for
nodes join, restart, disconnection, and in general work on many sides trying to achieve an overall improvement of stability.   
All this work has been done mostly on
the development branch, excluding some minor patches that have been ported to 3.2.x, so no user has benefited from them,
as well all these improvements are not yet battle tested (there is no test like production), so user reachability will be the target of this year with hopefully
some first beta releases and if all goes right a stable 4.0 release.

More details on the improvements happened this year can be read in the quarter updates, check them out:

[OrientDB Work In Progress Update Q1](https://orientdb.dev/news/orientdb-work-in-progress-update-2025-q1/)  
[OrientDB Work In Progress Update Q2](https://orientdb.dev/news/orientdb-work-in-progress-update-2025-q2/)  
[OrientDB Work In Progress Update Q3](https://orientdb.dev/news/orientdb-work-in-progress-update-2025-q3/)  
[OrientDB Work In Progress Update Q4](https://orientdb.dev/news/orientdb-work-in-progress-update-2025-q4/)  

This is also a good time to check again the backlog status that was defined [in a previous post](/news/status-and-backlog/) and 
mark the latest status:

- [x] Remove legacy query engine APIs  
- [ ] Remove legacy document store APIs  
   Partial, most of the legacy API uses have been removed remain just some minor uses and the APIs itself
- [X] Remove legacy database APIs   
    ODatabaseDocumentTx have been removed, remain some old interfaces and minor API, but can be considered done
- [x] Fix major issues in query engine and query performance improvement
- [ ] Transactional DDLs
- [ ] In memory database backup & restore
- [ ] Support for distributed "in memory" databases
- [ ] Split distributed transaction log from WAL
- [x] Remove of TP2(aka blueprints) APIs from code
- [x] Include of TP3(aka gremlin) APIs in main repository
- [ ] Rewrite distributed node discovery
- [x] Introduce proper consensus based algorithm for distributed topology management
- [ ] New minimum java versions as 17, with migrations with the next major  
    Java 17 is already the minimum version and newer coding features are used, is still missing some automatic migration
to newer java features of the codebase
- [ ] Lucene integration improvements
    Work has been done in the storage engine to allow a tighter integration, but the integration
    itself is not done
- [ ] Review of data types trying to remove redundant one potentially adding new types
- [ ] Add & Complete server commands
- [ ] Review the console to integrate server commands
- [ ] Introduce a third party http server
- [ ] Review and improve non java clients
- [ ] Review and upgrades in studio dependencies  
    Partial updates are done, a lot more need to be done, it cannot be considered done
- [ ] Review metrics, maybe integration of OpenTelemetry

More or less a third of the backlog is done, and the most API breaking changes are done, so as said before this 
is a level to start to wrap up and produce a 4.0 beta release soonish, not all the work on this backlog need to be done for the final release.


## Maintenance 

The maintenance continued as usual providing support to users and clients in the last year, with the release of 12 patch releases, improving
OrientDB in various areas like query engine, distributed, import export, ecc. This work will continue on this year, with hopefully
starting to shift the maintenance to a new version for the end of the year.


## Code Statistics
 
### Develop Branch

Commits: **644**  
Commits Authors (excluding bots): **4**  

Diffs from first and last commit of the year:   
1669 files changed, 40435 insertions(+), 45194 deletions(-)

The changes this year are less than last year, but last year included also the porting of external modules to the main repository,
that did the biggest part of that changes


### 3.2.x branch

Commits: **126**  
Commits Authors (excluding bots): **4**  

Diffs from first and last commit of the year:    
122 files changed, 7024 insertions(+), 7247 deletions(-)


## Other Activities

### Issues & PRs
In terms of other activities in 2025 year have been opened 63 new issues and have been resolved 21 issues, also have been 15 Pull Requests (excluding bots) of
which 14 have been merged/closed

### Website
The website was revamped with a more updated documentation with more modern tools online, with now the [documentation](/documentation/) section where is possible 
to find the last version of the docs.


