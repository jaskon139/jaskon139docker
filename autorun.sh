#!/bin/bash
#/usr/local/bin/hts --forward-port 127.0.0.1:22 80
/etc/init.d/ssh start
#/etc/init.d/tinyproxy start
#/usr/bin/hts -F 127.0.0.1:22 80
cd /app
/usr/bin/python /app/http-tunnel/tunneld.py -p 80 &
node app.js -p 3000 &
node proxy.js 
