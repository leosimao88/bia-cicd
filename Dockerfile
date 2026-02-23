FROM node:21

RUN npm install -g npm@latest --loglevel=error
WORKDIR /usr/src/app

# Instalar dependências do servidor
COPY package*.json ./
RUN npm install --loglevel=error

# Instalar dependências do client
COPY client/package*.json ./client/
RUN cd client && npm install

# Copiar código
COPY . .

# Build do React com mais memória
RUN cd client && NODE_OPTIONS="--max-old-space-size=2048" REACT_APP_API_URL=http://localhost:3001 SKIP_PREFLIGHT_CHECK=true npm run build

# Reorganizar arquivos
RUN mv client/build build && rm -rf client/* && mv build client/

EXPOSE 8080

CMD ["npm", "start"]
