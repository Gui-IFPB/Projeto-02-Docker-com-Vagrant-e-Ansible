# Imagem base oficial do Nginx
FROM nginx:latest

# Instalar ping e curl
RUN apt-get update && apt-get install -y iputils-ping curl && rm -rf /var/lib/apt/lists/*

# Copiar configuração personalizada do Nginx
COPY nginx.conf /etc/nginx/nginx.conf

