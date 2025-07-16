+++
title = "OrientDB work in progress update 2025 Q2"
description = "OrientDB work in progress update 2025 Q2"
insert_anchor_links = "none"
date="2025-07-15"
[extra]
menu = false
+++

A new quarter passed and a new update on OrientDB development is here.


This last few months saw the start of work on one of the most complex part of OrientDB, 
the distributed implementation, as mentioned in the original post and in few places in the support forum, 
most of the needed work is around the redesign of the topology management, and this is where the progress happened, in the details:

For better performances the data protocol require having some strategy to reduce conflicts when allocating record Ids, 
the metadata for this logic used to be stored together with the topology metadata, this now has been moved to the schema in the specific inside the class definition, 
allowing a more specialized allocation strategy in the future, and simplifying the topology management, keeping data related to the database in the database.

Another are of improvement was around DDLs operations, in 3.x versions to guarantee consistency of DDLs was used a distributed exclusive lock provided by Hazelcast, 
anyway the recent protocol to execute DDLs can handle consistency without the need of this lock, so the logic was refactored to just use the OrientDB distributed protocol to handle DDLs, 
removing the requirement of Hazelcast in this case.

Hazelcast is used also to keep information about the topology, using distributed hash maps where keys are based on nodes and database names, 
and values contains documents with the topology data, all this documents store the data in schema-less way, 
this is has been proved hard to maintain because in many places documents where passed around without much metadata about the content, 
so a refactor has been done to wrap this documents on some java types, so their content is actually well-defined now,
and is easy to track what is used and where, to allow in the more long term plan is to remove Hazelcast DHT, and use OrientDB protocols to manage this data.

Work not related to distributed flow it happens mostly around the studio UI, where dependencies are slowly updated, 
as well more fix and refactors have been done in remote client and the query engine, following as well 3.2.x fixes.

On the operational side there have been also some challenges in the last few months, 
the orientdb.com and orientdb.org went offline, I lost a bit the track of who handle that domains, and I haven't been notified before they went offline, 
so I spent some time rebuild ad republishing the most important content, that are mainly docs that you can find on this website specifically [here](https://orientdb.dev/documentation/),
also the source of this website is on the open ( [here](https://github.com/orientechnologies/orientechnologies.github.io/) ), so is going to be easier to keep it up in the future, hopefully 
this issues not happen again in the future.  
