# Stage 1: Build Angular application
FROM node:20-alpine AS builder

WORKDIR /app

# Copy dependency definitions
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source files
COPY . .

# Build production bundle
RUN npm run build

# Stage 2: Serve application with Nginx
FROM nginx:alpine

# Copy custom Nginx configuration for Angular SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy compiled browser assets from the builder stage
COPY --from=builder /app/dist/client/browser /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
