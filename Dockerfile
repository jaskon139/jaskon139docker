FROM krishnasrinivas/wetty
WORKDIR /app

RUN npm install http-proxy

RUN git clone https://github.com/konieshadow/docker-node-proxy.git /app

ENTRYPOINT ["node", "proxy.js"]

EXPOSE 80

RUN echo 'root:root' | chpasswd

EXPOSE 3000

ENTRYPOINT ["node"]

#CMD ["app.js", "-p", "3000"]
