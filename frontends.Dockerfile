# Use official NGINX image
# NGINX will automatically serve files from /usr/share/nginx/html
FROM node:alpine

FROM nginx:alpine AS base

FROM base AS builder

WORKDIR /app
COPY . .

RUN apk add --no-cache gcompat
RUN apk add bash
RUN apk add pnpm

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm --filter *_frontend install
RUN pnpm --filter *_frontend build

RUN pnpm deploy --filter=ff_admin_organiser_frontend --prod /prod/ff_admin_organiser_frontend
RUN pnpm deploy --filter=ff_guest_frontend --prod /prod/ff_guest_frontend


FROM base AS ff_admin_organiser_frontend

WORKDIR /app

COPY --from=builder /prod/ff_admin_organiser_frontend/dist/. /usr/share/nginx/html

EXPOSE 80


FROM base AS ff_guest_frontend

WORKDIR /app

COPY --from=builder /prod/ff_guest_frontend/dist/. /usr/share/nginx/html

EXPOSE 80
