FROM krishnasrinivas/wetty
WORKDIR /app

RUN npm install http-proxy

RUN git clone https://github.com/jaskon139/jaskon139docker.git /app

ENTRYPOINT ["node", "proxy.js"]

EXPOSE 4500

RUN echo 'root:root' | chpasswd

#EXPOSE 3000

#ENTRYPOINT ["node"]

#CMD ["app.js", "-p", "3000"]
