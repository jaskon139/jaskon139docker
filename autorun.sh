#!/bin/bash
#/usr/local/bin/hts --forward-port 127.0.0.1:22 80
node app.js &
node proxy.js
