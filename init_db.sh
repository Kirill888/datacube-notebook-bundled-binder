#!/bin/bash

set -eux

# PostgreSQL Database initialisation

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATABASE=$(awk '/db_database:/{print $2}' $THISDIR/.datacube.conf)

createdb -O $USER $DATABASE

datacube system init

#Further Database preparation, e.g. product addition and dataset indexing
#psql -d $DATABASE -U $USERNAME -f $THISDIR/seed_db.sql
