#!/usr/bin/env bash
# https://gist.github.com/x-yuri/22eace6d6d047cbe090e1412eaabc97b

set -eu
mongo -- "$MONGO_DB" <<EOF
    var rootUser = '$MONGO_INITDB_ROOT_USERNAME';
    var rootPassword = '$MONGO_INITDB_ROOT_PASSWORD';
    var admin = db.getSiblingDB('admin');
    admin.auth(rootUser, rootPassword);

    var user = '$MONGO_DB_USER';
    var passwd = '${MONGO_DB_PASS-}' || user;
    db.createUser({user: user, pwd: passwd, roles: ["readWrite"]});
EOF
