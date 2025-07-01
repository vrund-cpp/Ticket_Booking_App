#!/bin/bash

# Prisma build fix for failed migration on Render Free Tier

echo "🧠 Running prisma generate..."
npx prisma generate

echo "⚠️ Resolving failed migration manually..."
npx prisma migrate resolve --applied 20250622143015_init || true

echo "🚀 Deploying migrations..."
npx prisma migrate deploy
