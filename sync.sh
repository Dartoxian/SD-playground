#!/bin/bash

SERVER=$1
REMOTE_DIR=$2
LOCAL_DIR=$3

while :
do
  rsync -Patv $SERVER:$REMOTE_DIR $LOCAL_DIR
  rsync -Patv $LOCAL_DIR $SERVER:$REMOTE_DIR
  echo "Synced!"
  sleep 5
done

