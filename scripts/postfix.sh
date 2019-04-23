#!/bin/bash

envsubst < /etc/postfix/main.cf > /etc/postfix/main.cf
envsubst < /etc/postfix/sasl_passwd > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
rm -f /var/spool/postfix/pid/*.pid
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

/usr/sbin/postfix -c /etc/postfix start
sleep infinity