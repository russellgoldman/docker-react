# Build Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
COPY . .
# 'RUN npm run build' creates the /build folder in our /app directory
RUN npm run build


# Run Phase (to start a new phase, write a FROM statement)
FROM nginx
# copy over something from our builder phase (FROM node:alpine as builder)
# /app/build is the folder we want to copy FROM
# /usr/share/nginx/html is the folder we HAVE to copy TO to have nginx render our HTML
COPY --from=builder /app/build /usr/share/nginx/html 

# once we call 'FROM nginx', our nginx container boots up automatically (no need to call it)