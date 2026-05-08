FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npx tsc
EXPOSE 3007
CMD ["node", "oauth-mcp-server.mjs"]
