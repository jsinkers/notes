---
title: Query Processing in DBMS
notebook: Database Systems
layout: note
date: 2020-04-29
tags: 
...


## Data storage in DBMS

- **page**: unit of information read from/written to disk
  - size: DBMS parameter, e.g. 4-8KB
- cost of page IO dominates cost of typical DB operations, so DB systems need to minimise this cost
- cost of reading several pages in order physically stored << cost of reading pages in random order
- **buffer manager**: handles page fetching
- **record ID/rid**: unique ID for each record/tuple
  - rid value identifies disk address of page containing the record
- **file of records**: can be created, destroyed, have records inserted/deleted, scan sequentially
  - relation will be represented by a file of records

## File Organisations

- **heap file**: records stored unordered
  - supports retrieval of all records, or particular page specified by `rid`
- **sorted file**: pages, and records within them, are stored in order
  - fast for range queries, expensive to maintain
- **index file**: store records directly in index
  - fastest retrieval for a given order

## Index 

- **index**: data structure organising data records on disk to optimise certain retrieval operations
  - allows efficient retrieval of records satisfying search conditions on **search key** fields
    of the index
  - **data entry**: record stored in an index file; in this course typically leaf is a $\langle, k, rid\rangle$ pair, however could also store the record itself
- **clustered index**: ordering of data records same as ordering of data entries in index
  - only clustered if data records are sorted on search key field
- **unclustered index**: ordering of data records very different to data entries in index
  - order of data records is defined by physical order
- files are rarely kept sorted because it is too expensive to maintain, so most indexes will be
  unclustered (unless they are storing records as data entries directly)
- clustered indices are very efficient for range search
- cost of using an index for a range search query varies significantly depending on whether or not
  the index is clustered: 
  - for a clustered index, `rid`s in qualifying data entry points to a 
    contiguous collection of records, so only a few page IOs are needed
  - for an unclustered index, `rid`s in data entries point to records in many different pages, so a
    large number of page IOs may be needed
- **primary index**: index on a set of fields that includes the *primary key*
- **secondary index**: any other index
- **duplicate** data entry: if they have the same value for search key field associated with the
  index
  - primary index guaranteed not to have duplicates
  - secondary index may contain duplicates
- **unique index**: if no duplicates exist, the search key contains a candidate key

## Hash-based Index

- index is a collection of **buckets** 
  - bucket is a primary page + overflow pages as required
- hashing allows you to quickly find records based on given search key value
- **hash function** maps search key to bucket
  - `h(r.search_key)`: bucket in which record `r` should be placed
- good for equality selections
- no good for range selections, as buckets aren't sorted

## Tree-based index

- organise records in a B+ tree: nodes contain pointers to lower levels
  - left subtree: lower values
  - right subtree: higher values
  - leaves contain data entries sorted by search key values
  - structure ensures all paths from root to leaf are the same length, i.e. balanced
  - finding correct leaf page is faster than binary search of pages in sorted file, as
    each non-leaf node can accommodate many pointers
  - nodes typically a physical page, so retrieving a node involves 1 IO
  - in practice height typically ~3-4, so ~ 3-4 IOs to retrieve desired leaf page
- **fanout**: average number of children for a non-leaf node
- if every non-leaf node has $n$ children, tree of height $h$ has $n^h$ leaf pages
- typically each non has on average 100 children, so with height 4: 100 million leaf pages
- search a file with 100 million leaf pages and retrieve page you want in 4 IOs, vs. binary search
  taking $\log_{2}{10^8} \approx 25$$ IOs
- good for range selections
