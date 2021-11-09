#   build is a random name to define the first phase of the docker file
FROM node:14.18 as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# --from says that we want to copy something over from another phase
COPY --from=builder /app/build /usr/share/nginx/html
# Note: nginx does not need a start command because it's by default