FROM node:alpine3.16 AS system-setup
RUN apk update \
  && apk upgrade

FROM system-setup AS build-all
ARG PUBLIC_WS_PROTO
ARG PUBLIC_WS_HOST
ARG PUBLIC_WS_PORT
ARG PUBLIC_WEB_PROTO
ARG PUBLIC_WEB_HOST
ARG PUBLIC_WEB_PORT
ARG PUBLIC_WEB_DEBUG_PORT

ENV PUBLIC_WS_PROTO=${PUBLIC_WS_PROTO}
ENV PUBLIC_WS_HOST=${PUBLIC_WS_HOST}
ENV PUBLIC_WS_PORT=${PUBLIC_WS_PORT}
ENV PUBLIC_WEB_PROTO=${PUBLIC_WEB_PROTO}
ENV PUBLIC_WEB_HOST=${PUBLIC_WEB_HOST}
ENV PUBLIC_WEB_PORT=${PUBLIC_WEB_PORT}
ENV PUBLIC_WEB_DEBUG_PORT=${PUBLIC_WEB_DEBUG_PORT}

RUN echo $PUBLIC_WS_PROTO $PUBLIC_WS_HOST $PUBLIC_WS_PORT $PUBLIC_WEB_PROTO $PUBLIC_WEB_HOST $PUBLIC_WEB_PORT $PUBLIC_WEB_DEBUG_PORT

WORKDIR /repo
ADD . ./
RUN apk add --no-cache brotli \
  && corepack enable \
  && corepack prepare pnpm@7.23.0 --activate \
  && pnpm --recursive install \
  && rm -rf ./sources/front-end/browser/node_modules ./sources/front-end/browser/.svelte-kit rm -rf ./sources/front-end/browser/build \
  && pnpm install -F ./sources/front-end/browser --virtual-store-dir sources/front-end/browser/node_modules/.pnpm \
  && pnpm --filter=@deneb-kaitos/sched-browser-front-end run build \
  && rm -f sources/front-end/browser/build/client/vite-manifest.json \
  && find . \
    -not -type d \
    -and -not -iname "*.gz" \
    -and -not -iname "*.br" \
    -and -not -iname "*.png" \
    -and -not -iname "*.jpg" \
    -and -not -iname "*.ico" \
    -and -not -path "*node_modules*" \
    -and -not -path "*server*" \
    -exec gzip -9 -k '{}' \; \
    -exec brotli --best '{}' \;

FROM node:alpine3.16 AS package-web-app
ENV NODE_ENV=production
WORKDIR /app
COPY --chown=node:node --from=build-all /repo/sources/front-end/browser/build .
COPY --chown=node:node --from=build-all /repo/sources/front-end/browser/package.json .
RUN find client/_app/immutable/assets -iname "*.woff*" -and -not -iname "Inter.var*.woff2*" -exec rm -f '{}' \; \
    && find . -exec touch -d@$(( $(date +%s ) )) '{}' \;

FROM package-web-app AS run-web-app
USER node
EXPOSE 3000
CMD [ "node", "index.js" ]
