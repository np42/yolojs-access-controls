#!/bin/sh

THIS=$(dirname "$0")
RESOURCES="$THIS/../resources"
PACKAGE="$THIS/../package.json"

if [ -z "$(which jq)" ]; then version="$(date +%s)"
else version="$(cat "$PACKAGE" | jq -r '.version')"
fi

echo -n 'Host: ' && read host
echo -n 'User: ' && read user

mysqldump --add-drop-table -u"$user" -h"$host" -p yolojs-access-controls > "$RESOURCES/access-controls-$version.sql"
