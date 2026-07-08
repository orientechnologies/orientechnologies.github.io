+++
title = "OrientDB work in progress update 2026 Q2"
description = "OrientDB work in progress update 2026 Q2"
insert_anchor_links = "none"
date="2026-07-05"
[extra]
menu = false
+++

We are over the second quarter of the year and here we are with a new update 

### Development

In this quarter there have been a lot of development around the distributed module, almost all the use cases that relied on Hazelcast
have been re-implemented using the new topology structures, so we are on the path to remove the requirement of Hazelcast dependency,
together with this more test and integration test were fixed, and at the current state all the basic test cases are passing and
two third of existing integration tests are passing as well, the only use case not completely re-implemented yet is 
the initial discovery of the network.

In this quarter was also merged branch that add experimental support to backup and restore of in memory databases, the current 
implementation works only in blocking mode, and do not support for now the Lucene indexes, this is the first step to support
in memory only databases with the distributed flow. 

### Maintenance

In terms of maintenance there have been 5 patch releases for the 3.2.x with fixes in the query engine selection and usage of indexes,
also fixes in date type handling, and some security fixes in the remote protocol.

### Future

In the next quarter will try to finalize the distributed implementations, well will try to review the configuration of OrientDB
that has been historically quite java centric and not too user-friendly and improve the server and database admin query engine, also
will continue improving testing and make sure old integration test pass.
