FROM node:16-alpine as builder

WORKDIR /app

COPY package.json .
COPY yarn.lock .

RUN yarn install --frozen-lockfile --ignore-optional

COPY . .
RUN yarn run build

FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80