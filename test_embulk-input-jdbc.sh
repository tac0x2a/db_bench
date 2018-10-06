#!/bin/sh

sh -c "cd ../clickhouse-jdbc && mvn -Dmaven.test.skip=true package" && cp ../clickhouse-jdbc/target/clickhouse-jdbc-exp-*.jar ./lib/ \
#
sh -c "cd ../embulk-input-clickhouse && ./gradlew gem" && \
#
CLASS_PATH="../embulk-input-clickhouse/classpath"

./embulk preview \
  -L ../embulk-input-clickhouse \
  -C  ${CLASS_PATH}/guava-19.0.jar:${CLASS_PATH}/jackson-annotations-2.7.0.jar:${CLASS_PATH}/joda-time-2.9.9.jar:${CLASS_PATH}/httpclient-4.5.2.jar:${CLASS_PATH}/jackson-core-2.7.3.jar:${CLASS_PATH}/lz4-1.3.0.jar:${CLASS_PATH}/commons-codec-1.9.jar:${CLASS_PATH}/httpcore-4.4.4.jar:${CLASS_PATH}/jackson-databind-2.7.3.jar:${CLASS_PATH}/slf4j-api-1.7.21.jar:${CLASS_PATH}/commons-logging-1.2.jar:${CLASS_PATH}/httpmime-4.5.2.jar \
  conf_dump_data_clickhouse.yml
