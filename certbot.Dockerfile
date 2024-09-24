FROM certbot/certbot

RUN apk add --no-cache dcron

RUN echo '#!/bin/sh' > /usr/local/bin/renew-certs.sh && \
    echo 'certbot renew --webroot -w /var/www/certbot --force-renewal --email $EMAIL -d $DOMAIN --agree-tos --cert-name $DOMAIN --config-dir /ssl --work-dir /ssl --logs-dir /ssl' >> /usr/local/bin/renew-certs.sh && \
    chmod +x /usr/local/bin/renew-certs.sh

RUN echo '0 2 * * * /usr/local/bin/renew-certs.sh' > /etc/crontabs/root

CMD certbot certonly --webroot -w /var/www/certbot --force-renewal --email $EMAIL -d $DOMAIN --agree-tos --cert-name $DOMAIN --config-dir /ssl --work-dir /ssl --logs-dir /ssl && crond -f

