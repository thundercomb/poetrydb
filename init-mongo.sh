#!/usr/bin/env bash
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
