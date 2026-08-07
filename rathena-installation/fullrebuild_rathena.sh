#!/bin/bash
set -e

cd /root/rAthena

echo "Stop running server.."
screen -S login -X quit 2>/dev/null || true
screen -S char -X quit 2>/dev/null || true
screen -S map -X quit 2>/dev/null || true

./configure

echo "Rebuilding..."
make clean

JOBS=$(nproc)

# Maksimal 4 job
if [ "$JOBS" -gt 4 ]; then
    JOBS=4
fi

echo "Compiling server with $JOBS jobs(core)"
make server -j"$JOBS"

chmod a+x login-server && chmod a+x char-server && chmod a+x map-server && chmod a+x web-server
