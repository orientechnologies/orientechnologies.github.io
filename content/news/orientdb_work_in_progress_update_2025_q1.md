+++
title = "OrientDB work in progress update 2025 Q1"
description = "OrientDB work in progess update 2025 Q1"
insert_anchor_links = "none"
date="2025-04-22"
[extra]
menu = false
+++
# 
Since the last update have passed a few months so here is an update on what happened on the develop branch in the meanwhile.

As mentioned in the original work post, most of the effort for the 4.0 is removed long deprecated things, 
and in this few months have been removed two main legacy APIs. If you have been using OrientDB for a while you may be a bit affectionate to them as they were the main APIs before the 3.x,
but now `ODadabaseDocumentTx` and `OServerAdmin` are not part of the codebase anymore, together with them have been removed some related helpers, and the underlying implementations that they required, 
this was not a big amount of code, but these APIs where used in a lot of tests, so it has been long effort to convert all legacy tests to new APIs

Some other refactor work that was not mentioned in early posts was also done, mostly around the client implementation, 
traditionally OrientDB used as interface for network layer the storage interface, the time revealed that was not a good design choice, making way more complex handle evolution of remote network and disk persistence, 
resulting in actual storage implementation details leak around the codebase, without respecting the interface, now the network implementation do not implement the storage interface anymore, 
making the client implementation actually look like a client implementation without low level storage concepts in it, and the storage interface is now again the separation layer between raw data persistence and database logic, 
more work still need to be done to split clearly the storage implementation and the higher level implementations and make the persistence engine pluggable again like in OrientDB 1.x, this will probably be done during the development of 4.x.

The last and the biggest set of work was done around one really important issue, that was the memory usage of the query engine, 
in 3.x you could drain all the memory of the server with a properly crafted not too complex query, this was due to the algorithm that was used to find the indexes to use in the query,
this algorithm has been redesigned from scratch resulting in a way lower memory usage for complex query with multiple conditions, with this redesign though some of the optimization
that existed in the previous implementation that improved the performance for simple queries are not there anymore and need to be re-done, an example of this is avoiding to check the condition already handled by the index lookup,
these optimizations are not critical for a 4.0.0 release, but will be good if they will be included before the final release, also with the new implementation additional optimization are now possible.
So the current implementation has slightly different performance characteristics compared to 3.x, some simpler query may be a bit slower and some more complex query will be way faster, later
on in the implementation will be done some profiling and optimization to make sure to have only performance improvements and not regressions.


Going back to the original list of things to do here is the update status:


- [x] Remove legacy query engine APIs  
- [ ] Remove legacy document store APIs  
- [x] Remove legacy database APIs  
- [x] Fix major issues in query engine and query performance improvement
- [ ] Transactional DDLs
- [ ] In memory database backup & restore
- [ ] Support for distributed "in memory" databases
- [ ] Split distributed transaction log from WAL
- [x] Remove of TP2(aka blueprints) APIs from code
- [x] Include of TP3(aka gremlin) APIs in main repository
- [ ] Rewrite distributed node discovery
- [ ] Introduce proper consensus based algorithm for distributed topology management
- [ ] New minimum java versions as 17, with migrations with the next major
- [ ] Lucene integration improvements
- [ ] Review of data types trying to remove redundant one potentially adding new types
- [ ] Add & Complete server commands
- [ ] Review the console to integrate server commands
- [ ] Introduce a third party http server
- [ ] Review and improve non java clients
- [ ] Review and upgrades in studio dependencies
- [ ] Review metrics, maybe integration of OpenTelemetry


Again this list do not need to be all complete to release a 4.0.0, but few more critical points need to be done before releasing the 4.0.0
