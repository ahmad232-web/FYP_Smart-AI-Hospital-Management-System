# Stage 1: Build TypeScript source code
FROM node:20-slim AS builder

WORKDIR /app

# Copy dependency definitions and TypeScript config
COPY package*.json tsconfig.json ./

# Install all dependencies (including devDependencies needed for build)
RUN npm ci

# Copy source code
COPY src ./src

# Compile TypeScript to JavaScript
RUN npm run build

# Stage 2: Production runtime
FROM node:20-slim

WORKDIR /app

ENV NODE_ENV=production

# Copy package files and install only production dependencies
COPY package*.json ./
RUN npm ci --omit=dev

# Copy compiled files from builder stage
COPY --from=builder /app/dist ./dist

EXPOSE 4001

CMD ["node", "dist/server.js"]
