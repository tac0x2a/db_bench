# Benchmark of column store DBs
## Result
### Storage

#### Before
```sh
% du -h volume/clickhouse | tail -1
860K    volume/clickhouse

% du -h volume/postgresql | tail -1
 79M    volume/postgresql

% du -h volume/mariadb-standard | tail -1
128M    volume/mariadb-standard
```

#### After
```sh
$ wc -l data/test_100000000.csv
100000001 data/test_100000000.csv

$ du -h data/test_100000000.csv
 13G    data/test_100000000.csv

# Load test_100000000.csv to tables by DBeaver...

% du -h volume/clickhouse | tail -1
8.6G    volume/clickhouse

% du -h volume/postgresql | tail -1
 16G    volume/postgresql

% du -h volume/mariadb-standard | tail -1
 15G    volume/mariadb-standard
```

### Query
```
SELECT COUNT(0) FROM db_bench.bench_large;
-- ClickHouse:         0m  2.23s
-- MariaDB-Standard:  13m 19s
-- PostgreSQL      :   5m 47s
```

```
SELECT COUNT(0), color  FROM db_bench.bench_large GROUP BY color;
-- ClickHouse:       0m  5.373s
-- MariaDB-Standard:
-- PostgreSQL      :
```

```
SELECT count(*) FROM (select * from db_bench.bench) as a ALL INNER JOIN (select * from db_bench.bench_large) USING color
-- ClickHouse      : 0m  52.513s
-- MariaDB-Standard: None
-- PostgreSQL      : None
```

Command for query execution by clickhouse-client
```
docker run yandex/clickhouse-client -h <hostname> -q '<query>' --time
```


# How To Run Benchmark
## 1. Start DBs
```
$ docker-compose up
```

## 2. Generate data
```
$ chmod +x ./generate_testdata.py
$ ./generate_testdata.py 1000 -o 1000raws_testdata.csv
```

## 3. Load data
### 3.1. Create tables
+ PostgreSQL
  ```sql
  CREATE DATABASE db_bench;

  -- DROP TABLE db_bench.bench

  CREATE TABLE db_bench.bench (
  	uid bigint NULL,
  	"name" varchar(2048) NULL,
  	code varchar(2048) NULL,
  	address varchar(2048) NULL,
  	color varchar(2048) NULL,
  	random varchar(2048) NULL,
  	create_at timestamp NULL
  );
  ```

+ MariaDB Standard
  ```sql
  CREATE DATABASE db_bench;

  -- DROP TABLE db_bench.bench

  CREATE TABLE db_bench.bench (
    `uid` bigint(20) unsigned DEFAULT NULL,
    `name` varchar(2048) DEFAULT NULL,
    `code` varchar(2048) DEFAULT NULL,
    `address` varchar(2048) DEFAULT NULL,
    `color` varchar(2048) DEFAULT NULL,
    `random` varchar(2048) DEFAULT NULL,
    `create_at` datetime DEFAULT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  ```

+ MariaDB ColumnStore
  ```sql
  CREATE DATABASE db_bench;

  -- DROP TABLE db_bench.bench

  CREATE TABLE db_bench.bench (
    `uid` bigint(20) DEFAULT NULL,
    `name` text DEFAULT NULL,
    `code` text DEFAULT NULL,
    `address` text DEFAULT NULL,
    `color` text DEFAULT NULL,
    `random` text DEFAULT NULL,
    `create_at` datetime DEFAULT null
  ) ENGINE=ColumnStore DEFAULT CHARSET=latin1;
  ```

+ ClickHouse
  ```sql
  CREATE DATABASE db_bench;

  -- DROP TABLE db_bench.bench;

  CREATE TABLE db_bench.bench (
    `uid` UInt64,
    `name` String,
    `code` String,
    `address` String,
    `color` String,
    `random` String,
    `create_at` DateTime
  ) ENGINE = MergeTree() ORDER BY uid PARTITION BY toYYYYMM(create_at);
  ```

### 3.2. Load csv to table
Load csv for each DB. Recommended: [DBeaver](https://dbeaver.io/) is able to load csv to table by GUI.

# etc...
## TABiX - http://localhost:8080
GUI Client for ClickHouse.

## OMNIDB - http://localhost:8000
GUI Client for PostgreSQL and Maria DB

## Nifi - http://localhost:8081
Web based ETL tool.

## Pentaho - http://localhost:8082
Web based ETL tool.

## ClickHouse DataType Test
```sql
DROP TABLE db_bench.type_test;

CREATE TABLE db_bench.type_test (
  `uid` UInt64,
  `i8` Int8,
  `i16` Int16,
  `i32` Int32,
  `i64` Int64,
  `ui8` UInt8,
  `ui16` UInt16,
  `ui32` UInt32,
  `ui64` UInt64,
  `f32` Float32,
  `f64` Float64,
  --`Decimal32` Decimal(10,2),
  `s` String,
  `fs32` FixedString(32),
  `d` Date,
  `dt` DateTime,
  `e8` Enum8('hello' = 1, 'world' = 2),
  `ai32` Array(Int32),
  `astr` Array(String),
  `t_i32_s` Tuple(Int32, String),
  `create_at` DateTime
) ENGINE = MergeTree() ORDER BY uid PARTITION BY toYYYYMM(create_at);

INSERT INTO db_bench.type_test (
	uid, i8, i16, i32, i64, ui8, ui16, ui32, ui64,
	f32, f64, s, fs32, d, dt,
	e8, ai32, astr, t_i32_s,
	create_at
) VALUES (
	1, -128, -32768, -2147483648, -9223372036854775808, 0, 0, 0, 0,
	1.1, 2.2, 'string', 'fixed_string32', '2018-09-30', '2018-10-01 12:34:56',
	'hello', [1,2,3], ['string4', 'string5'], tuple(1, 'tuple_string'),
	'2018-10-02 12:34:56'
);
INSERT INTO db_bench.type_test (
	uid, i8, i16, i32, i64, ui8, ui16, ui32, ui64,
	f32, f64, s, fs32, d, dt,
	e8, ai32, astr, t_i32_s,
	create_at
) VALUES (
	2, 127, 32767, 2147483647, 9223372036854775807, 255, 65535, 4294967295, 18446744073709551615,
	-1.0/0, 1.0/0, 'string', 'fixed_string32', '2018-09-30', '2018-10-01 12:34:56',
	'hello', [1,2,3], ['string4', 'string5'], tuple(1, 'tuple_string'),
	'2018-10-02 12:34:56'
);

select * from  db_bench.type_test;
```
