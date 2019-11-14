FROM python:2-alpine

ENTRYPOINT [ "certbot" ]

VOLUME /etc/letsencrypt /var/lib/letsencrypt /var/log/letsencrypt

WORKDIR /opt/certbot

COPY certbot-dns-route53 src/certbot-dns-route53

RUN pip install -U pip setuptools

RUN apk add --no-cache --virtual .certbot-deps \
        libffi \
        libssl1.1 \
        libcrypto1.1 \
        openssl \
        ca-certificates \
        binutils
RUN apk add --no-cache --virtual .build-deps \
        gcc \
        linux-headers \
        openssl-dev \
        musl-dev \
        libffi-dev \
    && pip install --no-cache-dir \
        --editable /opt/certbot/src/certbot-dns-route53 \
    && apk del .build-deps
