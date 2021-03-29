# Hachiko

Hachiko is s loyal authentication and authorization system for APIs

<img src="public/images/hachiko.jpeg" alt="drawing" width="430">

<br><br>

# Local Setup

## Dependencies

Replace `WEATHER_API_KEY` value from docker-compose.yml  and add a valid key.
<br>Get the key from [here]('https://openweathermap.org/appid')

## Docker
```
docker-compose up
```

## Using default admin token
`Docker compose up` will run db seed and will create an admin account with `users:write` scope in development environment.

Search for `########### Initialized db with dev admin user and token` in the terminal docker log to get the access_token to be used initially.

## API Endpoints and params

```
          Prefix Verb   URI Pattern                 Controller#Action
weather_forecast GET    /weather/forecast(.:format) weather#forecast
 weather_current GET    /weather/current(.:format)  weather#current
           users POST   /users(.:format)            users#create
            user DELETE /users/:id(.:format)        users#destroy
          tokens POST   /tokens(.:format)           tokens#create
           token DELETE /tokens/:id(.:format)       tokens#destroy
```

### For all requests use `Authorization: Bearer <access token>` header

## API requests guide
 - GET /weather/forecast & /weather/current
     - lat (latitude of the location) (Required)
     - lng (longitude of the location) (Required)
 - POST /users
   - (Required)
   ```
     { email: 'email' }
   ```
 - DELETE /users/:id
 - POST /tokens
 - DELETE /toekns/:id