FROM node:0.10

RUN npm install http-proxy

ADD proxy.js /proxy.js
ADD defaultSites.json /defaultSites.json

ENTRYPOINT ["node", "proxy.js"]
EXPOSE 80
