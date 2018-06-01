### Usage

Start server
```
rake start 
```

Migrate schema
```
rake migrate
```

Database console
```
rake console
```

Receive notes
```
curl -X GET 'http://localhost:3000/api/v1/notes'
```

Add note
```
curl -X POST \
-d "{\"body\":\"Hello World\"}" \
-H "Content-Type: application/json" \
http://localhost:3000/api/v1/notes
```