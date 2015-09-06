#!/bin/bash
/usr/local/bin/hts --forward-port 127.0.0.1:22 80
/usr/sbin/sshd -D
