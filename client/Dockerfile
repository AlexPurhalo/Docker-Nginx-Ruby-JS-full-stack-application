FROM node:slim

ARG node_env
ENV NODE_ENV $node_env

WORKDIR /client_app

COPY package.json ./

RUN if [ ${NODE_ENV} = production ]; \
    then npm install --production \
    else npm install; fi

COPY . .

CMD if [ ${NODE_ENV} = production ]; \
    then npm run build && npm run start; \
    else npm run dev; fi

EXPOSE 8080

