+++
title = "OrientDB Guarantee to the users"
description = "OrientDB Guarantee to the users"
insert_anchor_links = "none"
weight = 3
[extra]
menu = false
+++

When using and updating OrientDB as a user you may expect some level of guarantees, this level may not be the same by all open source projects, so here we are outlining the guarantee we do provide to our users.

OrientDB follow semantic versioning in a quite strict way in the specific:

the version is composed by 3 numbers like 2.5.25 this 3 numbers are:

- first number (2 in the example) is the major version
- second number (5 in the example) is the minor version
- third number (25 in the example) is the patch version

Here what changes, guarantees, and breakage can happen in each specific version

## Major 

When a major is shipped the biggest set of changes can be done, but the kind of changes is still sort of limited, let's list them by categories:

### APIs
- Any sort of new APIs can be add, with completely redefined behavior
- Deprecated APIs, that have been deprecated in the last hotfix of the previous major+minor can be removed, if an APIs
    has never been deprecated it cannot be removed, this allow users to smouthly update to the next major, the guaraantee is
    if using the last hotfix, there are not usages of deprecated methods, it should be possible to just update to the new major without 
    the requirement of code changes
- New deprecation of APIs are allowed

### SQL
- Any sort of new SQL syntax can be add, whit new complete behaviour
- Some syntax or functions can be removed, if been deprecated in the documentation of the previous major/minor 
- Behaviour of query and functions should be constant, alternative functions can be provided for behaviour evolution

### Protocols
- Any sort of new protocol massages and concept can be add trough a versioning of the protocol
- The protocol version older than the previous major may be removed, old the protocol versions of the previous major need to be supported

### Disc
- Any new disc structure can be add, with new complete behaviour
- All disc structure of the previous major version can be open and operated, so a new major should allow to operate databases created with a previous major
- Should be possible to migrate or port databases created with a older version of the database.

# Minor

### APIs
- New APis can be add for additional behaviour as far they do not break existing APIs
- No APIs can be removed
- APIs can be deprecated for remove in the next major

### SQL
- New syntax or function can be add
- No remove of functions or syntax
- Deprecation can be done trough docs

### Protocols
- New messages may be add for additional functionalities
- No message or message behaviour for previous protocol version can be removed

### Disc
- New Disk data structure can be add
- fuctionalities for migrate(upgrade) between data structures can be add
- No disc format can be removed

## Patch

### APIs 
- New minor APIs can be add, driven by user issues/bug
- No removing of APIs allowed
- Deprecation of APIs allowed, better if linked to an alternative API

### SQL
 - new minor syntax and function are allowed if driven by user issues/bug
 - no removing of syntax or function allowed
 - deprecation allowed with replacement function

### Protocols
- new messages/functions allowed if driven by user issue/bug
- no removing of any existing messages or protocols allowed

### Disk
- new data structure allowed if driven by user issue/bug
- no removing of disc structure allowed.
- new data migration functionalities allowed


