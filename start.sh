#!/bin/bash

# Start the first process - backend 8001
node ./dist/index.js &

# Start the second process - ui 3001
serve -s ./ui/dist -l tcp://0.0.0.0:3001 &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?