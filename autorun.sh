#!/bin/bash
#/usr/local/bin/hts --forward-port 127.0.0.1:22 80
/etc/init.d/ssh start
cd /app
node app.js -p 3000 &
node proxy.js > text.log 2>1
