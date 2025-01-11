+++
title = "OrientDB first set of changes done"
description = "OrientDB first set of changes done"
insert_anchor_links = "none"
date="2025-01-13"
[extra]
menu = false
+++
# 

As mentioned in the previous [post](/news/status-and-backlog/), there was some work in progress to remove some legacy APIs and implementation from the OrientDB code, 
this work is key for a future major release allowing to work on a more recent, small and stable codebase.

Most of the work consisted of migrate some thousand of tests to the new APIs, and removing few tests that do not make sense with the current API, this work as been going on for last few years and resulted as well in the discovery of some compatibility and implementation issues, that have made the work harder and longer, but resulted in a quite sizeable set of issues to be resolved, these fixes have been also ported to 3.2.x actually a big part of the last 10 patch releases in 3.2.x are result of this work.

Now all this work is done and the legacy query APIs based on `OCommandSQL`, `OAsyncQuery`, `OSyncQuery`, `OCommandScript`, have been removed from the code, together with the relative implementation.

In terms of code statistics, the removing of the legacy query engine resulted in this set of changes:
```
291 files changed, 888 insertions(+), 37760 deletions(-)
```

This is quite big delete of code of the majority of it is actually "production" code, most of the test code is actually converted to the new implementation to guarantee compatibility.
 

Also in terms of removing of legacy APIs one implementation supported in 3.2.x was thinkerpop 2.x that then was renamed to gremlin in the version 3.x, the tinkerpop APIs has been deprecated since long time so was now time to remove it from the main repository, together with this work was the promotion of the gremlin driver to the main repository that will be supported for foreseen future.

The code statistics of removing of the thinkerpop 2.x code are:
```
177 files changed, 57748 deletions(-)
```

The main repository did see some additional code imported, but this was anyway maintained before in different repositories, so do not have much of an impact on the overall statistics


There are still some legacy APIs to be removed in the code, one over all is the historical class `ODatabaseDocumentTx` that has been there since 0.x, this will be for sure removed before the release of the next major.

Checking the general work on progress of the original status post what we get now is:


- [x] Remove legacy query engine APIs  
- [ ] Remove legacy document store APIs  
- [ ] Remove legacy database APIs  
- [ ] Fix major issues in query engine and query performance improvement
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

This is already a bit of progress, making the next major release close, as well not all of this will probably be implemented in the next major, some of these points can be shipped also in a minor, so a major can be done earlier.

There have been more work done in the last few months that is not listed here, and probably will be part of a next work in progress update, but for now this is all.
