# db_bench


create table for ColumnStore
```sql
CREATE TABLE `bench` (
  `uid` bigint(20) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `code` text DEFAULT NULL,
  `address` text DEFAULT NULL,
  `color` text DEFAULT NULL,
  `create_at` datetime DEFAULT null
) ENGINE=ColumnStore DEFAULT CHARSET=latin1;
```
