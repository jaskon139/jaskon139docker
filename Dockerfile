FROM krishnasrinivas/wetty
WORKDIR /app

RUN echo 'root:root' | chpasswd

EXPOSE 3000

ENTRYPOINT ["node"]
CMD ["app.js", "-p", "3000"]
