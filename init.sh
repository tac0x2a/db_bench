#!/bin/sh

# Initialize volumes
docker volume rm db_bench_clickhouse
docker volume rm db_bench_mariadb-cs-etc
docker volume rm db_bench_mariadb-cs-data1
docker volume rm db_bench_mariadb-cs-local
docker volume rm db_bench_mariadb-cs-db
docker volume rm db_bench_mariadb-standard
docker volume rm db_bench_postgresql-data

mkdir -p volume/clickhouse
mkdir -p volume/mariadb-cs/etc
mkdir -p volume/mariadb-cs/data1
mkdir -p volume/mariadb-cs/local
mkdir -p volume/mariadb-cs/db
mkdir -p volume/mariadb-standard
mkdir -p volume/postgresql/data

# Setup environment
echo "# Environment Variables for docker-compose.yml" > .env
echo PWD=`pwd` >> .env
