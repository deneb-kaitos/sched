FROM debian:bullseye-slim AS base-image
RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node
ENV NODE_VERSION 19.4.0
RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
    && case "${dpkgArch##*-}" in \
      amd64) ARCH='x64';; \
      ppc64el) ARCH='ppc64le';; \
      s390x) ARCH='s390x';; \
      arm64) ARCH='arm64';; \
      armhf) ARCH='armv7l';; \
      i386) ARCH='x86';; \
      *) echo "unsupported architecture"; exit 1 ;; \
    esac \
    && set -ex \
    # libatomic1 for arm
    && apt-get update && apt-get install -y ca-certificates curl wget gnupg dirmngr xz-utils libatomic1 --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && for key in \
      4ED778F539E3634C779C87C6D7062848A1AB005C \
      141F07595B7B3FFE74309A937405533BE57C7D57 \
      74F12602B6F1C4E913FAA37AD3A89613643B6201 \
      61FC681DFB92A079F1685E77973F295594EC4689 \
      8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
      C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
      890C08DB8579162FEE0DF9DB8BEAB4DFCF555EF4 \
      C82FA3AE1CBEDC6BE46B9360C43CEC45C17AB93C \
      108F52B48DB57BB0CC439B2997B01419BD92F80A \
    ; do \
      gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key" || \
      gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key" ; \
    done \
    && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
    && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
    && grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
    && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
    && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
    && apt-mark auto '.*' > /dev/null \
    && find /usr/local -type f -executable -exec ldd '{}' ';' \
      | awk '/=>/ { print $(NF-1) }' \
      | sort -u \
      | xargs -r dpkg-query --search \
      | cut -d: -f1 \
      | sort -u \
      | xargs -r apt-mark manual \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs

FROM base-image AS build-all
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

WORKDIR /repo
ADD . ./
RUN apt-get update && apt-get -y --no-install-recommends install brotli \
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

FROM base-image AS package-web-app
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
