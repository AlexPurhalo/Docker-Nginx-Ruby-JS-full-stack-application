### Global Environments file example
```
# env.list

POSTGRES_USER=alexpurhalo
POSTGRES_PASSWORD=123123
POSTGRES_DB=notes
DB_HOST=db
```

### Compose containers
```
docker-compose up
```

### Run containers
```
# run the database container
docker run -d --env-file env.list --name database -v $(pwd)/tmp/data/postgres:/var/lib/postgresql/data postgres

# build the server application image
docker build -t server_app_image --build-arg rack_env=development ./server 

# run the server application 
docker run -d --name server_app --link database:db --publish 3000:3000 --env-file env.list --volume $(pwd)/server:/server_app server_app_image start migrate

# build the client application image
docker build --build-arg node_env=development -t client_app_image ./client

# run the client application
docker run -d --name client_app -p 8080:8080 -v $(pwd)/client:/client_app client_app_image

# proxy reverse
docker run --rm -it --name nginx \
    -v $(pwd)/default.conf:/etc/nginx/conf.d/default.conf \
    -p 80:80 \
    --link server_app:server \
    --link client_app:client \
    nginx   
```

### Execute containers
```
# execute database throw sequel console
docker exec -it server_app rake console
 
# execute database throw postgres console
docker exec -it database bash -c 'psql -U "$POSTGRES_USER" -d "$POSTGRES_DB"'
```