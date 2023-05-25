FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /etc/ssl/inception/certificates
RUN mkdir -p /etc/ssl/inception/privatekey

COPY ./cert/certificate.crt /etc/ssl/inception/certificates/certificate.crt
COPY ./cert/privatekey.pem /etc/ssl/inception/privatekey/privatekey.pem


COPY ./conf/default.conf /etc/nginx/conf.d/default.conf



EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
