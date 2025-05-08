# Stage 1/4
FROM node:22-alpine AS base

# Stage 2/4
FROM base AS deps

RUN apk add --no-cache libc6-compat
WORKDIR /app

# Install pnpm and add it to PATH
RUN corepack enable && corepack prepare pnpm@latest --activate

# Confirm pnpm works
RUN pnpm --version

COPY package.json pnpm-lock.yaml* ./
RUN pnpm i --frozen-lockfile;

# Stage 3/4
FROM deps AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

ARG ENV
ENV ENV=${ENV}
ENV NEXT_TELEMETRY_DISABLED=0

RUN pnpm build

# Stage 4/4
FROM base AS runner
WORKDIR /app

RUN apk add --no-cache curl

ARG ENV
ARG REDIS_URL
ENV ENV=${ENV}
ENV REDIS_URL=${REDIS_URL}
ENV NEXT_TELEMETRY_DISABLED=0

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# COPY --from=builder /app/public ./public

# Set the correct permission for prerender cache
RUN mkdir .next
RUN chown nextjs:nodejs .next

# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT=3000
# set hostname to localhost
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]
