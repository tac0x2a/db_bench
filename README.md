# db_bench

# Start DBs
```
$ docker-compose up
```

# Load data by Embulk
After start DBs,

```
$ ./embulk run conf_load_data_mariadb.yml
$ ./embulk run conf_load_data_mariadb_mcs.yml
```

# misc
## create table for MariaDB ColumnStore example

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
