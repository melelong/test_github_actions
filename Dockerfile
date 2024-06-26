FROM node:iron-alpine3.20 as base

FROM base as build-stage

WORKDIR /app

COPY . .

CMD ["ls"]
