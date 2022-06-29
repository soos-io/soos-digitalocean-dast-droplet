#!/bin/bash

chmod +755 /etc/update-motd.d/99-soos-dast
chmod +755 /usr/soos/run-soos-dast.sh

docker pull soosio/dast