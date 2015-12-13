FROM krishnasrinivas/wetty
WORKDIR /app

RUN npm install http-proxy

RUN git clone https://github.com/jaskon139/jaskon139docker.git 

RUN cp -R jaskon139docker/* .

RUN git clone https://github.com/nodejitsu/node-http-proxy.git

EXPOSE 4500

RUN echo 'root:root' | chpasswd

RUN chmod +x /app/autorun.sh

ENTRYPOINT ["/app/autorun.sh"]

#EXPOSE 3000

#ENTRYPOINT ["node"]

#CMD ["app.js", "-p", "3000"]
