FROM node:16-alpine as builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

FROM node:16-alpine as production

WORKDIR /usr/src/app

RUN npm install -g serve

COPY --from=builder /usr/src/app/build ./build

EXPOSE 80

CMD ["serve", "-s", "build", "-l", "80"]
