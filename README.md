### Usage
Create `env.list` file with such variables as bellow:  
```
# env.list

POSTGRES_USER=alexpurhalo
POSTGRES_PASSWORD=123123
POSTGRES_DB=notes
DB_HOST=db
```

For development
```
docker-compose up
```

For production
```
docker-compose build --build-arg node_env=production client ./client
docker-compose build --build-arg rack_env=production server ./server
docker-compose up -d
```


### Manual setup (optional)
Step 1. The Database container
```
# start server
docker run \
    --detach \
    --name database \
    --env-file env.list \
    --volume $(pwd)/tmp/data/postgres:/var/lib/postgresql/data \
    postgres
    
# execute database
docker exec \
    --interactive \
    --tty \
    database \
    bash -c 'psql -U "$POSTGRES_USER" -d "$POSTGRES_DB"'    
```

Step 2. The Server App container 
```
# build image
docker build \
    --build-arg rack_env=development \
    --tag server_app_image \
     ./server

# start server
docker run \
    --detach \
    --name server_app \
    --link database:db \
    --publish 3000:3000 \
    --env-file env.list \
    --volume $(pwd)/server:/server_app \
    server_app_image start migrate     

# access to console
docker exec \
    --interactive \
    --tty \
    server_app rake console

# execute tests
docker exec \
    --interactive \
    --tty \
    server_app rake test
```

Step 3. The Client App container
```
# build image
docker build \
    --build-arg node_env=development \
    --tag client_app_image \
    ./client

# start server
docker run \
    --detach \
    --name client_app \
    --publish 8080:8080 \
    --volume $(pwd)/client:/client_app \
    client_app_image
```

Step 4. The Proxy Reverse container
```
docker run \
    --detach \
    --name nginx \
    --volume $(pwd)/default.conf:/etc/nginx/conf.d/default.conf \
    --publish 80:80 \
    --link server_app:server \
    --link client_app:client \
    nginx   
```
