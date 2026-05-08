FROM node:18-alpine
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npx tsc || true
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
RUN mkdir -p /app/data
RUN chown -R nodejs:nodejs /app
USER nodejs
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD node healthcheck.cjs
EXPOSE 3004 3006 3007
CMD ["sh", "-c", "node start.js"]
