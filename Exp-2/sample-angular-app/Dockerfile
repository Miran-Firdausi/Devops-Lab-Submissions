# Stage 1: Base node for building and development
FROM node:18-alpine AS dev
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 4200
CMD ["npm", "start"]

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=builder /app/dist/hello-world-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]