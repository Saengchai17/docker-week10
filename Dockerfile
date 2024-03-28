FROM node:18-alpine as base
FROM base as builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
FROM base as release
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
EXPOSE 3000
ENV PORT=3000
 
CMD [ "node", "src/index.js" ]