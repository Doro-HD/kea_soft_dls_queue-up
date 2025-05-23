FROM node:22-alpine AS base

FROM base AS builder

RUN apk add --no-cache gcompat
RUN apk add bash
RUN apk add pnpm

WORKDIR /app
COPY . .

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm --filter qu_admin_organiser_* install --frozen-lockfile
RUN pnpm --filter qu_admin_organiser_* build

# admin organiser
RUN pnpm deploy --filter=qu_admin_organiser_backend --prod /prod/qu_admin_organiser_backend
RUN pnpm deploy --filter=qu_admin_organiser_frontend --prod /prod/qu_admin_organiser_frontend
RUN pnpm deploy --filter=qu_admin_organiser_synchronizer_api --prod /prod/qu_admin_organiser_synchronizer_api


# RUNNERS

# backend
FROM base AS qu_admin_organiser_backend
WORKDIR /app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 hono

COPY --from=builder --chown=hono:nodejs /prod/qu_admin_organiser_backend/.env ./.env
COPY --from=builder --chown=hono:nodejs /prod/qu_admin_organiser_backend/node_modules ./node_modules
COPY --from=builder --chown=hono:nodejs /prod/qu_admin_organiser_backend/dist ./dist
COPY --from=builder --chown=hono:nodejs /prod/qu_admin_organiser_backend/package.json ./package.json

USER hono
EXPOSE 3000

CMD ["node", "/app/dist/index.js"]


# frontend
FROM nginx:alpine3.21 AS qu_admin_organiser_frontend

# NGINX will automatically serve files from /usr/share/nginx/html
COPY --from=builder /prod/qu_admin_organiser_frontend/dist/. /usr/share/nginx/html

EXPOSE 80


# synchronizer
FROM base AS qu_admin_organiser_synchronizer_api
WORKDIR /app


RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 hono

COPY --from=builder --chown=hono:nodejs /prod/qu_admin_organiser_synchronizer_api/.env ./.env
COPY --from=builder --chown=hono:nodejs /prod/qu_admin_organiser_synchronizer_api/node_modules ./node_modules
COPY --from=builder --chown=hono:nodejs /prod/qu_admin_organiser_synchronizer_api/dist ./dist
COPY --from=builder --chown=hono:nodejs /prod/qu_admin_organiser_synchronizer_api/package.json ./package.json

USER hono
EXPOSE 3000

CMD ["node", "/app/dist/index.js"]