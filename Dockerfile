# Utiliser Node.js 25
FROM node:25

# Définir le répertoire de travail
WORKDIR /app

# Copier uniquement les fichiers nécessaires pour installer les dépendances
COPY package.json pnpm-lock.yaml ./

# Installer pnpm globalement
RUN npm install -g pnpm

# Installer les dépendances sans frozen-lockfile
RUN pnpm install --no-frozen-lockfile

# Copier le reste du code
COPY . .

# Builder n8n (exclure @n8n/chat)
RUN npx turbo run build --filter=!@n8n/chat

# Exposer le port par défaut de n8n
EXPOSE 5678

# Commande pour lancer n8n
CMD ["pnpm", "run", "start"]
