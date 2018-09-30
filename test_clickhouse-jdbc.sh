#!/bin/sh

cp ../clickhouse-jdbc/target/clickhouse-jdbc-0.1-SNAPSHOT.jar ./lib/

./embulk run conf_dump_data_clickhouse.yml -C  ./lib/bsh-2.0b4.jar:./lib/guava-19.0.jar:./lib/jackson-annotations-2.7.0.jar:./lib/joda-time-2.9.9.jar:./lib/httpclient-4.5.2.jar:./lib/jackson-core-2.7.3.jar:./lib/lz4-1.3.0.jar:./lib/commons-codec-1.9.jar:./lib/httpcore-4.4.4.jar:./lib/jackson-databind-2.7.3.jar:./lib/slf4j-api-1.7.21.jar:./lib/commons-logging-1.2.jar:./lib/httpmime-4.5.2.jar:./lib/jcommander-1.27.jar:./lib/testng-6.8.21.jar
