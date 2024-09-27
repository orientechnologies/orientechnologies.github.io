+++
title = "Current status and backlog for the future releases"
description = "Current status and backlog for the future releases"
insert_anchor_links = "none"
date="2024-09-30"
[extra]
menu = false
+++

Here is a bit of an insight of what is going to be on OrientDB, 
firstly I do want to make it clear that for now, there are no clear deadlines and no commitment on including certain features in a future release, but only a backlog of things that may happen in a not too far future on the project and may be included in a possible new major release, but nothing is yet set in stone, what I can confirm, is that I'm working to ship a new major release full of cleanups and fixes in the future.

Here all the thing needed to be done in OrientDB, even though not all required for the next major:

- Remove legacy query engine APIs  
    Most of the work for the next major is the cleanup of usages in internal code and tests of the old query engine, this is a long work as there were ~5000 usages around the code, during the process of migration of tests will need also to fix also all regressions introduced with the implementation of the new query engine that are discovered.
    
- Remove legacy document store APIs  
    The document and record APIs provide methods to handle persistence of itself mainly: save, load, reload, delete through the use of thread local than then call the relative methods on the database session, the time revealed that this is not a good design, so we are moving out of APIs relying on thread local, this will also involve the migration of internal/test code.
- Remove legacy database APIs   
    There are a set of APIs that have been deprecated since a while, like the one related to the old query engine, as well locking management, and async store/read APIs, as well the venerable `ODatabaseDocumentTx`, all of this will be deleted before the release of the next major. 
- Fix major issues in query engine and query performance improvement  
  In 3.0 we did redesign the query engine using proper parsing, planning and execution steps, even though this was an architectural improvement from the previous implementation, it still needs some good amount of work to reach an optimal implementation, there are still things not solved properly, like reporting of parsing error in an understandable way, improving the execution planning to better use indexes, avoid allocating a massive amount of memory for index search, and general bug fixing and optimization that are not done yet, many bugs have been found and corrected recently with the migration of existing test that used to run on the old query engine to the new query engine, and more is to come. This will be a continuous work and is not blocking for the release of a new major
- Transactional DDLs  
    As today when a DDLs is run may run in one or more transactions, depends on the change performed by the DDL, the multiple transactions may create issues in case of crash during the execution of the DDL, causing stale structures around, or in distributed environment where a node may be lagging behind a specific DDL transaction but not the rest of transactions (even though we can detect this, as today in these cases we need a full sync). 
    Work need to be done to make all DDL operations as an atomic transaction and clear described by a low level transaction, so this can be replicated and recover in a deterministic way in distributed, avoiding slow full sync, this does not block the release of a next major.
    
- In memory database backup & restore  
   As today in memory databases cannot be backup or restored, the idea is to add this support with the interoperability with disk persistent backup and restore implementations so that a database created in memory can be backup and restored as a disk persistent database, and the other way around, this is a requirement also for distributed support of in memory databases, this feature is not required for the next major but is mostly likely that will be included
- Support for distributed "in memory" databases  
  As today the distributed replication works only with disk persistent databases, this is the case for a few reasons, not existing backup and restore of in memory databases, that is  required for full sync, missing of logging of operations that are required for delta syncing, and as well the distributed configuration is  persisted on disk, all off these missing parts need to be worked on to allow in memory distributed databases, some of the fixes will be included in the next major, is not yet said that the full in memory distributed support will be ready for the next major release  
- Split distributed transaction log from WAL  
  The current distributed implementation trace in the WAL some data and metadata that is used for partial sync recent changes across nodes, but if a node lag behind for too long, this creates an issue because the WAL cleanup strategy is completely detached from the distributed status, making full sync of the database a necessity in many cases even it should not be needed, the solution here is keeping the logging of low level data and distributed data in the same component, keeping the local database consistency, but splitting where the data is written, so the distributed data can have a different cleanup strategy that follow the distributed network. 
- Remove of TP2(aka blueprints) APIs from code  
  The TP2 code was the base of the graph logic in OrientDB, but since 3.x graph are native in the core, even though some tests still rely on this module, so some work need to be done to migrate the tests before deleting all the TP2 related code, in some cases it may need to be replaced with TP3 implementations
- Include of TP3(aka gremlin) APIs in main repository  
  OrientDB since 3.x support gremlin, the plan is to continue this support, and merge this code in the main repository, to allow easier testing and releasing
- Rewrite distributed node discovery  
  Current implementation use  Hazelcast (quite outdated version) for node discovery this served well for long time, but newer version of HZ do not have the same support, and anyway most of the main flow is out of the HZ logic, so is better to rewrite this part and prepare to remove completely the dependency from HZ. 
The work itself is quite long, because is need to support different discovery algorithms including the one provided by common cloud providers, and also implement an algorithm with decent security. Help on this is really welcome, also on discovering of libraries that already provide similar use cases.
- Introduce proper consensus based algorithm for distributed topology management  
  The topology of the network as today is based in distributed Hazelcast maps, this works OK-ish, but fail in handling 
  correctly offline events, or even node detaching operations, having already designed a protocol to keep the data consistent at the database level, we can use similar concepts to build a protocol that keep the topology consistent.
    
- New minimum java versions as 17, with migrations with the next major  
    We will push the minimum required java version to 17, this means that we can do many changes to embrace the new version, like
    - Automatically refactor a lot of code to use the new java syntax
    - Use of new java APIs like for example some additional methods introduced to streams APIs
    - Maybe start to modularize the OrientDB project with java modules, to reduce the risk of misuse of private APIs
    - Use new java features like records, that may give performance and memory benefits in some use cases

    It would have been nice actually to go directly on java 22 that will allow us to use the full power of memory arenas, but for now we are conservatively aiming to java 17, if the next major comes quite late, than we may consider targeting the java 22.
    
- Review of data types trying to remove redundant one potentially adding new types  
    There are a number of data types, that are more a description of implementation and behavior than a data type itself, I refer mainly to EMBEDDEDLIST,EMBEDDESET, LINKLIST,LINKSET, that are all describing an array with different constraint, like element uniqueness (SET) and content type like 'LINK' this does not logically make sense, so it would be more appropriate to have a generic array type with constraints. These are not the only thing that in long term would be beneficial to change in terms of typing, having a more generic base typing detached from the internal implementation would allow more evolution in the implementations and a more stable APIs, work on this would happen though mostly after the release of the next major version. 
- Add & Complete server commands  
    As today we do have server commands for some limited use cases, this will be improved covering use cases like backup+restore, server users management, distributed topology handling, databases managements including advanced database creation operations, etc. As well as today there is only one parser for all the query language, this need to be split in two parsers and two executors, one for server queries one for database queries. We do target for improvement in the server executor for the next major, but most of the new features will be included after that. 
- Review the console to integrate server commands  
    Command Line interface has been in low maintenance for a while, so more maintenance is needed, together with keeping up with new features provided by the OrientDB APIs, like server commands.
    
- Introduce a third party http server  
  OrientDB since the first day had its own specific http server implementation, this served us well at early times, but has been lacking of features and updates of what a http server need to have today, things like, compression,content-partial , HTTP2/3, etc. The plan is to get a standard http server and plug it inside the OrientDB server, without change/rewrite the current endpoints, there have been already few refactors to introduce interfaces between the OrientDB logic and the server implementation, that can be used to plug in another http server. It would be really nice if this will be included in the next major, but it mostly depends on if the work can be done in a timely manner, help from third party here is more than welcome 
    
- Review and improve non java clients  
  There are a number of non java clients that need maintenance and updated to the latest version of OrientDB, In many cases these clients still works correctly because of the server backward compatibility, but the evolution of OrientDB require work on them to bring them up to the same level in terms of basic features with the java client, this is independent to the releases of OrientDB and work from the larger community is more than welcome.
- Review and upgrades in studio dependencies  
  Studio has been in low maintenance for a while, the short term target would be picked up a bit the maintenance of it mainly to keep it up to date with recent libraries.
- Review metrics, maybe integration of OpenTelemetry  
  As today we do have an API that is used internally to records some metrics and export it in some external formats, this though is not used extensively, and a lot of uses are only in deprecated implementations, the plan is uniform a bit the API, increase is use around the code, and maybe add also an internal API to trace requests across all the levels of OrientDB (client, server, distributed)


This is not yet a complete list, there are more refactor and implementations that need to be done that are not listed here, if you are interested in a specific feature, or you are looking for a new feature on OrientDB feel free to contributed or sponsor some of the contributors to work on it.

More update will come as new features and implementations are integrated in OrientDB, even before the next major release, so will be easier to keep track of what is going on behind the curtains.

That's all for now!

