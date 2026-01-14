FROM node:25-alpine

# Dossier de travail dans le container
WORKDIR /app

# On copie uniquement les fichiers nécessaires pour installer les dépendances
COPY package.json package-lock.json* ./

# Installation des dépendances
RUN npm install

# On copie le reste du projet
COPY . .

# Exposition du port Vite
EXPOSE 3000

# Commande de lancement en mode dev
CMD ["npm", "run", "dev", "--", "--host"]