#!/usr/bin/env bash

set -euo pipefail

source r2dbc-mssql/ci/docker-lib.sh
start_docker "3" "3" "" ""

[[ -d $PWD/maven && ! -d $HOME/.m2 ]] && ln -s $PWD/maven $HOME/.m2

r2dbc_mssql_artifactory=$(pwd)/r2dbc-mssql-artifactory
r2dbc_spi_artifactory=$(pwd)/r2dbc-spi-artifactory

rm -rf $HOME/.m2/repository/io/r2dbc 2> /dev/null || :

cd r2dbc-mssql
./mvnw deploy \
    -DaltDeploymentRepository=distribution::default::file://${r2dbc_mssql_artifactory} \
    -Dr2dbcSpiArtifactory=file://${r2dbc_spi_artifactory}
