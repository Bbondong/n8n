# Base image
FROM node:25

# Répertoire de travail
WORKDIR /app

# Copier seulement package.json et pnpm-lock.yaml d'abord pour installer deps
COPY package.json pnpm-lock.yaml ./

# Installer pnpm
RUN npm install -g pnpm

# Installer les dépendances
RUN pnpm install --no-frozen-lockfile

# Copier le reste du code
COPY . .

# Builder n8n
RUN npx turbo run build --filter=!@n8n/chat

# Exposer le port par défaut
EXPOSE 5678

# Commande de démarrage
CMD ["pnpm", "run", "start"]
