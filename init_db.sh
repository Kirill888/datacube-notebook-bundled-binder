#!/bin/bash

set -eux

DB_DUMP_URL=${DB_DUMP_URL-"https://ga-aws-dea-dev-users.s3.amazonaws.com/kk/datacube-db.tar.xz"}

# PostgreSQL Database initialisation

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATABASE=$(awk '/db_database:/{print $2}' "$THISDIR/.datacube.conf")

createdb -O $USER $DATABASE
datacube system init

if [ -n "${DB_DUMP_URL}" ]; then
    dropdb "${DATABASE}"
    createdb "${DATABASE}"
    curl --silent "${DB_DUMP_URL}" | xz -d | pg_restore -d "${DATABASE}" || true
fi
