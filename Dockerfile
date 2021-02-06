
# Instalando un contenedor con nodejs (NodeJs trae npm que vamos a usar)
FROM node AS builder

# Creamos un directorio para un contenedor
RUN mkdir -p /usr/src/app
# Nos posicionamos en el directorio que creamos
WORKDIR /usr/src/app
# Copiamos todo el contenido al directorio del contenedor
COPY . /usr/src/app

# Instalamos los complementos para angular
RUN npm install

# Generamos el empaquetado del proyecto
RUN $(npm bin)/ng build --prod --aot

FROM nginx
# Establecemos el directorio
WORKDIR /usr/share/nginx/html/
# Copiamos desde builder dist/app-soa a la ruta donde se muestra el contenedor
COPY --from=builder /usr/src/app/dist/app-soa/ /usr/share/nginx/html
# Puertos donde funciona el contenedor
EXPOSE 80 443
# 
CMD nginx -g 'daemon off;'

