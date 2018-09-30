#!/bin/sh

sh -c "cd ../embulk-input-jdbc/embulk-input-clickhouse && ../gradlew gem" && \

DRIVER="../embulk-input-jdbc/embulk-input-clickhouse/default_jdbc_driver"

./embulk preview \
  -L ../embulk-input-jdbc/embulk-input-jdbc \
  -L ../embulk-input-jdbc/embulk-input-clickhouse \
  -C  ${DRIVER}/guava-19.0.jar:${DRIVER}/jackson-annotations-2.7.0.jar:${DRIVER}/joda-time-2.9.9.jar:${DRIVER}/httpclient-4.5.2.jar:${DRIVER}/jackson-core-2.7.3.jar:${DRIVER}/lz4-1.3.0.jar:${DRIVER}/commons-codec-1.9.jar:${DRIVER}/httpcore-4.4.4.jar:${DRIVER}/jackson-databind-2.7.3.jar:${DRIVER}/slf4j-api-1.7.21.jar:${DRIVER}/commons-logging-1.2.jar:${DRIVER}/httpmime-4.5.2.jar \
  conf_dump_data_clickhouse.yml




 #
