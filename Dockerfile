FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install -g pnpm
RUN bun install
COPY . .
RUN pnpm build

FROM nginx:1.21.6-perl as production-stage

COPY --from=build-stage  /app/dist /var/www

RUN rm /var/log/nginx/*
COPY nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]