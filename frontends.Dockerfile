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

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm --filter *_frontend install --frozen-lockfile
RUN pnpm --filter *_frontend build

RUN pnpm deploy --filter=qu_admin_organiser_frontend --prod /prod/qu_admin_organiser_frontend
RUN pnpm deploy --filter=qu_guest_frontend --prod /prod/qu_guest_frontend


FROM base AS qu_admin_organiser_frontend

WORKDIR /app

COPY --from=builder /prod/qu_admin_organiser_frontend/dist/. /usr/share/nginx/html

EXPOSE 80


FROM base AS qu_guest_frontend

WORKDIR /app

COPY --from=builder /prod/qu_guest_frontend/dist/. /usr/share/nginx/html

EXPOSE 80
