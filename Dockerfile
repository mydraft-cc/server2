FROM node:21-alpine3.18

# get git
RUN apk add --no-cache git bash

WORKDIR /mydraft

# setup the server
COPY . .

RUN npm i
RUN npm run build
RUN cp ./.env ./dist/

# setup react app
RUN git clone https://github.com/mydraft-cc/ui.git

RUN cd ./ui && echo "VITE_SERVER_URL=http://0.0.0.0:8001" > ./.env
RUN cd ./ui && rm -rf ./package-lock.json
RUN cd ./ui && npm install -g serve
RUN cd ./ui && npm install
RUN cd ./ui && npm run build
RUN cd ./ui && echo "VITE_SERVER_URL=http://0.0.0.0:8001" > ./dist/.env

RUN mkdir ./localFileStore
RUN chmod -R a+rw ./localFileStore

USER node
EXPOSE 8001/tcp
EXPOSE 3001/tcp

CMD ["./start.sh"]