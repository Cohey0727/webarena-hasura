FROM nginx:alpine

RUN apk add --no-cache bash

COPY nginx.conf.template /etc/nginx/nginx.conf.template

RUN echo '#!/bin/bash\n\
envsubst \
  \'"\$NGINX_SERVER_NAME \$NGINX_SSL_CERTIFICATE \$NGINX_SSL_CERTIFICATE_KEY \$NGINX_PROXY_PASS"\' \
  < /etc/nginx/nginx.conf.template \
  > /etc/nginx/nginx.conf\n\
nginx -g "daemon off;"' > /docker-entrypoint.sh \
&& chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]