FROM reddec/squid

RUN echo "acl localnet src 0.0.0.0/0" > /etc/squid3/squid.acl.conf
RUN  echo "http_access allow localnet" >> /etc/squid3/squid.acl.conf

CMD ["service squid3 restart"]
