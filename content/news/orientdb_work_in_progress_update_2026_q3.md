+++
title = "OrientDB work in progress update 2026 Q3"
description = "OrientDB work in progress update 2026 Q3"
insert_anchor_links = "none"
date="2026-10-07"
[extra]
menu = false
+++


Third quarter of 2026 is passed and here is a new update of what happened in OrientDB 

### Development

This quarter saw development work in multiple areas:

For first testing of the distributed implementation has been a continuous work in the last quarter, with improvements in sync and recover from out of sync situations,
also the consolidation of the distributed protocol and additional unit tests to cover conceptual flows, on the specific of existing distributed integration test the range of passing test cases is still around two thirds. 

A lot of work it also happened around how OrientDB is configured, as last stable, OrientDB is configured with multiple files with different formats(xml,json,properties) also is possible
to pass properties as environment variables trough configuration files or directly trough code, work has happened and is going on to rationalize all of this, 
reducing the number of files, trying to use a more modern formats and make the configuration more user friendly.

Another area of improvement is server/context administration, a new java API has been defined to open a administration session, that can be used to create/list/drop databases, and manage server users, roles, nodes ecc,
also new SQL commands have been implemented to handle manipulation of server users and roles, more may be implemented in future.

Some work also started on the packaging, the source code of packages has been refactored, and in the long run we will have a bigger set of packages to support
different use cases and environments.

### Maintenance

There have been some sizeable work in 3.2.x with 4 patch releases, mostly around the query engine, and the usual dependency updates, 
we have seen an increased of LLM generated report of various quality with some of them related to security issue that have been promptly handled, so if you are holding back on your 
updates please update to the most recent version of OrientDB has security fixes!

### Future

The next months we will try to consolidate the new configuration format, this is one of the most important part missing for the next 4.0, and after this is consolidated it may 
be possible to start to produce some first beta packages, as usual work will continue on testing the distributed implementation and improvements in remote, query engine, and other areas,
including as well porting of fixes from 3.2.x. 


