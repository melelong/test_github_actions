FROM node:iron-alpine3.20 as base

FROM base as build-stage

WORKDIR /app

COPY package.json .

RUN npm install -g pnpm

RUN pnpm config set registry https://registry.npmmirror.com/

RUN pnpm install

COPY . .

RUN pnpm run build

# production stage
FROM base as production-stage

COPY --from=build-stage /app/dist /app
COPY --from=build-stage /app/package.json /app/package.json
# 静态资源目录
COPY --from=build-stage /app/public /app/public
# 模板引擎目录
COPY --from=build-stage /app/views /app/views

RUN ls

WORKDIR /app

RUN npm install -g pnpm

RUN pnpm config set registry https://registry.npmmirror.com/

RUN pnpm install --production

EXPOSE 8000

CMD ["node", "/app/src/main.js"]
