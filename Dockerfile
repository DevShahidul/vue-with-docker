# Build stage
FROM node:24-alpine AS builder
RUN npm install --global corepack@latest \
    && corepack enable pnpm \
    && corepack use pnpm@latest-10

RUN addgroup app && adduser -S -G app app
USER app

WORKDIR /app

COPY package*.json pnpm-lock.yaml ./

RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm build


# Production Nginx stage
FROM nginx:1.29.1-alpine-slim AS production

# Copy the built app from the builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom nginx config for Vue history mode
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]