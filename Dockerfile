# base image
FROM node:12.13-alpine as builder

WORKDIR /usr/src/app
COPY package.json /usr/src/app
RUN npm install --loglevel warn
COPY . .
RUN npm run build

FROM docker2021repos/nginx:latest
USER root
COPY --from=builder /usr/src/app/dist/indygo /usr/share/nginx/html
