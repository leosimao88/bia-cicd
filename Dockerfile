FROM node:22-slim

WORKDIR /usr/src/app

# Instalar dependências do servidor
COPY package*.json ./
RUN npm install --loglevel=error

# Copiar código
COPY . .

# Build do React
RUN SKIP_PREFLIGHT_CHECK=true npm run build --prefix client

# Reorganizar arquivos
RUN mv client/build build && rm -rf client/* && mv build client/

EXPOSE 8080

CMD ["npm", "start"]
