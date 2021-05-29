FROM node:16-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    jq \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*


ENV WORKDIR=/app/
WORKDIR ${WORKDIR}

ARG WEBSITE_DIRECTORY=website
COPY ${WEBSITE_DIRECTORY}/yarn.lock ${WEBSITE_DIRECTORY}/package.json ${WORKDIR}
RUN yarn install --frozen-lockfile

COPY $WEBSITE_DIRECTORY $WORKDIR

RUN yarn run build && \
    yarn cache clean

ENV PORT=80
ENV HOST=0.0.0.0
CMD ["sh", "-c", "yarn run serve --port $PORT --host $HOST"]
