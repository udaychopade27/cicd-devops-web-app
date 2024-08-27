FROM node:alpine AS build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
CMD [ "nginx","-g","daemon off;" ]
