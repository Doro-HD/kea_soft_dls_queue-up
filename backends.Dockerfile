FROM node:22-alpine AS base

FROM base AS builder

RUN apk add --no-cache gcompat
RUN apk add bash
RUN apk add pnpm

WORKDIR /app
COPY . .

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm --filter *_backend --filter *_api build

RUN pnpm deploy --filter=ff_admin_organiser_backend --prod /prod/ff_admin_organiser_backend
RUN pnpm deploy --filter=ff_guest_backend --prod /prod/ff_guest_backend
RUN pnpm deploy --filter=ff_authenticator_api --prod /prod/ff_authenticator_api
RUN pnpm deploy --filter=ff_synchronizer_api --prod /prod/ff_synchronizer_api


# admin organiser backend
FROM base AS ff_admin_organiser_backend
WORKDIR /app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 hono

COPY --from=builder --chown=hono:nodejs /prod/ff_admin_organiser_backend/.env ./.env
COPY --from=builder --chown=hono:nodejs /prod/ff_admin_organiser_backend/node_modules ./node_modules
COPY --from=builder --chown=hono:nodejs /prod/ff_admin_organiser_backend/dist ./dist
COPY --from=builder --chown=hono:nodejs /prod/ff_admin_organiser_backend/package.json ./package.json

USER hono
EXPOSE 3000

CMD ["node", "/app/dist/index.js"]


# guest backend
FROM base AS ff_guest_backend
WORKDIR /app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 hono

COPY --from=builder --chown=hono:nodejs /prod/ff_guest_backend/.env ./.env
COPY --from=builder --chown=hono:nodejs /prod/ff_guest_backend/node_modules ./node_modules
COPY --from=builder --chown=hono:nodejs /prod/ff_guest_backend/dist ./dist
COPY --from=builder --chown=hono:nodejs /prod/ff_guest_backend/package.json ./package.json

USER hono
EXPOSE 3000

CMD ["node", "/app/dist/index.js"]


# authenticator
FROM base AS ff_authenticator_api
WORKDIR /app


RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 hono

COPY --from=builder --chown=hono:nodejs /prod/ff_authenticator_api/.env ./.env
COPY --from=builder --chown=hono:nodejs /prod/ff_authenticator_api/node_modules ./node_modules
COPY --from=builder --chown=hono:nodejs /prod/ff_authenticator_api/dist ./dist
COPY --from=builder --chown=hono:nodejs /prod/ff_authenticator_api/package.json ./package.json

USER hono
EXPOSE 3000

CMD ["node", "/app/dist/index.js"]


# synchronizer
FROM base AS ff_synchronizer_api
WORKDIR /app


RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 hono

COPY --from=builder --chown=hono:nodejs /prod/ff_synchronizer_api/.env ./.env
COPY --from=builder --chown=hono:nodejs /prod/ff_synchronizer_api/node_modules ./node_modules
COPY --from=builder --chown=hono:nodejs /prod/ff_synchronizer_api/dist ./dist
COPY --from=builder --chown=hono:nodejs /prod/ff_synchronizer_api/package.json ./package.json

USER hono
EXPOSE 3000

CMD ["node", "/app/dist/index.js"]