FROM node:14-alpine AS builder

WORKDIR /app

COPY package*.json .

RUN npm install --verbose

COPY . .

RUN ["npm", "run", "build"]

FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html

COPY --from=builder /app/build/ ./

CMD ["nginx", "-g", "daemon off;"]
