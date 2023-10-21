###################
# BUILD FOR LOCAL DEVELOPMENT
###################

FROM node:18-alpine

WORKDIR app

COPY . .

RUN npm i
RUN npm run build

# Start the server using the production build
CMD [ "node", "dist/index.js" ]