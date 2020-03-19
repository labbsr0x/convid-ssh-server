#!/usr/bin/env sh

# The password comes in through stdin
PAM_PASSWORD=`cat -`
# echo "User: ${PAM_USER}; Password: ${PAM_PASSWORD}; Type: ${PAM_TYPE}"

API_BASE=$(cat /api.url)

URL=$API_BASE/account/$PAM_PASSWORD/machine/$PAM_USER
curl --fail $URL
STATUSCODE=$?

echo "GET $URL returned $STATUSCODE"

if [ "$STATUSCODE" != "0" ]; then
    # echo "Auth failed for user='$PAM_USER' password='$PAM_PASSWORD'"
    echo "Auth failed for user '$PAM_USER'"
    exit 1
fi

echo "Auth succeeded for user '$PAM_USER'"

exit 0
